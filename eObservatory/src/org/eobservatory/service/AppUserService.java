package org.eobservatory.service;

import java.util.List;

import org.eobservatory.model.AppUser;
import org.eobservatory.util.AppUserFilter;

public interface AppUserService {
	List<AppUser> find(AppUserFilter filter);
	AppUser findOne(String userId);
	int save(AppUser user);
	int signUp(AppUser user);
}
