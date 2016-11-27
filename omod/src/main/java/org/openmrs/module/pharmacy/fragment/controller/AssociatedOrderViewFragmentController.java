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
import org.openmrs.module.drugorders.api.drugordersdiseasesService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.module.drugorders.drugordersdiseases;
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
                            @RequestParam(value = "action", required = false) String action){
    
        HashMap<Integer,List<drugorders>> associatedOrderExtn = new HashMap<Integer,List<drugorders>>();
        HashMap<Integer,DrugOrder> associatedOrderMain = new HashMap<Integer,DrugOrder>();
        
        HashMap<Integer,drugorders> allOrdersExtn = new HashMap<Integer,drugorders>();
        HashMap<Integer,DrugOrder> allOrdersMain = new HashMap<Integer,DrugOrder>();
        
        HashMap<Integer,List<String>> otherOrders = new HashMap<Integer,List<String>>();
        
        if (StringUtils.isNotBlank(action)) {
            try {
                if ("OK".equals(action)) {
                    drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(Integer.parseInt(orderId));
                    if(drugorder.getGroupid() != null){
                        
                        //Fetch all Orders that were ordered as a group with the recorded Order
                        List<drugorders> orderExtn = Context.getService(drugordersService.class).getDrugOrdersByGroupID(drugorder.getGroupid());
                        associatedOrderExtn.put(drugorder.getGroupid(), orderExtn);
                        
                        for(drugorders oExtn : orderExtn){
                            associatedOrderMain.put(oExtn.getOrderId(),(DrugOrder) Context.getOrderService().getOrder(oExtn.getOrderId()));
                            otherOrders.put(oExtn.getOrderId(), pullAssociatedGroupOrders(oExtn));
                        }
                        
                    } else if(Context.getService(drugordersdiseasesService.class).getDrugOrderByOrderID(Integer.parseInt(orderId)) != null){
                        
                        //Fetch all Orders that were ordered as a part of Med Plan with the recorded OrderInteger
                        List<drugordersdiseases> planOrderList = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(drugorder.getAssociateddiagnosis(), Context.getPatientService().getPatient(Integer.parseInt(drugorder.getPatientid())));
                        List<drugorders> orderExtn = new ArrayList<drugorders>();
                        
                        for(drugordersdiseases planOrder : planOrderList){
                            associatedOrderMain.put(planOrder.getOrderid(),(DrugOrder) Context.getOrderService().getOrder(planOrder.getOrderid()));
                            orderExtn.add(Context.getService(drugordersService.class).getDrugOrderByOrderID(planOrder.getOrderid()));
                        }
                        associatedOrderExtn.put(Integer.SIZE, orderExtn);
                        
                        for(drugorders extn : orderExtn)
                            otherOrders.put(extn.getOrderId(), pullAssociatedPlanOrders(extn));
                    } 
                        
                    //Fetch all other Orders placed for the given Patient that are not a part of the same group as recorded Order
                    List<drugorders> allExtn = Context.getService(drugordersService.class).getDrugOrdersByPatient(Context.getPatientService().getPatient(Integer.parseInt(patientID)));
                    
                    for(drugorders extn : allExtn){
                        if(!associatedOrderMain.containsKey(extn.getOrderId())){
                            allOrdersExtn.put(extn.getOrderId(), extn);
                            DrugOrder main = (DrugOrder) Context.getOrderService().getOrder(extn.getOrderId());
                            allOrdersMain.put(main.getOrderId(), main);
                        }
                        
                        if(extn.getOrderstatus().equals("Active-Group"))
                            otherOrders.put(extn.getOrderId(), pullAssociatedGroupOrders(extn));
                        else if(extn.getOrderstatus().equals("Active-Plan"))
                            otherOrders.put(extn.getOrderId(), pullAssociatedPlanOrders(extn));
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
        
        model.addAttribute("allOrdersExtn", allOrdersExtn);
        model.addAttribute("allOrdersMain", allOrdersMain);
        model.addAttribute("otherOrders", otherOrders);
        
        model.addAttribute("patientName", patientName);
        model.addAttribute("patientDOB", patientDOB);
        model.addAttribute("patientID", patientID);
        model.addAttribute("patientAddress", patientAddress);
        model.addAttribute("provider", provider);
    }
    
    public ArrayList<String> pullAssociatedGroupOrders(drugorders drugorder){
        
        ArrayList<String> otherOrdersDrugName = new ArrayList<String>();
        
        List<drugorders> otherOrdersInGroup = Context.getService(drugordersService.class).getDrugOrdersByGroupID(drugorder.getGroupid());

        for(drugorders otherOrder : otherOrdersInGroup){
            otherOrdersDrugName.add(otherOrder.getDrugname().getDisplayString());
        }
        return otherOrdersDrugName;
    } 
    
    public ArrayList<String> pullAssociatedPlanOrders(drugorders drugorder){
        
        ArrayList<String> otherOrdersDrugName = new ArrayList<String>();

        List<drugordersdiseases> planOrderList = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(drugorder.getAssociateddiagnosis(), Context.getPatientService().getPatient(Integer.parseInt(drugorder.getPatientid())));

        for(drugordersdiseases planOrder : planOrderList){
            drugorders otherOrder = Context.getService(drugordersService.class).getDrugOrderByOrderID(planOrder.getOrderid());
            otherOrdersDrugName.add(otherOrder.getDrugname().getDisplayString());
        }
        return otherOrdersDrugName;
    }
}
