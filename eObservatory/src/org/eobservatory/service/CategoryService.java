package org.eobservatory.service;

import java.util.List;

import org.eobservatory.model.Category;

public interface CategoryService {
	List<Category> findCategoryDetails(String neoId);
	List<Category> findCategories(String category);
	void save(Category category);
}
