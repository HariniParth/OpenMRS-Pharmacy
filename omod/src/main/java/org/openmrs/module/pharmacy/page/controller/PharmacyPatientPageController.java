/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import com.google.common.collect.Iterables;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.openmrs.Patient;
import org.openmrs.Person;
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
public class PharmacyPatientPageController {
    
    public void controller(PageModel model, @RequestParam(value = "patient_full_name", required = false) String patient_full_name){
        
        List<Patient> allPatients = Context.getPatientService().getAllPatients();
        
        String searchPatient = patient_full_name.trim();
        
        if(!searchPatient.equals("")){
            for(Patient patient : allPatients){
                if((patient.getGivenName()+" "+patient.getFamilyName()).equals(searchPatient)){
                    model.addAttribute("patient", patient);
                }
            }
        } else {
            model.addAttribute("patient", "");
        }
        
        List<drugorders> ordersOnHold = Context.getService(drugordersService.class).getOrdersOnHold();
        List<drugorders> ordersForDiscard = Context.getService(drugordersService.class).getOrdersForDiscard();
        
        List<drugorders> patientSingleOrders = new ArrayList<drugorders>();
        HashMap<Integer, List<drugorders>> patientGroupOrders = new HashMap<Integer, List<drugorders>>();
        HashMap<Integer, List<drugorders>> patientPlanOrders = new HashMap<Integer, List<drugorders>>();
        
        HashMap<Integer,String> ordererName = new HashMap<Integer,String>();
        
        for(drugorders order: Iterables.concat(ordersOnHold, ordersForDiscard)){
            Person physician = Context.getPersonService().getPerson(Context.getOrderService().getOrder(order.getOrderId()).getOrderer().getProviderId());
            ordererName.put(order.getOrderId(), physician.getGivenName()+" "+physician.getFamilyName());
            
            if(order.getOrderstatus().equals("Active")){
                patientSingleOrders.add(order);
            } 
            else if(order.getOrderstatus().equals("Active-Group")){
                if(!patientGroupOrders.containsKey(order.getGroupid())){

                    List<drugorders> allGroupOrders = Context.getService(drugordersService.class).getDrugOrdersByGroupID(order.getGroupid());

                    List<drugorders> activeGroupOrders = new ArrayList<drugorders>();

                    for(drugorders groupOrder : allGroupOrders){
                        if(groupOrder.getOrderstatus().equals("Active-Group")){
                            activeGroupOrders.add(groupOrder);
                        }
                    }
                    patientGroupOrders.put(order.getGroupid(), activeGroupOrders);
                }
            } 
            else if(order.getOrderstatus().equals("Active-Plan")){
                drugordersdiseases planOrder = Context.getService(drugordersdiseasesService.class).getDrugOrderByOrderID(order.getOrderId());

                if(!patientPlanOrders.containsKey(planOrder.getPlanid())){

                    List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPlanID(planOrder.getPlanid());

                    List<drugorders> activePlanOrders = new ArrayList<drugorders>();

                    for(drugordersdiseases plan : planOrders){
                        if(Context.getService(drugordersService.class).getDrugOrderByOrderID(plan.getOrderid()).getOrderstatus().equals("Active-Plan")){
                            activePlanOrders.add(Context.getService(drugordersService.class).getDrugOrderByOrderID(plan.getOrderid()));
                        }
                    }
                    patientPlanOrders.put(planOrder.getPlanid(), activePlanOrders);
                }
            }
        }
        model.addAttribute("ordererName", ordererName);
        model.addAttribute("patientSingles", patientSingleOrders);
        model.addAttribute("patientGroups", patientGroupOrders);
        model.addAttribute("patientPlans", patientPlanOrders);
    }
}
