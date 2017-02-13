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
public class MailToOrdererFragmentController {
    
    public void controller(PageModel model, @RequestParam(value = "pharmaGroupAction", required = false) String groupAction){
       
        model.addAttribute("groupAction", groupAction);
    }
}
