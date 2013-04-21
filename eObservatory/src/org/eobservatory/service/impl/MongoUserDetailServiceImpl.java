package org.eobservatory.service.impl;

import java.util.Collection;
import java.util.HashSet;

import org.eobservatory.dao.AppUserDAO;
import org.eobservatory.model.AppUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public class MongoUserDetailServiceImpl implements UserDetailsService {
	@Autowired
	private AppUserDAO appUserDao;
	
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException, DataAccessException {
		AppUser user = appUserDao.findOne(username);
		
		if (user == null)
		{
			return null;
		}
		
		HashSet<GrantedAuthorityImpl> grantedAuthorities = new HashSet<GrantedAuthorityImpl>();
		
		grantedAuthorities.add(new GrantedAuthorityImpl("ROLE_USER"));
		
		if (user.getRoles() != null)
		{
			for (String role : user.getRoles())
			{
				grantedAuthorities.add(new GrantedAuthorityImpl("ROLE_" + role.toUpperCase()));
			}
			
		}
		
		Collection<GrantedAuthorityImpl> authorities = grantedAuthorities;
		
		return new User(user.getUserId(), user.getPassword(), user.isActive(), true, true, true, authorities);
	}

}
