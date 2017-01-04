/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class CurrentGroupOrdersFragmentController {
    
    public void controller(PageModel model, @RequestParam("patientId") Patient patient){
        
        List<drugorders> allOrders = Context.getService(drugordersService.class).getDrugOrdersByPatient(patient);
        
        List<drugorders> patientSingleOrders = new ArrayList<drugorders>();
        
        HashMap<Integer, List<drugorders>> patientGroupOrders = new HashMap<Integer, List<drugorders>>();
        
        HashMap<Integer, List<drugorders>> patientPlanOrders = new HashMap<Integer, List<drugorders>>();
        
        HashMap<Integer, Concept> planName = new HashMap<Integer, Concept>();
        
        for(drugorders order : allOrders){
            if(order.getOrderstatus().equals("Active")){
                patientSingleOrders.add(order);
            } else
                if(order.getOrderstatus().equals("Active-Group")){
                    if(!patientGroupOrders.containsKey(order.getGroupid())){
                        patientGroupOrders.put(order.getGroupid(), Context.getService(drugordersService.class).getDrugOrdersByGroupID(order.getGroupid()));
                    }
            } else
                if(order.getOrderstatus().equals("Active-Plan")){
                    drugordersdiseases planOrder = Context.getService(drugordersdiseasesService.class).getDrugOrderByOrderID(order.getOrderId());
                    
                    if(!patientPlanOrders.containsKey(planOrder.getPlanid())){
                        
                        List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPlan(planOrder.getPlanid());
                        
                        List<drugorders> activePlanOrders = new ArrayList<drugorders>();
                        
                        for(drugordersdiseases plan : planOrders){
                            if(Context.getService(drugordersService.class).getDrugOrderByOrderID(plan.getOrderid()).getOrderstatus().equals("Active-Plan")){
                                activePlanOrders.add(Context.getService(drugordersService.class).getDrugOrderByOrderID(plan.getOrderid()));
                            }
                        }
                        
                        patientPlanOrders.put(planOrder.getPlanid(), activePlanOrders);
                        planName.put(planOrder.getPlanid(), planOrder.getDiseaseid());
                    }
            }
        }
        
        model.addAttribute("patientSingleOrders", patientSingleOrders);
        model.addAttribute("patientGroupOrders", patientGroupOrders);
        model.addAttribute("patientPlanOrders", patientPlanOrders);
        model.addAttribute("planName", planName);
    }
}
