package project.com.hotplace.party.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.party.model.PartyVO;
import project.com.hotplace.party.service.PartyService;

@Controller
@Slf4j
public class PartyRestController {
	
	@Autowired
	private PartyService service;
	
	@RequestMapping(value = "/party/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public List<PartyVO> myParty(PartyVO vo, Integer page) {
		log.info("/myParty.do...{}", vo);
		
		if(page == null) {
			page = 1;
		}
		
		List<PartyVO> vos = service.myParty(vo, page);
		log.info("vos: {}", vos.toString());
		log.info("vos: {}", vos.size());
		
		return vos;
	}

	@RequestMapping(value = "/party/json/par_totalCount.do", method = RequestMethod.GET)
	@ResponseBody
	public int totalCount(PartyVO vo) {
		log.info("/par_totalCount.do...{}", vo);
		
		int totalCount = service.totalCount(vo);
		
		log.info("totalCount: {}", totalCount);
		
	    return totalCount;
	}

	@RequestMapping(value = "/party/json/approveOK.do", method = RequestMethod.POST)
	public String approveOK(PartyVO vo) {
		log.info("/approveOK.do...{}", vo);
		
		int result = service.approveOK(vo);
		log.info("result: {}", result);
		
		String msg = "";

		if (result == 1) {
			msg = "{\"result\" : 1}";
		} else
			msg = "{\"result\" : 0}";

		return msg;
	}
	
} 
