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
import java.util.Date;
import org.openmrs.Concept;
import org.openmrs.Order;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.api.drugordersdiseasesService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.module.drugorders.drugordersdiseases;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.util.StringUtils;

/**
 *
 * @author harini-geek
 */
public class CurrentMedPlansFragmentController {
    
    public void controller(PageModel model){
        
        List<Patient> patients = Context.getPatientService().getAllPatients();
        
        //Storing list of Med Plan Names ordered for the patient
        HashMap<Integer,List<String>> patientPlans = new HashMap<Integer,List<String>>();
        
        //Storing all the Med Plan Orders by Patient by Plan - Drug Order data
        HashMap<Integer,HashMap<String,List<DrugOrder>>> patientPlanOrdersMain = new HashMap<Integer,HashMap<String,List<DrugOrder>>>();
        
        //Storing all the Med Plan Orders by Patient by Plan - Drug Order Extension data
        HashMap<Integer,drugorders> patientPlanOrdersExtn = new HashMap<Integer,drugorders>();
        
        //Storing all the related Orders of the selected Order (other Orders in same Plan)
        HashMap<Integer,HashMap<String,List<String>>> otherOrdersByPatients = new HashMap<Integer,HashMap<String,List<String>>>();
        
        HashMap<Integer,String> patientName = new HashMap<Integer,String>();
        HashMap<Integer,Date> patientDOB = new HashMap<Integer,Date>();
        HashMap<Integer,String> patientAddress = new HashMap<Integer,String>();
        HashMap<Integer,String> patientIdentifiers = new HashMap<Integer,String>();
        HashMap<Integer,String> providerIdentifiers = new HashMap<Integer,String>();
        
        for(Patient patient : patients){
            
            List<drugordersdiseases> plans = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPatient(patient);
            List<String> planNames = new ArrayList<String>();
            
            if(plans.size() > 0){
                for(drugordersdiseases plan : plans){
                    if(!planNames.contains(plan.getDiseaseid().getDisplayString())){
                        planNames.add(plan.getDiseaseid().getDisplayString());
                    }
                }
                patientPlans.put(patient.getPatientId(), planNames);
            }
            
            if(planNames.size() > 0){
                
                HashMap<String,List<DrugOrder>> mainOrder = new HashMap<String,List<DrugOrder>>();
                HashMap<String,List<String>> otherOrdersPlans = new HashMap<String,List<String>>();
                        
                for(String planName : planNames) {
                    Concept planConcept = Context.getConceptService().getConceptByName(planName);
                    List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(planConcept, Integer.toString(patient.getPatientId()));
                    List<Integer> orders = new ArrayList<Integer>();
                    ArrayList<String> otherOrders = new ArrayList<String>();
                    
                    for(drugordersdiseases planOrder : planOrders){
                        orders.add(planOrder.getOrderid());
                    }
                    
                    List<DrugOrder> orderMain = new ArrayList<DrugOrder>();
                    
                    for(Integer order: orders){
                        drugorders dOrderExtn = Context.getService(drugordersService.class).getDrugOrderByOrderID(order);
                        
                        if(dOrderExtn.getOrderstatus().equals("Active-Plan")){
                            patientPlanOrdersExtn.put(dOrderExtn.getOrderId(), dOrderExtn);
                            
                            DrugOrder dOrderMain = (DrugOrder) Context.getOrderService().getOrder(order);
                            orderMain.add(dOrderMain);

                            Order o = Context.getOrderService().getOrder(order);
                            providerIdentifiers.put(o.getOrderId(), o.getOrderer().getPerson().getGivenName() + " " + o.getOrderer().getPerson().getFamilyName() + ", " + StringUtils.capitalize(o.getOrderer().getIdentifier()));
                        
                            otherOrders.add(dOrderExtn.getDrugname().getDisplayString());
                            
                        }
                    }
                    if(otherOrders.size() == 1)
                        otherOrders.add("Nil");
                    
                    if(orderMain.size() > 0){
                        mainOrder.put(planName, orderMain);
                        otherOrdersPlans.put(planName, otherOrders);
                        patientPlanOrdersMain.put(patient.getPatientId(), mainOrder);
                    }
                }
                
                patientName.put(patient.getPatientId(), patient.getGivenName()+" "+patient.getFamilyName());
                patientDOB.put(patient.getPatientId(),patient.getBirthdate());
                patientAddress.put(patient.getPatientId(), patient.getPersonAddress().getAddress1()+" "+patient.getPersonAddress().getCityVillage()+" "+patient.getPersonAddress().getStateProvince()+"Zipcode: "+patient.getPersonAddress().getPostalCode()+" "+patient.getPersonAddress().getCountry());
                patientIdentifiers.put(patient.getPatientId(), patient.getPatientIdentifier().toString());
                otherOrdersByPatients.put(patient.getPatientId(), otherOrdersPlans);
            }
        }
        
        model.addAttribute("patientPlans", patientPlans);
        model.addAttribute("patientPlanOrdersMain", patientPlanOrdersMain);
        model.addAttribute("patientPlanOrdersExtn", patientPlanOrdersExtn);
        model.addAttribute("patientName", patientName);
        model.addAttribute("patientDOB", patientDOB);
        model.addAttribute("patientAddress", patientAddress);
        model.addAttribute("patientIdentifiers", patientIdentifiers);
        model.addAttribute("providerIdentifiers", providerIdentifiers);
        model.addAttribute("otherOrdersByPatients", otherOrdersByPatients);

    }
}
