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
	public List<ApplicantsVO> selectAll(ApplicantsVO vo) {
		log.info("/party/json/AppselectAll.do...{}", vo);
		
		// vo = partyNum & status
		
		List<ApplicantsVO> vos = service.selectAll(vo);
		
		return vos;
	}
	
	@RequestMapping(value = "/party/json/AppinsertOK.do", method = RequestMethod.GET)
	@ResponseBody
	public int insertOK(ApplicantsVO vo) {
		log.info("/party/json/AppinsertOK.do...{}", vo);
		// partyNum = parameter
		// userNum = session
		// comments, status = view

		int result = service.insert(vo);
		
		return result;
	}
	
	@RequestMapping(value = "/party/json/AppapproveOK.do", method = RequestMethod.GET)
	@ResponseBody
	public int approveOK(ApplicantsVO vo) {
		log.info("/party/json/AppapproveOK.do...{}", vo);
		// applicantsNum = view

		int result = service.approve(vo);
		
		return result;
	}
	
	@RequestMapping(value = "/party/json/ApprejectOK.do", method = RequestMethod.GET)
	@ResponseBody
	public int rejectOK(ApplicantsVO vo) {
		log.info("/party/json/ApprejectOK.do...{}", vo);
		// applicantsNum = view

		int result = service.reject(vo);
		
		return result;
	}
	
	
	
	
	
}
