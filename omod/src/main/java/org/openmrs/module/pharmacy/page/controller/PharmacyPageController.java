/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class PharmacyPageController {
    
    public void controller(PageModel model,@RequestParam(value = "order_id_display", required = false) String order_id_display,
                            @RequestParam(value = "pharma_order_id", required = false) String pharma_order_id){

        model.addAttribute("pharma_order_id", pharma_order_id);
        model.addAttribute("order_id_display", order_id_display);
        
    }
}