/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import java.util.List;
import org.openmrs.DrugOrder;
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
    
    public void controller(PageModel model,@RequestParam(value = "order_id_display", required = false) String order_id_display,
                            @RequestParam(value = "pharma_order_id", required = false) String pharma_order_id,
                            @RequestParam(value = "search_order_id", required = false) String search_order_id){

        model.addAttribute("search_order_id", search_order_id);
        model.addAttribute("pharma_order_id", pharma_order_id);
        model.addAttribute("order_id_display", order_id_display);
        
        if(!(search_order_id).equals("")){
            DrugOrder dorder_main = (DrugOrder) Context.getOrderService().getOrder(Integer.parseInt(search_order_id));
            model.addAttribute("dorder_main", dorder_main);
            
            drugorders dorder_extension = Context.getService(drugordersService.class).getNewTable(dorder_main.getOrderId());
            model.addAttribute("dorder_extension", dorder_extension);
            
            List<Patient> pharma_patients = Context.getPatientService().getAllPatients(true);
            for(Patient pharma_patient : pharma_patients){
                if(Integer.toString(pharma_patient.getPatientId()).equals(dorder_extension.getPatientid())){
                    String pharma_patient_name = Context.getPersonService().getPerson(pharma_patient).getGivenName() + " " + Context.getPersonService().getPerson(pharma_patient).getFamilyName();
                    model.addAttribute("pharma_patient_name", pharma_patient_name);
                }
            }
        }
    }
}