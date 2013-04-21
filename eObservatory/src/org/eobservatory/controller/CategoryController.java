package org.eobservatory.controller;

import java.util.List;

import org.eobservatory.model.Category;
import org.eobservatory.service.CategoryService;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping(value = "/category")
public class CategoryController extends DefaultController {
	@Autowired
	private CategoryService categoryService;

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@ResponseBody
	public List<Category> list(@RequestParam("category") String category)
	{
		return categoryService.findCategories(category);
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.PUT)
	@ResponseBody
	public boolean save(@RequestBody Category category)
	{
		categoryService.save(category);
		return true;
	}
	
}
