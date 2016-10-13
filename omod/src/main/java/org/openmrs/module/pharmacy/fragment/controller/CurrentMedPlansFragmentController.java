/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.openmrs.DrugOrder;
import org.openmrs.Patient;
import java.lang.Integer;
import org.openmrs.Concept;
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
public class CurrentMedPlansFragmentController {
    
    public void controller(PageModel model){
        
        List<Patient> patients = Context.getPatientService().getAllPatients();
        
        HashMap<String,List<String>> patientPlans = new HashMap<String,List<String>>();
        
        HashMap<String,HashMap<String,List<DrugOrder>>> patientPlanOrdersMain = new HashMap<String,HashMap<String,List<DrugOrder>>>();
        
        HashMap<Integer,drugorders> patientPlanOrdersExtn = new HashMap<Integer,drugorders>();
        
        for(Patient patient : patients){
            
            List<drugordersdiseases> plans = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPatient(Integer.toString(patient.getPatientId()));
            List<String> planNames = new ArrayList<String>();
            
            if(plans.size() > 0){
                for(drugordersdiseases plan : plans){
                    if(!planNames.contains(plan.getDiseaseid().getDisplayString())){
                        planNames.add(plan.getDiseaseid().getDisplayString());
                    }
                }
                patientPlans.put(patient.getGivenName()+" "+patient.getFamilyName(), planNames);
            }
            
            HashMap<String,List<DrugOrder>> mainOrder = new HashMap<String,List<DrugOrder>>();
            HashMap<String,List<drugorders>> extnOrder = new HashMap<String,List<drugorders>>();
        
            if(planNames.size() > 0){
                for(String planName : planNames) {
                    Concept planConcept = Context.getConceptService().getConceptByName(planName);
                    List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(planConcept, Integer.toString(patient.getPatientId()));
                    List<Integer> orders = new ArrayList<Integer>();
                    
                    for(drugordersdiseases planOrder : planOrders){
                        orders.add(planOrder.getOrderid());
                    }
                    
                    List<DrugOrder> orderMain = new ArrayList<DrugOrder>();
                    
                    for(Integer order: orders){
                        DrugOrder dOrderMain = (DrugOrder) Context.getOrderService().getOrder(order);
                        orderMain.add(dOrderMain);
                        
                        drugorders dOrderExtn = Context.getService(drugordersService.class).getDrugOrderByOrderID(order);
                        patientPlanOrdersExtn.put(dOrderExtn.getOrderId(), dOrderExtn);
                    }
                    
                    mainOrder.put(planName, orderMain);
                    
                    patientPlanOrdersMain.put(patient.getGivenName()+" "+patient.getFamilyName(), mainOrder);
                }
            }
        }
        model.addAttribute("patientPlans", patientPlans);
        model.addAttribute("patientPlanOrdersMain", patientPlanOrdersMain);
        model.addAttribute("patientPlanOrdersExtn", patientPlanOrdersExtn);
    }
}
