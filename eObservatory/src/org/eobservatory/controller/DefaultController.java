package org.eobservatory.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.eobservatory.util.AppException;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

public class DefaultController {

	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		CustomDateEditor editor = new CustomDateEditor(dateFormat, true);
		binder.registerCustomEditor(Date.class, editor);
		binder.registerCustomEditor(byte[].class, new ByteArrayMultipartFileEditor());
	}

	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public ModelAndView handleException(Exception ex) {
		MappingJacksonJsonView jsonView = new MappingJacksonJsonView();
		HashMap map = new HashMap();
		map.put("result", 1);
		map.put("message", "Application Error.");
		System.out.println("Error: " + ex.getMessage());
		ex.printStackTrace();
		return new ModelAndView(jsonView, map);
	}

	@ExceptionHandler(AppException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ModelAndView handleGestionAdmException(Exception ex) {
        MappingJacksonJsonView jsonView = new MappingJacksonJsonView();
        HashMap map = new HashMap();
        map.put("result", 1);
        map.put("message", ex.getMessage());
        return new ModelAndView(jsonView, map);
    }
}
