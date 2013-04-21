package org.eobservatory.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.eobservatory.dao.CategoryDAO;
import org.eobservatory.dao.NearEarthObjectDAO;
import org.eobservatory.model.Category;
import org.eobservatory.model.NearEarthObject;
import org.eobservatory.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	private CategoryDAO categoryDao;
	@Autowired
	private NearEarthObjectDAO nearEarthObjectDao;

	@Override
	public List<Category> findCategories(String category) {
		return categoryDao.list(category);
	}

	@Override
	public void save(Category category) {
		categoryDao.save(category);
	}

	@Override
	public List<Category> findCategoryDetails(String neoId) {
		List<Category> categories = new ArrayList<Category>();
		NearEarthObject neo = nearEarthObjectDao.findOne(neoId);
		
		for (String categoryId : neo.getCategories())
		{
			categories.add(categoryDao.find(categoryId));
		}
		
		return categories;
	}

}
