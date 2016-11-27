/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.openmrs.DrugOrder;
import org.openmrs.Person;
import org.openmrs.Provider;
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
 * This Fragment lists the Active Orders placed for the Patient according to Search Results
 */
public class SearchOrderViewFragmentController {
    
    
    public void controller(PageModel model,@RequestParam(value = "patient_full_name", required = false) String patient_full_name,
                            @RequestParam(value = "action", required = false) String action){
       
        String patient_name = patient_full_name.trim();
        model.addAttribute("patient_name", patient_name);
                                
        if(!(patient_name).equals("")){
            try {
                    boolean patient_found = false;
                    Date patient_DOB = null;
                    String patient_address = null;
                    String patient_identifier = null;
                    String provider_identifier;
                    HashMap<Integer,String> providerIdentifiers = new HashMap<Integer,String>();
                    
                    List<Integer> orders = new ArrayList<Integer>();
                    HashMap<Integer,DrugOrder> drugOrdersMain = new HashMap<Integer,DrugOrder>();
                    HashMap<Integer,drugorders> drugOrdersExtension = new HashMap<Integer,drugorders>();
                    HashMap<Integer,List<String>> otherOrders = new HashMap<Integer,List<String>>();
                    
                    //Find if there are any Active Orders for the given Patient. If yes, record Patient's ID and Demographic details
                    List<drugorders> allOrders = Context.getService(drugordersService.class).getAllDrugOrders();
                        
                    for(drugorders order : allOrders){
                        Person person = Context.getPersonService().getPerson(Integer.parseInt(order.getPatientid()));

                        if((person.getGivenName()+" "+person.getFamilyName()).equals(patient_name)){
                            patient_found = true;
                            model.addAttribute("PatientFound", patient_found);
                            orders.add(order.getOrderId());
                            patient_DOB = person.getBirthdate();
                            patient_address = person.getPersonAddress().getAddress1() + " " + person.getPersonAddress().getCityVillage() + " " + person.getPersonAddress().getStateProvince() + " Zipcode:" + person.getPersonAddress().getPostalCode() + " " + person.getPersonAddress().getCountry();
                            patient_identifier = Context.getPatientService().getPatient(Integer.parseInt(order.getPatientid())).getPatientIdentifier().toString();
                        }
                    }
                    
                    //If Patient is found, retrieve the DrugOrder Main and Extension data
                    if(patient_found){
                        for(Integer order : orders){
                            DrugOrder drugOrderMain = (DrugOrder) Context.getOrderService().getOrder(order);
                            drugOrdersMain.put(order,drugOrderMain);
                            
                            drugorders drugOrderExtension = Context.getService(drugordersService.class).getDrugOrderByOrderID(drugOrderMain.getOrderId());
                            drugOrdersExtension.put(order,drugOrderExtension);
                            
                            //Retrieve the list of other Orders placed as a Group with the selected Order
                            if(drugOrderExtension.getOrderstatus().equals("Active-Group")){
                                List<drugorders> otherOrdersInGroup = Context.getService(drugordersService.class).getDrugOrdersByGroupID(drugOrderExtension.getGroupid());
                                ArrayList<String> otherOrdersDrugName = new ArrayList<String>();
                                for(drugorders otherOrder : otherOrdersInGroup){
                                    otherOrdersDrugName.add(otherOrder.getDrugname().getDisplayString());
                                }
                                otherOrders.put(drugOrderExtension.getOrderId(),otherOrdersDrugName);
                            } 
                            
                            //Retrieve the list of other Orders placed as a Med Plan Order with the selected Order
                            else if(drugOrderExtension.getOrderstatus().equals("Active-Plan")){
                                List<drugordersdiseases> planOrderList = Context.getService(drugordersdiseasesService.class).getDrugOrdersByDiseaseAndPatient(drugOrderExtension.getAssociateddiagnosis(), Context.getPatientService().getPatient(Integer.parseInt(drugOrderExtension.getPatientid())));
                                ArrayList<String> otherOrdersDrugName = new ArrayList<String>();

                                for(drugordersdiseases planOrder : planOrderList){
                                    drugorders otherOrder = Context.getService(drugordersService.class).getDrugOrderByOrderID(planOrder.getOrderid());
                                    otherOrdersDrugName.add(otherOrder.getDrugname().getDisplayString());
                                }
                                otherOrders.put(drugOrderExtension.getOrderId(), otherOrdersDrugName);
                            }
                            
                            Provider provider = Context.getOrderService().getOrder(drugOrderMain.getOrderId()).getOrderer();
                            provider_identifier = provider.getPerson().getGivenName() + " " + provider.getPerson().getFamilyName() + ", " + StringUtils.capitalize(provider.getIdentifier());
                            providerIdentifiers.put(order, provider_identifier);
                        }
                        
                        model.addAttribute("patient_DOB", patient_DOB);
                        model.addAttribute("patient_address", patient_address);
                        model.addAttribute("patient_identifier", patient_identifier);
                        model.addAttribute("providerIdentifiers",providerIdentifiers);
                        
                        model.addAttribute("drugOrdersMain", drugOrdersMain);
                        model.addAttribute("drugOrdersExtension", drugOrdersExtension);
                        model.addAttribute("otherOrders", otherOrders);
                    }
                    
                    if(!patient_found){
                        model.addAttribute("PatientFound", patient_found);
                    }
            }
            catch (NumberFormatException e){
                System.out.println(e.toString());
            } catch (APIException e) {
                System.out.println(e.toString());
            }
        }
    }
}