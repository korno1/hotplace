package project.com.hotplace.applicants.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.applicants.model.ApplicantsVO;
import project.com.hotplace.applicants.service.ApplicantsService;
import project.com.hotplace.faq.model.FaqVO;
import project.com.hotplace.faq.service.FaqService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class ApplicantsRestController {
	
	@Autowired
	ApplicantsService service;
	
	/** 
	 * Simply selects the home view to render by returning its name.
	 */

	
	@RequestMapping(value = "/party/json/AppselectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public List<ApplicantsVO> selectAll() {
		log.info("/party/json/AppselectAll.do...");
		
		return null;
	}
	
	
	
	
	
}
