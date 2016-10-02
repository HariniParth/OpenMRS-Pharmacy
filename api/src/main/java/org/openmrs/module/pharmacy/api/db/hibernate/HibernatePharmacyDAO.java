/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.pharmacy.api.db.hibernate;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.openmrs.module.pharmacy.Pharmacy;
import org.openmrs.module.pharmacy.api.db.PharmacyDAO;

/**
 * It is a default implementation of  {@link PharmacyDAO}.
 */
public class HibernatePharmacyDAO implements PharmacyDAO {
    
    protected final Log log = LogFactory.getLog(this.getClass());
	
    private SessionFactory sessionFactory;
	
    /**
        * @param sessionFactory the sessionFactory to set
    */
    public void setSessionFactory(SessionFactory sessionFactory) {
	    this.sessionFactory = sessionFactory;
    }
    
    /**
        * @return the sessionFactory
    */
    public SessionFactory getSessionFactory() {
	    return sessionFactory;
    }
    
    @Override
    public Pharmacy savePharmaOrder(Pharmacy pharmaOrder){
        sessionFactory.getCurrentSession().saveOrUpdate(pharmaOrder);
        return pharmaOrder;
    }
    
    @Override
    public Pharmacy getPharmaOrder(Integer orderID){
        return (Pharmacy) sessionFactory.getCurrentSession().get(Pharmacy.class, orderID);
    }
    
    @Override
    public String getPharmaComments(Integer orderID){
        Criteria crit = sessionFactory.getCurrentSession().createCriteria(
                Pharmacy.class);
        crit.setProjection(Projections.property("comments"));
        List allComments = crit.list();
        return (String) allComments.get(orderID);
    }
    
    @Override
    public String getPharmaMessage(Integer orderID){
        Criteria crit = sessionFactory.getCurrentSession().createCriteria(
                Pharmacy.class);
        crit.setProjection(Projections.property("message"));
        List allMessages = crit.list();
        return (String) allMessages.get(orderID);
    }

}