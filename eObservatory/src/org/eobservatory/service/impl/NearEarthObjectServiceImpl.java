package org.eobservatory.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.eobservatory.dao.AttachmentDAO;
import org.eobservatory.dao.NearEarthObjectDAO;
import org.eobservatory.model.AppUser;
import org.eobservatory.model.Attachment;
import org.eobservatory.model.Comment;
import org.eobservatory.model.CommentDataObject;
import org.eobservatory.model.NearEarthObject;
import org.eobservatory.service.NearEarthObjectService;
import org.eobservatory.util.NearEarthObjectFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

@Service
public class NearEarthObjectServiceImpl implements NearEarthObjectService {
	@Autowired
	private NearEarthObjectDAO nearEarthObjectDao;
	@Autowired
	private AttachmentDAO attachmentDao;

	@Override
	public List<NearEarthObject> listNearEarthObjects(NearEarthObjectFilter filter) {
		return nearEarthObjectDao.list(filter);
	}

	@Override
	public NearEarthObject findNearEarthObject(String id) {
		NearEarthObject neo = nearEarthObjectDao.findOne(id);
		
		List<Attachment> attachmentObjects = new ArrayList<Attachment>();
		
		for (String attachmentId : neo.getAttachments())
		{
			Attachment attachment = attachmentDao.find(attachmentId);
			attachmentObjects.add(attachment);
		}
		
		neo.setAttachmentObjects(attachmentObjects);
		
		return neo;
	}

	@Override
	public void save(NearEarthObject nearEarthObject) {
		String username = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUsername();
		nearEarthObject.setAttachmentObjects(null);
		nearEarthObject.setUserId(username);
		
		nearEarthObjectDao.save(nearEarthObject);
	}

	@Override
	public void addComment(CommentDataObject commentDataObject) {
		String userId = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUsername();
		Comment comment = new Comment();
		comment.setComment(commentDataObject.getComment());
		comment.setCommentDate(new Date());
		comment.setRating(commentDataObject.getRating());
		comment.setUserId(userId);
		
		NearEarthObject neo = findNearEarthObject(commentDataObject.getNeoId());
		
		if (neo.getComments() == null)
		{
			neo.setComments(new ArrayList<Comment>());
		}
		
		neo.getComments().add(comment);
		nearEarthObjectDao.save(neo);
	}

}
