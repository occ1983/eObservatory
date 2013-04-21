package org.eobservatory.dao;

import java.util.List;

import org.eobservatory.model.AppUser;
import org.eobservatory.util.AppUserFilter;

public interface AppUserDAO {
	List<AppUser> list(AppUserFilter filter);
	AppUser findOne(String userId);
	int save(AppUser user);
}
