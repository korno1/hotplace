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
import project.com.hotplace.party.service.PartyService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class ApplicantsRestController {
	
	@Autowired
	ApplicantsService service;
	
	@Autowired
	PartyService service2;

	@RequestMapping(value = "/party/json/AppselectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public List<ApplicantsVO> selectAll(ApplicantsVO vo) {
		log.info("/party/json/AppselectAll.do...{}", vo);
		
		// vo = partyNum & status
		
		List<ApplicantsVO> vos = service.selectAll(vo);
		log.info("vos:{}", vos);
		
		
		return vos;
	}
	
	@RequestMapping(value = "/party/json/AppinsertOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String insertOK(ApplicantsVO vo) {
		log.info("/party/json/AppinsertOK.do...{}", vo);

		int result = service.insert(vo);
		
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}";
		}
		else msg = "{\"result\" : 0}";
		
		
		return msg;
	}
	
	@RequestMapping(value = "/party/json/AppapproveOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String approveOK(ApplicantsVO vo) {
		log.info("/party/json/AppapproveOK.do...{}");
		// applicantsNum = view

		int result = service.approve(vo);
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}"; // {"result" : 1}
		}
		else msg = "{\"result\" : 0}";
		
		return msg;
	}
	
	@RequestMapping(value = "/party/json/ApprejectOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String rejectOK(ApplicantsVO vo) {
		log.info("/party/json/ApprejectOK.do...{}", vo);
		// applicantsNum = view

		int result = service.reject(vo);
		
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}"; // {"result" : 1}
		}
		else msg = "{\"result\" : 0}";
		
		
		return msg;
	}
	
	@RequestMapping(value = "/party/json/deleteOK.do", method = RequestMethod.GET)
	@ResponseBody
	public String deleteOK(ApplicantsVO vo) {
		log.info("/party/json/deleteOK.do...{}", vo);
		
		int result = service.delete(vo);
		
		String msg = "";

		if (result == 1) {
			msg = "{\"result\" : 1}";
		} else
			msg = "{\"result\" : 0}";

		return msg;
	}
	
	
	
	
	
}
