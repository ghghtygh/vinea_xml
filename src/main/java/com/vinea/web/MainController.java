package com.vinea.web;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

private Logger logger = Logger.getLogger(this.getClass());

	@RequestMapping(value="/")
	public String index(){
		
		return "index";
	}


}
