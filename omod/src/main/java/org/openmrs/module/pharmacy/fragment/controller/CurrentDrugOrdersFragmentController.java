/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.openmrs.Patient;
import org.openmrs.Person;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class CurrentDrugOrdersFragmentController {
    
    public void controller(PageModel model, @RequestParam("patientId") Patient patient){
        
        List<drugorders> allOrders = Context.getService(drugordersService.class).getDrugOrdersByPatient(patient);
        
        List<drugorders> patientOrders = new ArrayList<>();
        HashMap<Integer, String> OrdererName = new HashMap<>();
        
        for(drugorders order : allOrders){
            if(order.getOrderStatus().equals("Active") || order.getOrderStatus().equals("Active-Group") || order.getOrderStatus().equals("Active-Plan")){
                patientOrders.add(order);
                Person person = Context.getOrderService().getOrder(order.getOrderId()).getOrderer().getPerson();
                OrdererName.put(order.getOrderId(), person.getGivenName()+" "+person.getFamilyName());
            } 
        }
        
        model.addAttribute("OrdererName", OrdererName);
        model.addAttribute("patientOrders", patientOrders);
    }    
}
