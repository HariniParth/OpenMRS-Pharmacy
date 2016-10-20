/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.openmrs.DrugOrder;
import org.openmrs.api.APIException;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class AssociatedOrderViewFragmentController {
    
    public void controller(PageModel model,@RequestParam(value = "pharma_action_order_id", required = false) String orderId,
                            @RequestParam(value = "pharma_action_patient_name", required = false) String patientName,
                            @RequestParam(value = "pharma_action_patient_DOB", required = false) String patientDOB,
                            @RequestParam(value = "pharma_action_patient_id", required = false) String patientID,
                            @RequestParam(value = "pharma_action_patient_address", required = false) String patientAddress,
                            @RequestParam(value = "pharma_order_provider", required = false) String provider,
                            @RequestParam(value = "associatedOrders", required = false) String associatedOrders,
                            @RequestParam(value = "action", required = false) String action){
    
        HashMap<Integer,List<drugorders>> associatedOrderExtn = new HashMap<Integer,List<drugorders>>();
        HashMap<Integer,DrugOrder> associatedOrderMain = new HashMap<Integer,DrugOrder>();
        
        if (StringUtils.isNotBlank(action)) {
            try {
                if ("OK".equals(action)) {
                    drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(Integer.parseInt(orderId));
                    if(drugorder.getGroupid() != null){
                        
                        List<drugorders> orderExtn = Context.getService(drugordersService.class).getDrugOrdersByGroupID(drugorder.getGroupid());
                        associatedOrderExtn.put(drugorder.getGroupid(), orderExtn);
                        
                        for(drugorders oExtn : orderExtn){
                            associatedOrderMain.put(oExtn.getOrderId(),(DrugOrder) Context.getOrderService().getOrder(oExtn.getOrderId()));
                        }
                    }
                }
            }
            catch (NumberFormatException e) {
                System.out.println(e.toString());
            } catch (APIException e) {
                System.out.println(e.toString());
            }
        }
        
        model.addAttribute("associatedOrderExtn", associatedOrderExtn);
        model.addAttribute("associatedOrderMain", associatedOrderMain);
        
        model.addAttribute("patientName", patientName);
        model.addAttribute("patientDOB", patientDOB);
        model.addAttribute("patientID", patientID);
        model.addAttribute("patientAddress", patientAddress);
        model.addAttribute("provider", provider);
        model.addAttribute("associatedOrders", associatedOrders);
    }
}
