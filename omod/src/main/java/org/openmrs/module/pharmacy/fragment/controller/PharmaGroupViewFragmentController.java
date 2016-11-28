/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.openmrs.DrugOrder;
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
public class PharmaGroupViewFragmentController {
    
    public void controller(PageModel model,@RequestParam(value = "planPatient", required = false) String planPatient,
                            @RequestParam(value = "planName", required = false) String planName){
        
        Patient patient;
        Date patientDOB = null;
        String patientName = null, patientAddress = null;
        HashMap<Integer,DrugOrder> groupOrderMain = new HashMap<Integer,DrugOrder>();
        HashMap<Integer,drugorders> groupOrderExtn = new HashMap<Integer,drugorders>();
        
        if(!planPatient.equals("") && !planName.equals("")){
            
            //Fetch the Patient's personal details
            patient = Context.getPatientService().getPatient(Integer.parseInt(planPatient));
            patientName = Context.getPersonService().getPerson(patient.getPatientId()).getGivenName() + " " + Context.getPersonService().getPerson(patient.getPatientId()).getFamilyName();
            patientDOB = Context.getPersonService().getPerson(patient.getPatientId()).getBirthdate();
            patientAddress = Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getAddress1()+" "+Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getCityVillage()+" "+Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getStateProvince()+" Zipcode: "+Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getPostalCode()+" "+Context.getPersonService().getPerson(patient.getPatientId()).getPersonAddress().getCountry();
        
            //Get the list of Med Plan Orders ordered for this Patient to treat this Disease
            List<drugordersdiseases> plans = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(Context.getConceptService().getConceptByName(planName), patient);
            for(drugordersdiseases plan : plans){
                
                drugorders dorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(plan.getOrderid());
                if(dorder.getOrderstatus().equals("Active-Plan")){
                    groupOrderExtn.put(dorder.getOrderId(), dorder);
                    DrugOrder DOrder = (DrugOrder) Context.getOrderService().getOrder(dorder.getOrderId());
                    groupOrderMain.put(dorder.getOrderId(), DOrder);
                }
            }
        }
        
        model.addAttribute("groupOrderMain", groupOrderMain);
        model.addAttribute("groupOrderExtn", groupOrderExtn);
        model.addAttribute("patientName", patientName);
        model.addAttribute("patientDOB", patientDOB);
        model.addAttribute("patientAddress", patientAddress);
        model.addAttribute("planName", planName);
    }
}
