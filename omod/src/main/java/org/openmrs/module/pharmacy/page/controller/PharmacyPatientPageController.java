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
    
    public void controller(PageModel model, @RequestParam(value = "patient_full_name", required = false) String patient_full_name,
                                            @RequestParam(value = "orderType", required = false) String orderType,
                                            @RequestParam(value = "orderNum", required = false) Integer orderNum){
        
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
        
        if(!orderType.equals("")){
            if(orderType.equals("SINGLE")){
                drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(orderNum);
                if(drugorder.getOnHold() == 1)
                    drugorder.setOnHold(0);
            } 
            else
                if(orderType.equals("GROUP")){
                    List<drugorders> drugorders = Context.getService(drugordersService.class).getDrugOrdersByGroupID(orderNum);
                    for(drugorders drugorder : drugorders){
                        if(drugorder.getOnHold() == 1)
                            drugorder.setOnHold(0);
                    }
                }
            else
                if(orderType.equals("PLAN")){
                    List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPlanID(orderNum);
                    for(drugordersdiseases planOrder : planOrders){
                        drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(planOrder.getOrderId());
                        if(drugorder.getOnHold() == 1)
                            drugorder.setOnHold(0);
                    }
                }
        }
        
        List<drugorders> ordersOnHold = Context.getService(drugordersService.class).getOrdersOnHold();
        List<drugorders> ordersForDiscard = Context.getService(drugordersService.class).getOrdersForDiscard();
        
        List<drugorders> patientSingleOrders = new ArrayList<>();
        HashMap<Integer, List<drugorders>> patientGroupOrders = new HashMap<>();
        HashMap<Integer, List<drugorders>> patientPlanOrders = new HashMap<>();
        
        HashMap<Integer,String> ordererName = new HashMap<>();
        HashMap<Integer,String> patientName = new HashMap<>();
        
        for(drugorders order: Iterables.concat(ordersOnHold, ordersForDiscard)){
            Person physician = Context.getPersonService().getPerson(Context.getOrderService().getOrder(order.getOrderId()).getOrderer().getProviderId());
                        
            if(order.getOrderStatus().equals("Active")){
                patientSingleOrders.add(order);
                ordererName.put(order.getOrderId(), physician.getGivenName()+" "+physician.getFamilyName());
            } 
            else if(order.getOrderStatus().equals("Active-Group")){
                if(!patientGroupOrders.containsKey(order.getGroupId())){

                    List<drugorders> allGroupOrders = Context.getService(drugordersService.class).getDrugOrdersByGroupID(order.getGroupId());

                    List<drugorders> activeGroupOrders = new ArrayList<>();

                    for(drugorders groupOrder : allGroupOrders){
                        if(groupOrder.getOrderStatus().equals("Active-Group")){
                            activeGroupOrders.add(groupOrder);
                            ordererName.put(groupOrder.getOrderId(), physician.getGivenName()+" "+physician.getFamilyName());
                        }
                    }
                    patientGroupOrders.put(order.getGroupId(), activeGroupOrders);
                }
            } 
            else if(order.getOrderStatus().equals("Active-Plan")){
                drugordersdiseases planOrder = Context.getService(drugordersdiseasesService.class).getDrugOrderByOrderID(order.getOrderId());

                if(!patientPlanOrders.containsKey(planOrder.getPlanId())){

                    List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPlanID(planOrder.getPlanId());

                    List<drugorders> activePlanOrders = new ArrayList<>();

                    for(drugordersdiseases plan : planOrders){
                        if(Context.getService(drugordersService.class).getDrugOrderByOrderID(plan.getOrderId()).getOrderStatus().equals("Active-Plan")){
                            activePlanOrders.add(Context.getService(drugordersService.class).getDrugOrderByOrderID(plan.getOrderId()));
                            ordererName.put(plan.getOrderId(), physician.getGivenName()+" "+physician.getFamilyName());
                        }
                    }
                    patientPlanOrders.put(planOrder.getPlanId(), activePlanOrders);
                }
            }
            //Store the list of Patient's name who have an Order that is On-Hold or For-Discard
            if(!patientName.containsKey(Integer.parseInt(order.getPatientId()))){
                Patient patient = Context.getPatientService().getPatient(Integer.parseInt(order.getPatientId()));
                patientName.put(Integer.parseInt(order.getPatientId()), patient.getGivenName()+" "+patient.getFamilyName());
            }
        }
        model.addAttribute("patientName", patientName);
        model.addAttribute("ordererName", ordererName);
        model.addAttribute("patientSingles", patientSingleOrders);
        model.addAttribute("patientGroups", patientGroupOrders);
        model.addAttribute("patientPlans", patientPlanOrders);
    }
}
