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
import org.openmrs.api.APIException;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.api.drugordersdiseasesService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.module.drugorders.drugordersdiseases;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class SearchGroupViewFragmentController {
    
    public void controller(PageModel model,
                            @RequestParam(value = "patient_full_name", required = false) String patient_full_name,
                            @RequestParam(value = "action", required = false) String action){
        
        String patient_name = patient_full_name.trim();
        model.addAttribute("patient_name", patient_name);
        Date patient_DOB = null;
        
        HashMap<Integer,drugorders> SingleOrders = new HashMap<Integer,drugorders>();
        HashMap<Integer,List<drugorders>> GroupOrders = new HashMap<Integer,List<drugorders>>();
        HashMap<Integer,List<drugorders>> PlanOrders = new HashMap<Integer,List<drugorders>>();

        if(!(patient_name).equals("")){
            try {
                boolean patient_found = false;
                Patient selectedPatient = null;

                List<Patient> patients = Context.getPatientService().getAllPatients();
                
                for(Patient patient : patients){
                    
                    if((patient.getGivenName()+" "+patient.getFamilyName()).equals(patient_name)){
                        selectedPatient = patient;
                        patient_DOB = patient.getBirthdate();
                        patient_found = true;
                        model.addAttribute("PatientFound", patient_found);
                    }
                    if(patient_found)
                        break;
                }
                
                List<drugorders> allOrders = Context.getService(drugordersService.class).getDrugOrdersByPatient(selectedPatient);
                
                for(drugorders order : allOrders){
                    
                    if(order.getOrderstatus().equals("Active") && !SingleOrders.containsKey(order.getOrderId())){
                        SingleOrders.put(order.getOrderId(), order);
                    }
                    else if(order.getOrderstatus().equals("Active-Group") && !GroupOrders.containsKey(order.getGroupid())){
                        GroupOrders.put(order.getGroupid(), Context.getService(drugordersService.class).getDrugOrdersByGroupID(order.getGroupid()));
                    }
                    else if(order.getOrderstatus().equals("Active-Plan") && !GroupOrders.containsKey(order.getAssociateddiagnosis().getConceptId())){
                        
                        drugordersdiseases plan = Context.getService(drugordersdiseasesService.class).getDrugOrderByOrderID(order.getOrderId());
                        
                        List<drugordersdiseases> plansByPatient = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPlan(plan.getPlanid());
                        
                        List<drugorders> drugorders = new ArrayList<drugorders>();
                        
                        for(drugordersdiseases planByPatient : plansByPatient){
                            
                            drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByID(planByPatient.getOrderid());
                            if(drugorder.getOrderstatus().equals("Active-Plan"))
                                drugorders.add(drugorder);
                        }
                        
                        PlanOrders.put(plan.getDiseaseid().getConceptId(), drugorders);
                    }
                }
                
                if(!patient_found){
                    model.addAttribute("PatientFound", patient_found);
                }
                
            } catch (NumberFormatException e){
                System.out.println(e.toString());
            } catch (APIException e) {
                System.out.println(e.toString());
            }
        }
        
        model.addAttribute("SingleOrders", SingleOrders);
        model.addAttribute("GroupOrders", GroupOrders);
        model.addAttribute("PlanOrders", PlanOrders);
        model.addAttribute("patient_DOB", patient_DOB);
        
    }
}
