package org.eobservatory.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eobservatory.model.Attachment;
import org.eobservatory.service.AttachmentService;
import org.eobservatory.util.FileUploadBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mongodb.gridfs.GridFSDBFile;

@Controller
@RequestMapping(value = "/attachment")
public class AttachmentController extends DefaultController {
	@Autowired
	private AttachmentService attachmentService;
	
	@RequestMapping(value = "/uploadfile", method = RequestMethod.POST)
	@ResponseBody
	public Attachment uploadFile(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("fileUploadBean") Object command) throws IllegalStateException, IOException, ServletException
	{
		Attachment attachment = new Attachment();
		attachment.setContentType(request.getContentType());
		//attachment.setFileName(request.getPart("file").getName());
		attachment.setFileName("Image");
		
		FileUploadBean bean = (FileUploadBean) command;
		byte[] file = bean.getFile();
		ByteArrayInputStream bis = new ByteArrayInputStream(file);
		
		attachmentService.save(attachment, bis);
		return attachment;
	}
	
	@RequestMapping(value = "/getfilebyattachmentid", method = RequestMethod.GET)
	public ModelAndView getFileByAttachmentId(@RequestParam("id") String id, HttpServletResponse response) throws IOException
	{
		GridFSDBFile dbFile = attachmentService.getFileByAttachmentId(id);
		
		if (dbFile != null)
		{
			dbFile.writeTo(response.getOutputStream());
		}
		return null;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	@ResponseBody
	public int delete(@RequestParam("id") String id)
	{
		attachmentService.remove(id);
		return 1;
	}
	
	@RequestMapping(value = "/imagemanager", method = RequestMethod.GET)
	public ModelAndView imageManager(@RequestParam("attachmentId") String attachmentId)
	{
		return new ModelAndView("attachment/imagemanager", "attachmentId", attachmentId);
	}
	
	@ModelAttribute("fileUploadBean")
	public Object createCommandObject()
	{
		return new FileUploadBean();
	}
}
