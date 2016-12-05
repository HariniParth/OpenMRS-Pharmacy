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
import org.openmrs.Concept;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.api.drugordersdiseasesService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.module.drugorders.drugordersdiseases;
import org.openmrs.ui.framework.page.PageModel;

/**
 *
 * @author harini-geek
 */
public class CurrentPlanGroupOrdersFragmentController {
    
    public void controller(PageModel model){
        
        List<Patient> patients = Context.getPatientService().getAllPatients();
        
        //Storing all the Med Plan Orders by Patient and Plan
        HashMap<Integer,HashMap<String,List<drugorders>>> patientPlanOrders = new HashMap<Integer,HashMap<String,List<drugorders>>>();

        //Storing Patient Names by Patient ID
        HashMap<Integer,String> patientName = new HashMap<Integer,String>();
       
        //Storing Patient DOB by Patient ID
        HashMap<Integer,Date> patientDOB = new HashMap<Integer,Date>();

        for(Patient patient : patients){
            
            List<drugordersdiseases> plans = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPatient(patient);
            List<String> planNames = new ArrayList<String>();
            
            if(plans.size() > 0){
                for(drugordersdiseases plan : plans){
                    if(!planNames.contains(plan.getDiseaseid().getDisplayString())){
                        planNames.add(plan.getDiseaseid().getDisplayString());
                    }
                }
            }
            
            if(planNames.size() > 0){
                
                HashMap<String,List<drugorders>> patientOrders = new HashMap<String,List<drugorders>>();
                    
                for(String planName : planNames) {
                    Concept planConcept = Context.getConceptService().getConceptByName(planName);
                    
                    List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(planConcept, patient);
                    
                    List<drugorders> drugorders = new ArrayList<drugorders>();
                    
                    List<Integer> orders = new ArrayList<Integer>();
                    
                    for(drugordersdiseases planOrder : planOrders){
                        orders.add(planOrder.getOrderid());
                    }
                    
                    for(Integer order: orders){
                        drugorders dOrderExtn = Context.getService(drugordersService.class).getDrugOrderByOrderID(order);
                        
                        if(dOrderExtn.getOrderstatus().equals("Active-Plan")){
                            drugorders.add(dOrderExtn);
                        }
                    }
                    if(drugorders.size() > 0)
                        patientOrders.put(planName, drugorders);
                }
                
                patientName.put(patient.getPatientId(), patient.getGivenName()+" "+patient.getFamilyName());
                patientDOB.put(patient.getPatientId(),patient.getBirthdate());
                patientPlanOrders.put(patient.getPatientId(), patientOrders);
            }
        }
        
        model.addAttribute("patientPlanOrders", patientPlanOrders);
        model.addAttribute("patientName", patientName);
        model.addAttribute("patientDOB", patientDOB);

    }
}
