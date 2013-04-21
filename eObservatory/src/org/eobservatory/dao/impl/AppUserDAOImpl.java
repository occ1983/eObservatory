package org.eobservatory.dao.impl;

import java.util.List;

import org.eobservatory.dao.AppUserDAO;
import org.eobservatory.model.AppUser;
import org.eobservatory.util.AppUserFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class AppUserDAOImpl implements AppUserDAO {
	@Autowired
	private MongoTemplate mongoTemplate;

	@Override
	public List<AppUser> list(AppUserFilter filter) {
		Query query = new Query();
		
		if (filter.getFirstName() != null)
		{
			query.addCriteria(Criteria.where("firstName").regex("" + filter.getFirstName() + "", "i"));
		}
		
		if (filter.getLastName() != null)
		{
			query.addCriteria(Criteria.where("lastName").regex("" + filter.getLastName() + "", "i"));
		}
		
		if (filter.getRegistrationFrom() != null && filter.getRegistrationTo() != null)
		{
			query.addCriteria(Criteria.where("registrationDate").gte(filter.getRegistrationFrom()).and("registrationDate").lte(filter.getRegistrationTo()));
		}
		
		return mongoTemplate.find(query, AppUser.class);
	}

	@Override
	public AppUser findOne(String userId) {
		Query query = new Query();
		query.addCriteria(Criteria.where("userId").is(userId));
		return mongoTemplate.findOne(query, AppUser.class);
	}

	@Override
	public int save(AppUser user) {
		mongoTemplate.save(user);
		return 1;
	}

}
