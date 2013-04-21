package org.eobservatory.service.impl;

import java.io.InputStream;

import org.bson.types.ObjectId;
import org.eobservatory.dao.AttachmentDAO;
import org.eobservatory.model.Attachment;
import org.eobservatory.service.AttachmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

import com.mongodb.DB;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSInputFile;

@Service
public class AttachmentServiceImpl implements AttachmentService {
	@Autowired
	private AttachmentDAO attachmentDao;
	@Autowired
	private GridFS gridFs;
	
	@Override
	public Attachment find(String id) {
		return attachmentDao.find(id);
	}
	
	@Override
	public void save(Attachment attachment, InputStream inputStream) {
		GridFSInputFile input = gridFs.createFile(inputStream, attachment.getFileName(), true);
		input.setContentType(attachment.getContentType());
		input.save();
		
		attachment.setFileId(input.getId().toString());
		
		attachmentDao.save(attachment);
	}

	@Override
	public void remove(String id) {
		gridFs.remove(gridFs.findOne(new ObjectId(id)));
		attachmentDao.remove(id);
	}

	@Override
	public GridFSDBFile getFileByAttachmentId(String id) {
		Attachment attachment = attachmentDao.find(id);
		return gridFs.findOne(new ObjectId(attachment.getFileId())); 
	}

}
