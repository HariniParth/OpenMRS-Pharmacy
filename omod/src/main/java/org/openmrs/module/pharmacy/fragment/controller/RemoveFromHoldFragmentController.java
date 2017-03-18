/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;
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
public class RemoveFromHoldFragmentController {
    
    public void controller(PageModel model, @RequestParam(value = "homeCheckbox", required=false) String[] homeCheckbox){
        
        List<Integer> listOfOrders = new ArrayList<>();
        
        if(homeCheckbox.length > 0){
            for (String box : homeCheckbox) {
                String[] selected = box.split(" ");
                
                switch (selected[0]) {
                    case "PLAN":
                        List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPlanID(Integer.parseInt(selected[1]));
                        for(drugordersdiseases planOrder : planOrders){
                            listOfOrders.add(planOrder.getOrderId());
                        }   
                        break;
                        
                    case "GROUP":
                        List<drugorders> drugorders = Context.getService(drugordersService.class).getDrugOrdersByGroupID(Integer.parseInt(selected[1]));
                        for(drugorders drugorder : drugorders){
                            listOfOrders.add(drugorder.getOrderId());
                        }   
                        break;
                        
                    case "SINGLE":
                        listOfOrders.add(Integer.parseInt(selected[1]));
                        break;
                }
            }
        }
        
        model.addAttribute("listOfOrders", listOfOrders);
    }
}
