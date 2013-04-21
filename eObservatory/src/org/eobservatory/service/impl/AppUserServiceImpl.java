package org.eobservatory.service.impl;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.eobservatory.dao.AppUserDAO;
import org.eobservatory.model.AppUser;
import org.eobservatory.service.AppUserService;
import org.eobservatory.util.AppException;
import org.eobservatory.util.AppUserFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppUserServiceImpl implements AppUserService {
	@Autowired
	private AppUserDAO appUserDAO;

	@Override
	public List<AppUser> find(AppUserFilter filter) {
		return appUserDAO.list(filter);
	}

	@Override
	public AppUser findOne(String userId) {
		return appUserDAO.findOne(userId);
	}

	@Override
	public int save(AppUser user) {
		MessageDigest digest = null;
		AppUser previousUser = appUserDAO.findOne(user.getUserId());
		
		if (previousUser == null)
		{
			previousUser = new AppUser();
		}
		
		previousUser.setActive(true);
		previousUser.setCity(user.getCity());
		previousUser.setCompany(user.getCompany());
		previousUser.setCountry(user.getCountry());
		previousUser.setFirstName(user.getFirstName());
		previousUser.setLastName(user.getLastName());
		
		try {
			digest = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if (user.getPassword() != null && !user.getPassword().equals(""))
		{
			byte[] bytes = user.getPassword().getBytes();
			byte[] bytesdigest = digest.digest(bytes);
			
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < bytesdigest.length; i++) {
	        	sb.append(Integer.toString((bytesdigest[i] & 0xff) + 0x100, 16).substring(1));
	        }
			
			user.setPassword(sb.toString());
		}
		
		return appUserDAO.save(user);
	}

	@Override
	public int signUp(AppUser user) {
		AppUser previousUser = appUserDAO.findOne(user.getUserId());
		
		if (previousUser != null)
		{
			throw new AppException("That user name has already been chosen.");
		}
		
		user.setRegistrationDate(new Date());
		user.setActive(true);
		user.setRoles(new ArrayList<String>());
		user.getRoles().add("site_user");
		
		save(user);
		
		return 1;
	}

}
