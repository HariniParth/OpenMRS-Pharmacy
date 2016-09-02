/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.pharmacy;

import java.io.Serializable;
import org.openmrs.BaseOpenmrsObject;
import org.openmrs.BaseOpenmrsMetadata;

/**
 * It is a model class. It should extend either {@link BaseOpenmrsObject} or {@link BaseOpenmrsMetadata}.
 */
public class Pharmacy extends BaseOpenmrsObject implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer id;
        private Integer orderid;
        private String uuid;
        private String orderstatus;
        private String comments;
        private String message;
        private Integer forwardcomments;
        private Integer additionalmessage;
	
        public Pharmacy(){
            
        }
        
	@Override
	public Integer getId() {
		return id;
	}
	
	@Override
	public void setId(Integer id) {
		this.id = id;
	}
        
        public Integer getOrderid() {
            return orderid;
        }

        public void setOrderid(Integer orderid) {
            this.orderid = orderid;
        }
	
        @Override
	public String getUuid() {
		return uuid;
	}
        
        @Override
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
        
        public String getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}
        
        public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
        
        public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
        
        public Integer getForwardcomments() {
            return forwardcomments;
        }

        public void setForwardcomments(Integer forwardcomments) {
            this.forwardcomments = forwardcomments;
        }
        
        public Integer getAdditionalmessage() {
            return additionalmessage;
        }

        public void setAdditionalmessage(Integer additionalmessage) {
            this.additionalmessage = additionalmessage;
        }  
}