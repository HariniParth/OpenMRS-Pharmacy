/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.List;
import org.openmrs.Concept;
import org.openmrs.ConceptClass;
import org.openmrs.ConceptSearchResult;
import org.openmrs.Patient;
import org.openmrs.PersonName;
import org.openmrs.api.ConceptService;
import org.openmrs.api.context.Context;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class SearchBarByPatientFragmentController {
    
    public void controller(PageModel model) {
        
        List<String> allFirstNames = new ArrayList<String>();
        List<String> allLastNames = new ArrayList<String>();
        
        List<Patient> allPatients = Context.getPatientService().getAllPatients();
        for(Patient patient : allPatients){
            allFirstNames.add(Context.getPersonService().getPerson(patient.getPatientId()).getGivenName());
            allLastNames.add(Context.getPersonService().getPerson(patient.getPatientId()).getFamilyName());
        }
        
        model.addAttribute("allFirstNames", allFirstNames);
        model.addAttribute("allLastNames", allLastNames);
    }
        
}