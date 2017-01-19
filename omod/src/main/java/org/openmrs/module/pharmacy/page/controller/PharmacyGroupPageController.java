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
import org.openmrs.Patient;
import org.openmrs.api.APIException;
import org.openmrs.module.allergyapi.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.allergyapi.Allergies;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.module.uicommons.util.InfoErrorMessageUtil;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class PharmacyGroupPageController {

    public void controller(PageModel model, HttpSession session,
            @RequestParam("patientId") Patient patient, @SpringBean("allergyService") PatientService patientService,
            @RequestParam(value = "action", required = false) String action,
            @RequestParam(value = "pharmaGroupAction", required = false) String groupAction,
            @RequestParam(value = "group_order_ID", required = false) String group_order_ID,
            @RequestParam(value = "groupComments", required = false) String groupComments,
            @RequestParam(value = "groupMessage", required = false) String groupMessage,
            @RequestParam(value = "commentbox", required = false) String commentbox,
            @RequestParam(value = "messagebox", required = false) String messagebox) {

        Allergies allergies = patientService.getAllergies(patient);
        model.addAttribute("allergies", allergies);
        
        if (StringUtils.isNotBlank(action)) {
            try {
                if ("Record".equals(action)) {
                    String orderList[] = group_order_ID.split(",");
                    for (String order : orderList) {
                        
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

                        //Change Order Status when Pharmacist performs a new action on the Order
                        if(groupAction.equals("Discard")) {
                            drugorder.setForDiscard(1);
                            if(drugorder.getOnHold() == 1)
                                drugorder.setOnHold(0);
                        }
                        if(groupAction.equals("On Hold")){
                            drugorder.setOnHold(1);
                            if(drugorder.getForDiscard()== 1)
                                drugorder.setForDiscard(0);
                        }
                        
                        Context.getService(drugordersService.class).saveDrugOrder(drugorder);
                    }
                }
            } catch (NumberFormatException e) {
                System.out.println(e.toString());
            } catch (APIException e) {
                System.out.println(e.toString());
            }
            InfoErrorMessageUtil.flashInfoMessage(session, "Order Status - " + groupAction);
        }
        
        
        if(StringUtils.isNotBlank(groupAction) && groupAction.equals("Dispatch")){
            
            String orderList[] = group_order_ID.split(",");
            for (String order : orderList){
                
                int orderID = Integer.parseInt(order);
                drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(orderID);
                
                //Change Order Status when Pharmacist performs a new action on the Order
                if(drugorder.getForDiscard() == 1)
                    drugorder.setForDiscard(0);
                else if(drugorder.getOnHold() == 1)
                    drugorder.setOnHold(0);
                
                if (drugorder.getRefill() > 0) {
                    drugorder.setLastdispatchdate(Calendar.getInstance().getTime());
                    drugorder.setRefill(drugorder.getRefill() - 1);
                } 
                else {
                    if (drugorder.getOrderstatus().equals("Active")) {
                        drugorder.setOrderstatus("Non-Active");
                    } else if (drugorder.getOrderstatus().equals("Active-Group")) {
                        drugorder.setOrderstatus("Non-Active-Group");
                    } else if (drugorder.getOrderstatus().equals("Active-Plan")) {
                        drugorder.setOrderstatus("Non-Active-Plan");
                    }
                    
                    Context.getOrderService().voidOrder(Context.getOrderService().getOrder(drugorder.getOrderId()), "No Longer Active");
                }
                printOrder(drugorder.getOrderId());
                Context.getService(drugordersService.class).saveDrugOrder(drugorder);
            }
            InfoErrorMessageUtil.flashInfoMessage(session, "Order Status - " + groupAction);
        }

        model.addAttribute("group_order_status", groupAction);
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
            Logger.getLogger(PharmacyGroupPageController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (PrintException ex) {
            Logger.getLogger(PharmacyGroupPageController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}