package org.eobservatory.service;

import java.io.InputStream;

import org.eobservatory.model.Attachment;

import com.mongodb.gridfs.GridFSDBFile;

public interface AttachmentService {
	Attachment find(String id);
	GridFSDBFile getFileByAttachmentId(String id);
	void save(Attachment attachment, InputStream inputStream);
	void remove(String id);
}
