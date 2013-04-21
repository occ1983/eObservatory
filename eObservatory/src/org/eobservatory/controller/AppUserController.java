package org.eobservatory.controller;

import java.util.List;

import org.eobservatory.model.AppUser;
import org.eobservatory.service.AppUserService;
import org.eobservatory.util.AppUserFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/user")
public class AppUserController extends DefaultController {
	@Autowired
	private AppUserService appUserService;
	
	@RequestMapping(value = "/userlist", method = RequestMethod.GET)
	public void userList()
	{
		
	}
	
	@RequestMapping(value = "/list1", method = RequestMethod.GET)
	@ResponseBody
	public List<AppUser> list1()
	{
		AppUserFilter filter = new AppUserFilter();
		filter.setFirstName("ar");
		filter.setLastName("on");
		
		//filter.setRegistrationFrom(new Date)
		return appUserService.find(filter);
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@ResponseBody
	public List<AppUser> list(@RequestBody AppUserFilter filter)
	{
		return appUserService.find(filter);
	}
	
	@RequestMapping(value = "/findone", method = RequestMethod.POST)
	@ResponseBody
	public AppUser findOne(@RequestBody AppUser user)
	{
		return appUserService.findOne(user.getUserId());
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.PUT)
	@ResponseBody
	public int save(@RequestBody AppUser user)
	{
		return appUserService.save(user);
	}
	
	@RequestMapping(value = "/preparesignup", method = RequestMethod.GET)
	public void prepareSignUp()
	{
		
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.PUT)
	@ResponseBody
	public int signUp(@RequestBody AppUser user)
	{
		return appUserService.signUp(user);
	}
}
