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
import org.openmrs.Patient;
import org.openmrs.Person;
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
    
    public void controller(PageModel model,@RequestParam(value = "action", required = false) String action,
                            @RequestParam(value = "pharmaOrderID", required = false) String pharmaOrderID,
                            @RequestParam("patientId") Patient patient){
    
        HashMap<Integer,List<drugorders>> associatedOrderExtn = new HashMap<>();
        HashMap<Integer,DrugOrder> associatedOrderMain = new HashMap<>();
        
        HashMap<Integer,drugorders> allOrdersExtn = new HashMap<>();
        HashMap<Integer,DrugOrder> allOrdersMain = new HashMap<>();
        
        HashMap<Integer,List<String>> otherOrders = new HashMap<>();
        HashMap<Integer, String> OrdererName = new HashMap<>();
                
        if (StringUtils.isNotBlank(action)) {
            try {
                if ("Confirm".equals(action)) {
                    drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(Integer.parseInt(pharmaOrderID));
                    if(drugorder.getGroupId() != null){
                        
                        //Fetch all Orders that were ordered as a group with the recorded Order
                        List<drugorders> orderExtn = Context.getService(drugordersService.class).getDrugOrdersByGroupID(drugorder.getGroupId());
                        associatedOrderExtn.put(drugorder.getGroupId(), orderExtn);
                        
                        for(drugorders oExtn : orderExtn){
                            associatedOrderMain.put(oExtn.getOrderId(),(DrugOrder) Context.getOrderService().getOrder(oExtn.getOrderId()));
                            otherOrders.put(oExtn.getOrderId(), pullAssociatedGroupOrders(oExtn));
                        
                            Person person = Context.getOrderService().getOrder(oExtn.getOrderId()).getOrderer().getPerson();
                            OrdererName.put(oExtn.getOrderId(), person.getGivenName()+" "+person.getFamilyName());
                        }
                        
                    } else if(Context.getService(drugordersdiseasesService.class).getDrugOrderByOrderID(Integer.parseInt(pharmaOrderID)) != null){
                        
                        //Fetch all Orders that were ordered as a part of Med Plan with the recorded OrderInteger
                        List<drugordersdiseases> planOrderList = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(drugorder.getAssociatedDiagnosis(), Context.getPatientService().getPatient(Integer.parseInt(drugorder.getPatientId())));
                        List<drugorders> orderExtn = new ArrayList<>();
                        
                        for(drugordersdiseases planOrder : planOrderList){
                            associatedOrderMain.put(planOrder.getOrderId(),(DrugOrder) Context.getOrderService().getOrder(planOrder.getOrderId()));
                            orderExtn.add(Context.getService(drugordersService.class).getDrugOrderByOrderID(planOrder.getOrderId()));
                        }
                        associatedOrderExtn.put(Integer.SIZE, orderExtn);
                        
                        for(drugorders extn : orderExtn){
                            otherOrders.put(extn.getOrderId(), pullAssociatedPlanOrders(extn));
                            
                            Person person = Context.getOrderService().getOrder(extn.getOrderId()).getOrderer().getPerson();
                            OrdererName.put(extn.getOrderId(), person.getGivenName()+" "+person.getFamilyName());
                        }
                            
                    } 
                        
                    //Fetch all other Orders placed for the given Patient that are not a part of the same group as recorded Order
                    List<drugorders> allExtn = Context.getService(drugordersService.class).getDrugOrdersByPatient(patient);
                    
                    for(drugorders extn : allExtn){
                        if(!associatedOrderMain.containsKey(extn.getOrderId())){
                            allOrdersExtn.put(extn.getOrderId(), extn);
                            DrugOrder main = (DrugOrder) Context.getOrderService().getOrder(extn.getOrderId());
                            allOrdersMain.put(main.getOrderId(), main);
                        }
                        
                        if(extn.getOrderStatus().equals("Active-Group"))
                            otherOrders.put(extn.getOrderId(), pullAssociatedGroupOrders(extn));
                        else if(extn.getOrderStatus().equals("Active-Plan"))
                            otherOrders.put(extn.getOrderId(), pullAssociatedPlanOrders(extn));
                        
                        Person person = Context.getOrderService().getOrder(extn.getOrderId()).getOrderer().getPerson();
                        OrdererName.put(extn.getOrderId(), person.getGivenName()+" "+person.getFamilyName());
                    }
                }
            }
            catch (NumberFormatException | APIException e) {
                System.out.println(e.toString());
            }
        }
        
        model.addAttribute("associatedOrderExtn", associatedOrderExtn);
        model.addAttribute("associatedOrderMain", associatedOrderMain);
        
        model.addAttribute("allOrdersExtn", allOrdersExtn);
        model.addAttribute("allOrdersMain", allOrdersMain);
        model.addAttribute("otherOrders", otherOrders);
        model.addAttribute("assocOrdererName", OrdererName);
    }
    
    public ArrayList<String> pullAssociatedGroupOrders(drugorders drugorder){
        
        ArrayList<String> otherOrdersDrugName = new ArrayList<>();
        
        List<drugorders> otherOrdersInGroup = Context.getService(drugordersService.class).getDrugOrdersByGroupID(drugorder.getGroupId());

        for(drugorders otherOrder : otherOrdersInGroup){
            otherOrdersDrugName.add(otherOrder.getDrugName().getDisplayString());
        }
        return otherOrdersDrugName;
    } 
    
    public ArrayList<String> pullAssociatedPlanOrders(drugorders drugorder){
        
        ArrayList<String> otherOrdersDrugName = new ArrayList<>();

        List<drugordersdiseases> planOrderList = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(drugorder.getAssociatedDiagnosis(), Context.getPatientService().getPatient(Integer.parseInt(drugorder.getPatientId())));

        for(drugordersdiseases planOrder : planOrderList){
            drugorders otherOrder = Context.getService(drugordersService.class).getDrugOrderByOrderID(planOrder.getOrderId());
            otherOrdersDrugName.add(otherOrder.getDrugName().getDisplayString());
        }
        return otherOrdersDrugName;
    }
}
