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
public class PharmaOrderViewController {
    
    public void controller(PageModel model,
                            @RequestParam(value = "order_id_display", required = false) String order_id_display){

        model.addAttribute("OrderID", order_id_display);
        
    }
    
}
