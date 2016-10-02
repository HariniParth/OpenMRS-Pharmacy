/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.pharmacy.api.impl;

import org.openmrs.api.impl.BaseOpenmrsService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.pharmacy.Pharmacy;
import org.openmrs.module.pharmacy.api.PharmacyService;
import org.openmrs.module.pharmacy.api.db.PharmacyDAO;

/**
 * It is a default implementation of {@link PharmacyService}.
 */
public class PharmacyServiceImpl extends BaseOpenmrsService implements PharmacyService {
	
    protected final Log log = LogFactory.getLog(this.getClass());

    private PharmacyDAO dao;
	
    /**
        * @param dao the dao to set
    */
    public void setDao(PharmacyDAO dao) {
	    this.dao = dao;
    }
    
    /**
        * @return the dao
    */
    public PharmacyDAO getDao() {
	    return dao;
    }
    
    @Override
    public Pharmacy savePharmaOrder(Pharmacy pharmaOrder){
        return dao.savePharmaOrder(pharmaOrder);
    }
    
    @Override
    public Pharmacy getPharmaOrder(Integer orderID){
        return dao.getPharmaOrder(orderID);
    }

    @Override
    public String getPharmaComments(Integer orderID){
        return dao.getPharmaComments(orderID);
    }
    
    @Override
    public String getPharmaMessage(Integer orderID){
        return dao.getPharmaMessage(orderID);
    }
}