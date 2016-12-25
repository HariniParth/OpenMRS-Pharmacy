/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import java.util.List;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
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
                    model.addAttribute("allPatients", patient);
                }
            }
        } else {
            model.addAttribute("allPatients", allPatients);
        }
    }
}
