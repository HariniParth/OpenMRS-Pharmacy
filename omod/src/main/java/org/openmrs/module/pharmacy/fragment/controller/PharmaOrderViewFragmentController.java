/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.List;
import org.openmrs.DrugOrder;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.api.drugordersdiseasesService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.module.drugorders.drugordersdiseases;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class PharmaOrderViewFragmentController {
    
    public void controller(PageModel model, @RequestParam(value = "singleID", required = false) String singleID,
                            @RequestParam(value = "assocID", required = false) String assocID,
                            @RequestParam(value = "otherID", required = false) String otherID,
                            @RequestParam("patientId") Patient patient){

        model.addAttribute("singleID", singleID);
        model.addAttribute("assocID", assocID);
        model.addAttribute("otherID", otherID);
        
        DrugOrder orderMain = null;
        drugorders orderExtn = null;
        String provider = "";
        String associatedOrders = "";
        
        if(!singleID.equals("") || !assocID.equals("") || !otherID.equals("")){
            
            int order = 0;
            if(!singleID.equals(""))
                order = Integer.parseInt(singleID);
            if(!assocID.equals(""))
                order = Integer.parseInt(assocID);
            if(!otherID.equals(""))
                order = Integer.parseInt(otherID);
            
            orderMain = (DrugOrder) Context.getOrderService().getOrder(order);
            
            orderExtn = Context.getService(drugordersService.class).getDrugOrderByOrderID(order);
            
            provider = orderMain.getOrderer().getPerson().getGivenName() + " " + orderMain.getOrderer().getPerson().getFamilyName() + ", " + StringUtils.capitalize(orderMain.getOrderer().getIdentifier());
        
            if(orderExtn.getOrderstatus().equals("Active-Group")){
                List<drugorders> otherOrdersInGroup = Context.getService(drugordersService.class).getDrugOrdersByGroupID(orderExtn.getGroupid());
                for(drugorders otherOrder : otherOrdersInGroup){
                    associatedOrders = associatedOrders + otherOrder.getDrugname().getDisplayString() + " ";
                }
            }
            
            if(orderExtn.getOrderstatus().equals("Active-Plan")){
                drugordersdiseases planOrder = Context.getService(drugordersdiseasesService.class).getDrugOrderByOrderID(orderExtn.getOrderid());
                List<drugordersdiseases> planOrders = Context.getService(drugordersdiseasesService.class).getDrugOrdersByPlanID(planOrder.getPlanid());
                for(drugordersdiseases plan : planOrders){
                    associatedOrders = associatedOrders + Context.getService(drugordersService.class).getDrugOrderByOrderID(plan.getOrderid()).getDrugname().getDisplayString() + " ";
                }
                
            }
        }
        
        model.addAttribute("orderMain", orderMain);
        model.addAttribute("orderExtn", orderExtn);
        model.addAttribute("provider", provider);
        model.addAttribute("associatedOrders", associatedOrders);
    }
}
