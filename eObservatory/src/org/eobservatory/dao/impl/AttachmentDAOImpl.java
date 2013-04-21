package org.eobservatory.dao.impl;

import org.eobservatory.dao.AttachmentDAO;
import org.eobservatory.model.Attachment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AttachmentDAOImpl implements AttachmentDAO {
	@Autowired
	private MongoTemplate mongoTemplate;

	@Override
	public Attachment find(String id) {
		return mongoTemplate.findById(id, Attachment.class);
	}

	@Override
	public void save(Attachment attachment) {
		mongoTemplate.save(attachment);
	}

	@Override
	public void remove(String id) {
		mongoTemplate.remove(find(id));
	}

}
