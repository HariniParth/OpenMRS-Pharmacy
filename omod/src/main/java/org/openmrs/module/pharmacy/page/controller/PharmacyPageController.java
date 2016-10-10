/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import java.util.Calendar;
import java.util.Date;
import org.apache.commons.lang.StringUtils;
import org.openmrs.DrugOrder;
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

    public void controller(PageModel model,
            @RequestParam(value = "pharma_order_id", required = false) String pharma_order_id,
            @RequestParam(value = "pharma_order_status", required = false) String pharma_order_status,
            @RequestParam(value = "pharma_action_order_id", required = false) Integer pharma_action_order_id,
            @RequestParam(value = "comments", required = false) String comments,
            @RequestParam(value = "additionalMessage", required = false) String additionalMessage,
            @RequestParam(value = "action", required = false) String action,
            @RequestParam(value = "commentCheckbox", required = false) String commentCheckbox,
            @RequestParam(value = "messageCheckbox", required = false) String messageCheckbox) {

        model.addAttribute("pharma_order_id", pharma_order_id);
        model.addAttribute("pharma_action_order_id", pharma_action_order_id);

        if (StringUtils.isNotBlank(action)) {
            try {
                if ("Dispatch".equals(action)) {
                    String order_status = "Dispatch";
                    model.addAttribute("order_status", order_status);
                }
                if ("Hold".equals(action)) {
                    String order_status = "Hold";
                    model.addAttribute("order_status", order_status);
                }
                if ("Drop".equals(action)) {
                    String order_status = "Drop";
                    model.addAttribute("order_status", order_status);
                }
                if ("OK".equals(action)) {

                    drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(pharma_action_order_id);
                    
                    if (!(commentCheckbox.equals("1"))) {
                        drugorder.setForwardcomments(0);
                    } else {
                        drugorder.setForwardcomments(1);
                    }

                    if (!(messageCheckbox.equals("1"))) {
                        drugorder.setAdditionalmessage(0);
                    } else {
                        drugorder.setAdditionalmessage(1);
                    }

                    drugorder.setComments(comments);
                    drugorder.setMessage(additionalMessage);
                    
                    if (!(pharma_order_status.equals("Hold"))) {
                        
                        if (pharma_order_status.equals("Dispatch") && drugorder.getRefill() > 0){
                            drugorder.setLastdispatchdate(Calendar.getInstance().getTime());
                            drugorder.setRefill(drugorder.getRefill() - 1);
                        } else {
                            drugorder.setOrderstatus(pharma_order_status);
                            Context.getOrderService().voidOrder(Context.getOrderService().getOrder(drugorder.getOrderId()), "No Longer Active");
                        }
                    }

                    Context.getService(drugordersService.class).saveDrugOrder(drugorder);

                }
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        }
    }
}
