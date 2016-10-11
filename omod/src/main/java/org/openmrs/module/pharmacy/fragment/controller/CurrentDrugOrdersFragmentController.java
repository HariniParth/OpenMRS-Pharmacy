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
import org.openmrs.DrugOrder;
import org.openmrs.Order;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.util.StringUtils;

/**
 *
 * @author harini-geek
 */
public class CurrentDrugOrdersFragmentController {
    
    public void controller(PageModel model){
        
        HashMap<Integer,DrugOrder> currentDrugOrderMain = new HashMap<Integer,DrugOrder>();
        ArrayList<drugorders> currentDrugOrdersExtension = new ArrayList<drugorders>();
        ArrayList<Patient> patientWithOrders = new ArrayList<Patient>();
        
        HashMap<Integer,String> patientNames = new HashMap<Integer,String>();
        HashMap<Integer,Date> patientDOB = new HashMap<Integer,Date>();
        HashMap<Integer,String> patientAddress = new HashMap<Integer,String>();
        HashMap<Integer,String> patientIdentifiers = new HashMap<Integer,String>();
        HashMap<Integer,String> providerIdentifiers = new HashMap<Integer,String>();
        
        List<Patient> patients = Context.getPatientService().getAllPatients();
        for(Patient patient : patients){
            
            List<Order> orders = Context.getOrderService().getAllOrdersByPatient(patient);
            int drugOrderTypeId = Context.getOrderService().getOrderTypeByName("Drug Order").getOrderTypeId();
            for(Order order : orders){
                
                if(order.getOrderType().getOrderTypeId() == drugOrderTypeId){
                    drugorders dorderExtension = Context.getService(drugordersService.class).getDrugOrderByOrderID(order.getOrderId());
                    currentDrugOrdersExtension.add(dorderExtension);
                    
                    DrugOrder dorderMain = (DrugOrder) Context.getOrderService().getOrder(order.getOrderId());
                    currentDrugOrderMain.put(order.getOrderId(),dorderMain);
                    
                    patientWithOrders.add(patient);
                    patientNames.put(patient.getPatientId(),Context.getPersonService().getPerson(patient.getPatientId()).getGivenName()+" "+Context.getPersonService().getPerson(patient.getPatientId()).getFamilyName());
                    patientDOB.put(patient.getPatientId(), Context.getPersonService().getPerson(patient.getPatientId()).getBirthdate());
                    patientAddress.put(patient.getPatientId(), Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getAddress1()+" "+Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getCityVillage()+" "+Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getStateProvince()+" Zipcode: "+Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getPostalCode()+" "+Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getCountry());
                    patientIdentifiers.put(patient.getPatientId(),patient.getPatientIdentifier().toString());
                    providerIdentifiers.put(order.getOrderId(), order.getOrderer().getPerson().getGivenName() + " " + order.getOrderer().getPerson().getFamilyName() + ", " + StringUtils.capitalize(order.getOrderer().getIdentifier()));
                }
            }
        }
        
        model.addAttribute("currentDrugOrdersExtension", currentDrugOrdersExtension);
        model.addAttribute("currentDrugOrdersMain", currentDrugOrderMain);
        model.addAttribute("patientsWithOrder", patientWithOrders);
        model.addAttribute("patientNames", patientNames);
        model.addAttribute("patientDOB", patientDOB);
        model.addAttribute("patientAddress", patientAddress);
        model.addAttribute("patientIdentifiers", patientIdentifiers);
        model.addAttribute("providerIdentifiers", providerIdentifiers);
    }
    
}
