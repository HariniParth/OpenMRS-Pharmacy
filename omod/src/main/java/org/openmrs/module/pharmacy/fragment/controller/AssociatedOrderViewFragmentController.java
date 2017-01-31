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
    
        HashMap<Integer,List<drugorders>> associatedOrderExtn = new HashMap<Integer,List<drugorders>>();
        HashMap<Integer,DrugOrder> associatedOrderMain = new HashMap<Integer,DrugOrder>();
        
        HashMap<Integer,drugorders> allOrdersExtn = new HashMap<Integer,drugorders>();
        HashMap<Integer,DrugOrder> allOrdersMain = new HashMap<Integer,DrugOrder>();
        
        HashMap<Integer,List<String>> otherOrders = new HashMap<Integer,List<String>>();
        HashMap<Integer, String> OrdererName = new HashMap<Integer, String>();
                
        if (StringUtils.isNotBlank(action)) {
            try {
                if ("Confirm".equals(action)) {
                    drugorders drugorder = Context.getService(drugordersService.class).getDrugOrderByOrderID(Integer.parseInt(pharmaOrderID));
                    if(drugorder.getGroupid() != null){
                        
                        //Fetch all Orders that were ordered as a group with the recorded Order
                        List<drugorders> orderExtn = Context.getService(drugordersService.class).getDrugOrdersByGroupID(drugorder.getGroupid());
                        associatedOrderExtn.put(drugorder.getGroupid(), orderExtn);
                        
                        for(drugorders oExtn : orderExtn){
                            associatedOrderMain.put(oExtn.getOrderid(),(DrugOrder) Context.getOrderService().getOrder(oExtn.getOrderid()));
                            otherOrders.put(oExtn.getOrderid(), pullAssociatedGroupOrders(oExtn));
                        
                            Person person = Context.getOrderService().getOrder(oExtn.getOrderid()).getOrderer().getPerson();
                            OrdererName.put(oExtn.getOrderid(), person.getGivenName()+" "+person.getFamilyName());
                        }
                        
                    } else if(Context.getService(drugordersdiseasesService.class).getDrugOrderByOrderID(Integer.parseInt(pharmaOrderID)) != null){
                        
                        //Fetch all Orders that were ordered as a part of Med Plan with the recorded OrderInteger
                        List<drugordersdiseases> planOrderList = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(drugorder.getAssociateddiagnosis(), Context.getPatientService().getPatient(Integer.parseInt(drugorder.getPatientid())));
                        List<drugorders> orderExtn = new ArrayList<drugorders>();
                        
                        for(drugordersdiseases planOrder : planOrderList){
                            associatedOrderMain.put(planOrder.getOrderid(),(DrugOrder) Context.getOrderService().getOrder(planOrder.getOrderid()));
                            orderExtn.add(Context.getService(drugordersService.class).getDrugOrderByOrderID(planOrder.getOrderid()));
                        }
                        associatedOrderExtn.put(Integer.SIZE, orderExtn);
                        
                        for(drugorders extn : orderExtn){
                            otherOrders.put(extn.getOrderid(), pullAssociatedPlanOrders(extn));
                            
                            Person person = Context.getOrderService().getOrder(extn.getOrderid()).getOrderer().getPerson();
                            OrdererName.put(extn.getOrderid(), person.getGivenName()+" "+person.getFamilyName());
                        }
                            
                    } 
                        
                    //Fetch all other Orders placed for the given Patient that are not a part of the same group as recorded Order
                    List<drugorders> allExtn = Context.getService(drugordersService.class).getDrugOrdersByPatient(patient);
                    
                    for(drugorders extn : allExtn){
                        if(!associatedOrderMain.containsKey(extn.getOrderid())){
                            allOrdersExtn.put(extn.getOrderid(), extn);
                            DrugOrder main = (DrugOrder) Context.getOrderService().getOrder(extn.getOrderid());
                            allOrdersMain.put(main.getOrderId(), main);
                        }
                        
                        if(extn.getOrderstatus().equals("Active-Group"))
                            otherOrders.put(extn.getOrderid(), pullAssociatedGroupOrders(extn));
                        else if(extn.getOrderstatus().equals("Active-Plan"))
                            otherOrders.put(extn.getOrderid(), pullAssociatedPlanOrders(extn));
                        
                        Person person = Context.getOrderService().getOrder(extn.getOrderid()).getOrderer().getPerson();
                        OrdererName.put(extn.getOrderid(), person.getGivenName()+" "+person.getFamilyName());
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
        model.addAttribute("assocOrdererName", OrdererName);
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
