package project.com.hotplace.faq.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class FaqController {
	
	
	/** 
	 * Simply selects the home view to render by returning its name.
	 */

	
	@RequestMapping(value = "/faq/selectAll.do", method = RequestMethod.GET)
	public String selectAll() {
		log.info("/faq/selectAll.do...");
		
		
		return "faq/selectAll";
	}
	
	@RequestMapping(value = "/faq/insert.do", method = RequestMethod.GET)
	public String insert() {
		log.info("/faq/insert.do...");
		
		
		return "faq/insert";
	}
	
	@RequestMapping(value = "/faq/update.do", method = RequestMethod.GET)
	public String update() {
		log.info("/faq/update.do...");
		
		
		return "faq/update";
	}
	
	
}
