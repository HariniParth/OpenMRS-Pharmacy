/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class PharmaActionWindowFragmentController {
    
    public void controller(PageModel model,@RequestParam(value = "pharma_order_id", required = false) String pharma_order_id,
                            @RequestParam(value = "pharma_patient_id", required = false) String pharma_patient_id,
                            @RequestParam(value = "pharma_patient_name", required = false) String pharma_patient_name,
                            @RequestParam(value = "pharma_patient_dob", required = false) String pharma_patient_DOB,
                            @RequestParam(value = "pharma_patient_address", required = false) String pharma_patient_address,
                            @RequestParam(value = "pharma_start_date", required = false) String pharma_start_date,
                            @RequestParam(value = "pharma_order_details", required = false) String pharma_order_details,
                            @RequestParam(value = "pharma_order_refill", required = false) String pharma_order_refill,
                            @RequestParam(value = "pharma_order_refillInterval", required = false) String pharma_order_refillInterval,
                            @RequestParam(value = "order_provider", required = false) String order_provider,
                            @RequestParam(value = "pharma_patient_instructions", required = false) String pharma_patient_instructions,
                            @RequestParam(value = "pharma_pharmacist_instructions", required = false) String pharma_pharmacist_instructions){
        
        model.addAttribute("pharma_order_id", pharma_order_id);
        model.addAttribute("pharma_patient_id", pharma_patient_id);
        model.addAttribute("pharma_patient_name", pharma_patient_name);
        model.addAttribute("pharma_patient_DOB", pharma_patient_DOB);
        model.addAttribute("pharma_patient_address", pharma_patient_address);
        model.addAttribute("pharma_start_date", pharma_start_date);
        model.addAttribute("pharma_order_details", pharma_order_details);
        model.addAttribute("pharma_order_refill", pharma_order_refill);
        model.addAttribute("pharma_order_refillInterval", pharma_order_refillInterval);
        model.addAttribute("order_provider", order_provider);
        model.addAttribute("pharma_patient_instructions", pharma_patient_instructions);
        model.addAttribute("pharma_pharmacist_instructions", pharma_pharmacist_instructions);
    }
}
