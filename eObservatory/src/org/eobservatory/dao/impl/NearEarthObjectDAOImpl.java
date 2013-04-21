package org.eobservatory.dao.impl;

import java.util.List;

import org.eobservatory.dao.NearEarthObjectDAO;
import org.eobservatory.model.NearEarthObject;
import org.eobservatory.util.NearEarthObjectFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Order;
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
		
		if (filter.getDiscoveryFrom() != null)
		{
			query.addCriteria(Criteria.where("discoveryDate").gte(filter.getDiscoveryFrom()));
			//query.addCriteria(Criteria.where("discoveryDate").lte(filter.getDiscoveryTo()));
		}
		
		if (filter.getRowCount() != 0 && filter.getPageNumber() != 0)
		{
			query.limit(filter.getRowCount());
			query.skip(filter.getPageNumber());
		}
		
		System.out.println("Sorting...");
		
		query.sort().on("discoveryDate", Order.DESCENDING);
		
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
		nearEarthObject.setAttachmentObjects(null);
		mongoTemplate.save(nearEarthObject);
	}

}
