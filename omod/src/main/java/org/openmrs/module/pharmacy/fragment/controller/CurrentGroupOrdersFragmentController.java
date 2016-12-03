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

        //Storing all the Single Orders by Patient
        HashMap<Integer,drugorders> patientSingleOrders = new HashMap<Integer,drugorders>();

        //Storing Patient Names by Patient ID
        HashMap<Integer,String> patientName = new HashMap<Integer,String>();
       
        //Storing Patient DOB by Patient ID
        HashMap<Integer,Date> patientDOB = new HashMap<Integer,Date>();
        
        for(Patient patient : patients){
            
            List<drugorders> allPatientOrders = Context.getService(drugordersService.class).getDrugOrdersByPatient(patient);
            HashMap<Integer,List<drugorders>> patientGroups = new HashMap<Integer,List<drugorders>>();
            
            for(drugorders patientOrders : allPatientOrders){
                
                //For the given Patient, fetch all the Group Orders
                if(!patientGroups.containsKey(patientOrders.getGroupid()) && patientOrders.getOrderstatus().equals("Active-Group")){
                    List<drugorders> groupOrders = Context.getService(drugordersService.class).getDrugOrdersByGroupID(patientOrders.getGroupid());
                    List<drugorders> activeGroupOrders = new ArrayList<drugorders>();
                    
                    //Filter the Orders in the Group that are currently Active
                    for(drugorders order : groupOrders){
                        if(order.getOrderstatus().equals("Active-Group")){
                            activeGroupOrders.add(order);
                        }
                    }
                    patientGroups.put(patientOrders.getGroupid(),activeGroupOrders);
                }
                else if (patientOrders.getOrderstatus().equals("Active")){
                    patientSingleOrders.put(Integer.parseInt(patientOrders.getPatientid()), patientOrders);
                }
            }
            
            patientGroupOrders.put(patient.getPatientId(), patientGroups);
            patientName.put(patient.getPatientId(), patient.getGivenName() + " " + patient.getFamilyName());
            patientDOB.put(patient.getPatientId(), patient.getBirthdate());
        }
        
        model.addAttribute("patientGroupOrders", patientGroupOrders);
        model.addAttribute("patientSingleOrders", patientSingleOrders);
        model.addAttribute("patientName", patientName);
        model.addAttribute("patientDOB", patientDOB);
    }
}
