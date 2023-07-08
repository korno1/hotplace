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
	public int selectAll(String searchKey, String searchWord, Integer status) {
		log.info("/par_selectAll.do...");
		
		int cnt = service.selectAll(searchKey, searchWord, status).size();
		log.info("cnt: {}", cnt);
		
		return cnt;
	}
	
	@RequestMapping(value = "/party/json/searchList.do", method = RequestMethod.GET)
	@ResponseBody
	public List<PartyVO> searchList(String searchKey, String searchWord, int page, Integer status) {
		log.info("/party/json/selectAll.do...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);
		
		
		List<PartyVO> vos = service.searchList(searchKey, searchWord, page, status);
		log.info("vos: {}", vos);
		
		return vos;
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
