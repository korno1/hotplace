package project.com.hotplace.event.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class EventController {
	
	
	/** 
	 * Simply selects the home view to render by returning its name.
	 */

	
	@RequestMapping(value = "/event/selectAll.do", method = RequestMethod.GET)
	public String selectAll() {
		log.info("/event/selectAll.do...");
		
		
		return "event/selectAll";
	}
	
	@RequestMapping(value = "/event/selectOne.do", method = RequestMethod.GET)
	public String selectOne() {
		log.info("/event/selectOne.do...");
		
		
		return "event/selectOne";
	}
	
	
	
}
