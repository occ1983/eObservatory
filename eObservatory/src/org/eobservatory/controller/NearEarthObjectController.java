package org.eobservatory.controller;

import java.util.List;

import org.eobservatory.model.Category;
import org.eobservatory.model.CommentDataObject;
import org.eobservatory.model.NearEarthObject;
import org.eobservatory.service.CategoryService;
import org.eobservatory.service.NearEarthObjectService;
import org.eobservatory.util.DataTable;
import org.eobservatory.util.NearEarthObjectFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/nearearthobject")
public class NearEarthObjectController extends DefaultController {
	@Autowired
	private NearEarthObjectService nearEarthObjectService;
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping(value = "/listdisplay", method = RequestMethod.GET)
	public ModelMap listDisplay()
	{
		ModelMap mm = new ModelMap();
		return mm;
	}
	
	@RequestMapping(value = "/listedit", method = RequestMethod.GET)
	public ModelMap listEdit()
	{
		ModelMap mm = new ModelMap();
		return mm;
	}
	
	@RequestMapping(value = "/listneos", method = RequestMethod.POST)
	public ModelAndView listNeos(NearEarthObjectFilter filter)
	{
		return new ModelAndView("nearearthobject/listdisplay", "neos", nearEarthObjectService.listNearEarthObjects(filter));
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@ResponseBody
	public DataTable list(@RequestBody NearEarthObjectFilter filter)
	{
		return new DataTable(nearEarthObjectService.listNearEarthObjects(filter));
	}
	
	@RequestMapping(value = "/neoview", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView neoView(@RequestParam("id") String id)
	{
		return new ModelAndView("nearearthobject/neoview", "id", id);
	}

	@RequestMapping(value = "/neoregistration", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView neoRegistration(@RequestParam("id") String id)
	{
		return new ModelAndView("nearearthobject/neoregistration", "id", id);
	}
	
	@RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
	@ResponseBody
	public NearEarthObject detail(@PathVariable("id") String id)
	{
		return nearEarthObjectService.findNearEarthObject(id);
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.PUT)
	@ResponseBody
	public NearEarthObject save(@RequestBody NearEarthObject object)
	{
		nearEarthObjectService.save(object);
		return object;
	}
	
	@RequestMapping(value = "/addcomment", method = RequestMethod.PUT)
	@ResponseBody
	public boolean addComment(@RequestBody CommentDataObject commentDataObject)
	{
		nearEarthObjectService.addComment(commentDataObject);
		return true;
	}
	
	@RequestMapping(value = "/categorydetails", method = RequestMethod.GET)
	@ResponseBody
	public List<Category> categoryDetails(@RequestParam("neoId") String neoId)
	{
		return categoryService.findCategoryDetails(neoId);
	}
}
