/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import java.util.ArrayList;
import java.util.List;
import org.openmrs.Order;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class PharmacyPageController {
    
    public void controller(PageModel model,
                            @RequestParam(value = "order_id_display", required = false) String order_id_display,
                            @RequestParam(value = "start_date_display", required = false) String start_date_display,
                            @RequestParam(value = "selected_order_id_display", required = false) String selected_order_id_display){
        
        ArrayList<drugorders> currentDrugOrders = new ArrayList<drugorders>();
        ArrayList<Patient> patientWithOrders = new ArrayList<Patient>();
        
        List<Patient> patients = Context.getPatientService().getAllPatients();
        for(Patient patient : patients){
            List<Order> orders = Context.getOrderService().getAllOrdersByPatient(patient);
            int drugOrderTypeId = Context.getOrderService().getOrderTypeByName("Drug Order").getOrderTypeId();
            for(Order order : orders){
                if(order.getOrderType().getOrderTypeId() == drugOrderTypeId){
                    drugorders dorder = Context.getService(drugordersService.class).getNewTable(order.getOrderId());
                    currentDrugOrders.add(dorder);
                    patientWithOrders.add(patient);
                }
            }
        }
        model.addAttribute("currentDrugOrders", currentDrugOrders);
        model.addAttribute("patientWithOrders", patientWithOrders);
        model.addAttribute("order_id_display", order_id_display);
        model.addAttribute("start_date_display", start_date_display);
    }
}