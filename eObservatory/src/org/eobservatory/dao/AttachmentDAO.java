package org.eobservatory.dao;

import org.eobservatory.model.Attachment;

public interface AttachmentDAO {
	Attachment find(String id);
	void save(Attachment attachment);
	void remove(String id);
}
