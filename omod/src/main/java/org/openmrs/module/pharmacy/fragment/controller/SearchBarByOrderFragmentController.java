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
public class SearchBarByOrderFragmentController {
    
    public void controller(PageModel model,@RequestParam(value = "search_order_id", required = false) String search_order_id){
        
        model.addAttribute("search_order_id", search_order_id);
        
    }
}
