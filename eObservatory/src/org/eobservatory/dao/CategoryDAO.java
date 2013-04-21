package org.eobservatory.dao;

import java.util.List;

import org.eobservatory.model.Category;

public interface CategoryDAO {
	List<Category> list(String category);
	Category find(String id);
	void save(Category category);
}
