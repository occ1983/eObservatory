package org.eobservatory.dao.impl;

import java.util.List;

import org.eobservatory.dao.NearEarthObjectDAO;
import org.eobservatory.model.NearEarthObject;
import org.eobservatory.util.NearEarthObjectFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class NearEarthObjectDAOImpl implements NearEarthObjectDAO {
	@Autowired
	private MongoTemplate mongoTemplate;

	@Override
	public List<NearEarthObject> list(NearEarthObjectFilter filter) {
		Query query = new Query();
		
		if (filter.getCode() != null && !"".equals(filter.getCode()))
		{
			query.addCriteria(Criteria.where("code").is(filter.getCode()));
		}
		
		if (filter.getUserId() != null && !"".equals(filter.getUserId()))
		{
			query.addCriteria(Criteria.where("userId").is(filter.getUserId()));
		}
		
		return mongoTemplate.find(query, NearEarthObject.class);
	}

	@Override
	public NearEarthObject findOne(String id) {
		Query query = new Query(); 
		query.addCriteria(Criteria.where("_id").is(id));		
		return mongoTemplate.findOne(query, NearEarthObject.class);
	}

	@Override
	public void save(NearEarthObject nearEarthObject) {
		mongoTemplate.save(nearEarthObject);
	}

}
