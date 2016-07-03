/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import java.util.ArrayList;
import java.util.List;
import org.openmrs.DrugOrder;
import org.openmrs.Order;
import org.openmrs.Patient;
import org.openmrs.PersonName;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;

/**
 *
 * @author harini-geek
 */
public class PharmacyPageController {
    
    public void controller(PageModel model){
        
        ArrayList<Order> currentOrders = new ArrayList<Order>();
        ArrayList<drugorders> currentDrugOrders = new ArrayList<drugorders>();
        ArrayList<Patient> patientWithOrders = new ArrayList<Patient>();
        ArrayList<PersonName> patientFullNameList = new ArrayList<PersonName>();
        
        List<Patient> patients = Context.getPatientService().getAllPatients();
        for(Patient patient : patients){
            PersonName patientFullName = Context.getPersonService().getPersonName(patient.getPatientId());
            List<Order> orders = Context.getOrderService().getAllOrdersByPatient(patient);
            int drugOrderTypeId = Context.getOrderService().getOrderTypeByName("Drug Order").getOrderTypeId();
            for(Order order : orders){
                if(order.getOrderType().getOrderTypeId() == drugOrderTypeId){
                    currentOrders.add(order);
                    drugorders dorder = Context.getService(drugordersService.class).getNewTable(order.getOrderId());
                    currentDrugOrders.add(dorder);
                    patientWithOrders.add(patient);
                    patientFullNameList.add(patientFullName);
                }
            }
        }
        model.addAttribute("currentOrders", currentOrders);
        model.addAttribute("currentDrugOrders", currentDrugOrders);
        model.addAttribute("patientWithOrders", patientWithOrders);
        model.addAttribute("patientFullNameList", patientFullNameList);
    }
}