/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import java.util.Arrays;
import java.util.Calendar;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.openmrs.api.APIException;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.module.uicommons.util.InfoErrorMessageUtil;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class PharmacyGroupPageController {
    
    public void controller(PageModel model, HttpSession session,
                            @RequestParam(value = "action", required = false) String action,
                            @RequestParam(value = "pharmaGroupAction", required = false) String groupAction,
                            @RequestParam(value = "group_order_ID", required = false) String group_order_ID,
                            @RequestParam(value = "groupComments", required = false) String groupComments,
                            @RequestParam(value = "groupMessage", required = false) String groupMessage,
                            @RequestParam(value = "commentbox", required = false) String commentbox,
                            @RequestParam(value = "messagebox", required = false) String messagebox) {
        
        if (StringUtils.isNotBlank(action)){
            
            try {
                if ("Record".equals(action)){
                    String orderList[] = group_order_ID.split(",");
                    
                    for(String order : orderList){
                        
                        int orderID = Integer.parseInt(order);
                        drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(orderID);
                            
                        if (!(commentbox.equals("1"))) {
                            drugorder.setForwardcomments(0);
                        } else {
                            drugorder.setForwardcomments(1);
                        }

                        if (!(messagebox.equals("1"))) {
                            drugorder.setAdditionalmessage(0);
                        } else {
                            drugorder.setAdditionalmessage(1);
                        }

                        drugorder.setComments(groupComments);
                        drugorder.setMessage(groupMessage);
                    
                        if (!(groupAction.equals("On Hold"))) {
                        
                            if (groupAction.equals("Dispatch") && drugorder.getRefill() > 0){
                                drugorder.setLastdispatchdate(Calendar.getInstance().getTime());
                                drugorder.setRefill(drugorder.getRefill() - 1);
                            } else {
                                if(drugorder.getOrderstatus().equals("Active"))
                                    drugorder.setOrderstatus("Non-Active");
                                
                                else if(drugorder.getOrderstatus().equals("Active-Group"))
                                    drugorder.setOrderstatus("Non-Active-Group");
                                
                                else if(drugorder.getOrderstatus().equals("Active-Plan"))
                                    drugorder.setOrderstatus("Non-Active-Plan");
                                
                                Context.getOrderService().voidOrder(Context.getOrderService().getOrder(drugorder.getOrderId()), "No Longer Active");
                            }
                            
                        } else {
                            drugorder.setOnHold(1);
                        }

                        Context.getService(drugordersService.class).saveDrugOrder(drugorder);
                        InfoErrorMessageUtil.flashInfoMessage(session, "Order Status - "+groupAction);

                    }
                }
            } catch (NumberFormatException e) {
                System.out.println(e.toString());
            } catch (APIException e) {
                System.out.println(e.toString());
            }
        }
        
        model.addAttribute("group_order_status", groupAction);
    }
}
