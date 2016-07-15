/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import org.openmrs.DrugOrder;
import org.openmrs.Order;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;

/**
 *
 * @author harini-geek
 */
public class CurrentDrugOrdersFragmentController {
    
    public void controller(PageModel model){
        
        ArrayList<drugorders> currentDrugOrdersExtension = new ArrayList<drugorders>();
        ArrayList<DrugOrder> currentDrugOrderMain = new ArrayList<DrugOrder>();
        ArrayList<Patient> patientWithOrders = new ArrayList<Patient>();
        Hashtable<Integer,String> patientNames = new Hashtable<Integer,String>();
        Hashtable<Integer,String> patientIdentifiers = new Hashtable<Integer,String>();
        
        List<Patient> patients = Context.getPatientService().getAllPatients();
        for(Patient patient : patients){
            List<Order> orders = Context.getOrderService().getAllOrdersByPatient(patient);
            int drugOrderTypeId = Context.getOrderService().getOrderTypeByName("Drug Order").getOrderTypeId();
            for(Order order : orders){
                if(order.getOrderType().getOrderTypeId() == drugOrderTypeId){
                    drugorders dorderExtension = Context.getService(drugordersService.class).getNewTable(order.getOrderId());
                    currentDrugOrdersExtension.add(dorderExtension);
                    
                    DrugOrder dorderMain = (DrugOrder) Context.getOrderService().getOrder(order.getOrderId());
                    currentDrugOrderMain.add(dorderMain);
                    
                    patientWithOrders.add(patient);
                    patientNames.put(patient.getPatientId(),Context.getPersonService().getPerson(patient).getGivenName()+" "+Context.getPersonService().getPerson(patient).getFamilyName());
                    
                    patientIdentifiers.put(patient.getPatientId(),Context.getPatientService().getPatientByExample(patient).getPatientIdentifier().getIdentifier());
                }
            }
        }
        
        model.addAttribute("currentDrugOrdersExtension", currentDrugOrdersExtension);
        model.addAttribute("currentDrugOrdersMain", currentDrugOrderMain);
        model.addAttribute("patientsWithOrder", patientWithOrders);
        model.addAttribute("patientNames", patientNames);
        model.addAttribute("patientIdentifiers", patientIdentifiers);
    }
    
}
