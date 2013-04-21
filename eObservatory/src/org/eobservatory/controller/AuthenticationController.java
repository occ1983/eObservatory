package org.eobservatory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author oscar
 */

@Controller
@RequestMapping(value = "/authentication")
public class AuthenticationController {
    
    @RequestMapping(value="/login", method = RequestMethod.GET)
    public ModelAndView login()
    {    
        return new ModelAndView("authentication/login", "model", "hi");
    }

}
