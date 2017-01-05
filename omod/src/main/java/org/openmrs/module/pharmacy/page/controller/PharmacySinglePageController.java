/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Copies;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.openmrs.DrugOrder;
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
public class PharmacySinglePageController {

    public void controller(PageModel model, HttpSession session,
            @RequestParam(value = "pharmaOrderID", required = false) String pharmaOrderID,
            @RequestParam(value = "pharmaSingleAction", required = false) String pharmaSingleAction,
            @RequestParam(value = "comments", required = false) String comments,
            @RequestParam(value = "additionalMessage", required = false) String additionalMessage,
            @RequestParam(value = "action", required = false) String action,
            @RequestParam(value = "commentCheckbox", required = false) String commentCheckbox,
            @RequestParam(value = "messageCheckbox", required = false) String messageCheckbox) {

        String order_status = "";
        
        if (StringUtils.isNotBlank(action)) {
            try {
                if ("Confirm".equals(action)) {

                    drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(Integer.parseInt(pharmaOrderID));
                    
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
                    
                    if(pharmaSingleAction.equals("Discard")){
                            drugorder.setDiscontinued(1);
                    } else 
                        if(pharmaSingleAction.equals("On Hold")){
                        drugorder.setOnHold(1);
                    }

                    Context.getService(drugordersService.class).saveDrugOrder(drugorder);
                    InfoErrorMessageUtil.flashInfoMessage(session, "Order Status - "+pharmaSingleAction);
                    
                }
            } catch (NumberFormatException e) {
                System.out.println(e.toString());
            } catch (APIException e) {
                System.out.println(e.toString());
            }
        }
        
        
        if (StringUtils.isNotBlank(pharmaSingleAction)){
            
            drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(Integer.parseInt(pharmaOrderID));
            
            if (pharmaSingleAction.equals("Dispatch") && drugorder.getRefill() > 0){
                drugorder.setLastdispatchdate(Calendar.getInstance().getTime());System.out.println("Refill "+drugorder.getRefill());
                drugorder.setRefill(drugorder.getRefill() - 1);
            }
            else {
                if(drugorder.getOrderstatus().equals("Active"))
                    drugorder.setOrderstatus("Non-Active");

                else if(drugorder.getOrderstatus().equals("Active-Group"))
                    drugorder.setOrderstatus("Non-Active-Group");

                else if(drugorder.getOrderstatus().equals("Active-Plan"))
                    drugorder.setOrderstatus("Non-Active-Plan");

                Context.getOrderService().voidOrder(Context.getOrderService().getOrder(drugorder.getOrderId()), "No Longer Active");
            }
            
            printOrder(drugorder.getOrderId());
            Context.getService(drugordersService.class).saveDrugOrder(drugorder);
            InfoErrorMessageUtil.flashInfoMessage(session, "Order Status - "+pharmaSingleAction);
            
        }
        
        model.addAttribute("order_status", order_status);
    }
    
    void printOrder(int orderID){
        
        try {
            DrugOrder order = (DrugOrder) Context.getOrderService().getOrder(orderID);
            drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(orderID);
            
            PrintService service = PrintServiceLookup.lookupDefaultPrintService();
            
            String OrderDetails = drugorder.getDrugname().getDisplayString() + " " + order.getDose() + " " + order.getDoseUnits().getDisplayString() + " " +
                    order.getDuration() + " " + order.getDurationUnits().getDisplayString() + " " + order.getQuantity() + " " + order.getQuantityUnits() + "\n" +
                    "Route: " + order.getRoute().getDisplayString() + " " + "Frequency: " + order.getFrequency().getName() + "\n" +
                    "Start Date: " + drugorder.getStartdate().toString() + "\n" +
                    "Patient Instructions: " + drugorder.getPatientinstructions();
            
            InputStream is = new ByteArrayInputStream(OrderDetails.getBytes());
            
            PrintRequestAttributeSet  pras = new HashPrintRequestAttributeSet();
            pras.add(new Copies(1));
            
            if(service != null){
                DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;
                Doc doc = new SimpleDoc(is, flavor, null);
                DocPrintJob job = service.createPrintJob();

                job.print(doc, pras);
            }
            is.close();
            
        } catch (IOException ex) {
            Logger.getLogger(PharmacySinglePageController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (PrintException ex) {
            Logger.getLogger(PharmacySinglePageController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
