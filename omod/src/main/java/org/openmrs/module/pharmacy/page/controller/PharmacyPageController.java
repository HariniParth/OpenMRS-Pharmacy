/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.page.controller;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.openmrs.DrugOrder;
import org.openmrs.Order;
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
public class PharmacyPageController {
    
    public void controller(PageModel model,@RequestParam(value = "order_id_display", required = false) String order_id_display,
                            @RequestParam(value = "pharma_order_id", required = false) String pharma_order_id,
                            @RequestParam(value = "search_order_id", required = false) String search_order_id,
                            @RequestParam(value = "search_patient_id", required = false) String search_patient_id,
                            @RequestParam(value = "pharma_action_order_id", required = false) String pharma_action_order_id,
                            @RequestParam(value = "action", required = false) String action){

        model.addAttribute("search_order_id", search_order_id);
        model.addAttribute("search_patient_id", search_patient_id);
        model.addAttribute("pharma_order_id", pharma_order_id);
        model.addAttribute("order_id_display", order_id_display);
        model.addAttribute("pharma_action_order_id", pharma_action_order_id);
        
        if(!(search_order_id).equals("")){
            DrugOrder dorder_main = (DrugOrder) Context.getOrderService().getOrder(Integer.parseInt(search_order_id));
            model.addAttribute("dorder_main", dorder_main);
            
            drugorders dorder_extension = Context.getService(drugordersService.class).getNewTable(dorder_main.getOrderId());
            model.addAttribute("dorder_extension", dorder_extension);
            
            List<Patient> pharma_patients = Context.getPatientService().getAllPatients(true);
            for(Patient pharma_patient : pharma_patients){
                if(Integer.toString(pharma_patient.getPatientId()).equals(dorder_extension.getPatientid())){
                    String pharma_patient_name = Context.getPersonService().getPerson(pharma_patient).getGivenName() + " " + Context.getPersonService().getPerson(pharma_patient).getFamilyName();
                    model.addAttribute("pharma_patient_name", pharma_patient_name);
                }
            }
        }
        
        if(!(search_patient_id).equals("")){
            List<Patient> pharma_patients = Context.getPatientService().getAllPatients();
            for(Patient pharma_patient : pharma_patients){
                if((pharma_patient.getPatientIdentifier().getIdentifier()).equals(search_patient_id)){
                    List<Order> orders = Context.getOrderService().getAllOrdersByPatient(pharma_patient);
                    ArrayList<DrugOrder> drugOrdersMain = new ArrayList<DrugOrder>();
                    ArrayList<drugorders> dorders_extension = new ArrayList<drugorders>();
                    int drugOrderTypeId = Context.getOrderService().getOrderTypeByName("Drug Order").getOrderTypeId();
                    DrugOrder drugOrderMain;

                    for (Order order : orders) {
                        if (order.getOrderType().getOrderTypeId() == drugOrderTypeId){
                            drugOrderMain = (DrugOrder) Context.getOrderService().getOrder(order.getOrderId());
                            drugOrdersMain.add(drugOrderMain);
                            
                            drugorders dorder_extension = Context.getService(drugordersService.class).getNewTable(drugOrderMain.getOrderId());
                            dorders_extension.add(dorder_extension);
                        }
                    }
                    model.addAttribute("dorders_main", drugOrdersMain);
                    model.addAttribute("dorders_extension", dorders_extension);
                    
                    String pharma_patient_name = Context.getPersonService().getPerson(pharma_patient).getGivenName() + " " + Context.getPersonService().getPerson(pharma_patient).getFamilyName();
                    model.addAttribute("pharma_patient_name", pharma_patient_name);
                }
            }
        }
        
        if(StringUtils.isNotBlank(action)){
            try {
                if("Dispatch".equals(action)){
                    String order_status = "Dispatch";
                    model.addAttribute("order_status", order_status);
                } 
                if("Hold".equals(action)){
                    String order_status = "Hold";
                    model.addAttribute("order_status", order_status);
                }
                if("Drop".equals(action)){
                    String order_status = "Drop";
                    model.addAttribute("order_status", order_status);
                }
            }
            catch (Exception e){
                System.out.println(e.toString());
            }
        }
    }
}