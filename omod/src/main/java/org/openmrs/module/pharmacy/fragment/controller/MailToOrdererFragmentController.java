/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class MailToOrdererFragmentController {
    
    public void controller(PageModel model, @RequestParam("patientId") Patient patient,
                            @RequestParam(value = "pharmaGroupAction", required = false) String groupAction,
                            @RequestParam(value = "groupComments", required = false) String groupComments,
                            @RequestParam(value = "groupCheckBox", required=false) long[] groupCheckBox) throws ParseException{
       
        model.addAttribute("patientID", patient.getPatientId());
        model.addAttribute("patientName", patient.getGivenName()+" "+patient.getFamilyName());
        
        model.addAttribute("groupAction", groupAction);
        
        String orderList = "";
        String orderDetails = "";
        SimpleDateFormat formatter = new SimpleDateFormat("mm-dd-yyyy");
        
        for(int i=0;i<groupCheckBox.length;i++){
            orderList = orderList.concat(Long.toString(groupCheckBox[i])+" ");
            drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(Integer.parseInt(Long.toString(groupCheckBox[i])));
            orderDetails = orderDetails.concat("Order ID: "+Integer.toString(drugorder.getOrderId())+"\nDrug: "+drugorder.getDrugName().getDisplayString()+"\nStart Date: "+formatter.parse(drugorder.getStartDate().toString())+"\n\n");
        }
        
        model.addAttribute("orderList", orderList);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("groupComments", groupComments);
    }
}
