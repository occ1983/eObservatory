package org.eobservatory.dao.impl;

import java.util.List;

import org.eobservatory.dao.CategoryDAO;
import org.eobservatory.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDAOImpl implements CategoryDAO {
	@Autowired
	private MongoTemplate mongoTemplate;

	@Override
	public List<Category> list(String category) {
		Query query = new Query();
		query.addCriteria(Criteria.where("category").regex(category, "i"));
		return mongoTemplate.find(query, Category.class);
	}

	@Override
	public void save(Category category) {
		mongoTemplate.save(category);
	}

	@Override
	public Category find(String id) {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(id));
		return mongoTemplate.findOne(query, Category.class);
	}

}
