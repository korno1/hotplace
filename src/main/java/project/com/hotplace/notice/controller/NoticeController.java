package project.com.hotplace.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.notice.service.NoticeService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class NoticeController {
	
	@Autowired
	NoticeService service;
	
	/** 
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/not_selectAll.do", method = RequestMethod.GET)
	public String selectAll() {
		log.info("/not_selectAll.do...");
		
		
		return "notice/selectAll";
	}
	
}
