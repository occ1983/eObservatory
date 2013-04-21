/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.eobservatory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.RedirectView;

/**
 *
 * @author Oscar
 */
@Controller
@RequestMapping(value = "/")
public class RootController {
    @RequestMapping(value = "", method = RequestMethod.GET)
    public RedirectView root()
    {
        return new RedirectView("index");
    }

    @RequestMapping(value = "index", method = RequestMethod.GET)
    public void index()
    {

    }

    @RequestMapping(value = "/welcome", method = RequestMethod.GET)
    public ModelMap doWelcome()
    {
        ModelMap mm = new ModelMap();
        //mm.put("message", "Bienvenidos a TrainingApp!!!!");
        return mm;
    }
}
