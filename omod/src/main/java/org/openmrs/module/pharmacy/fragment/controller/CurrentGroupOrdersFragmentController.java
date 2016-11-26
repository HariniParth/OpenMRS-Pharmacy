/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;

/**
 *
 * @author harini-geek
 */
public class CurrentGroupOrdersFragmentController {
    
    public void controller(PageModel model){
        
        List<Patient> patients = Context.getPatientService().getAllPatients();
        
        //Storing all the Group Orders by Patient
        HashMap<Integer,HashMap<Integer,List<drugorders>>> patientGroupOrders = new HashMap<Integer,HashMap<Integer,List<drugorders>>>();

        //Storing Patient Names by Patient ID
        HashMap<Integer,String> patientName = new HashMap<Integer,String>();
       
        //Storing Patient DOB by Patient ID
        HashMap<Integer,Date> patientDOB = new HashMap<Integer,Date>();
        
        for(Patient patient : patients){
            
            List<drugorders> allPatientOrders = Context.getService(drugordersService.class).getDrugOrdersByPatient(patient);
            HashMap<Integer,List<drugorders>> patientGroups = new HashMap<Integer,List<drugorders>>();
            
            for(drugorders patientOrders : allPatientOrders){
                
                if(!patientGroups.containsKey(patientOrders.getGroupid()) || !patientGroups.containsKey(patientOrders.getOrderId())){
                    
                    if(patientOrders.getOrderstatus().equals("Active") || patientOrders.getOrderstatus().equals("Active-Group")){
                        
                        if(patientOrders.getGroupid() != null){
                            patientGroups.put(patientOrders.getGroupid(),Context.getService(drugordersService.class).getDrugOrdersByGroupID(patientOrders.getGroupid()));
                        } else {
                            List<drugorders> drugorders = new ArrayList<drugorders>();
                            drugorders.add(patientOrders);
                            patientGroups.put(patientOrders.getOrderId(),drugorders);
                        }
                    }
                }
            }
            
            patientGroupOrders.put(patient.getPatientId(), patientGroups);
            patientName.put(patient.getPatientId(), patient.getGivenName() + " " + patient.getFamilyName());
            patientDOB.put(patient.getPatientId(), patient.getBirthdate());
        }
        
        model.addAttribute("patientPlanOrders", patientGroupOrders);
        model.addAttribute("patientName", patientName);
        model.addAttribute("patientDOB", patientDOB);
    }
}
