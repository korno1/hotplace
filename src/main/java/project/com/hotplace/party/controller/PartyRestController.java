package project.com.hotplace.party.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public int selectAll(String searchKey, String searchWord) {
		log.info("/par_selectAll.do...");
		
		int cnt = service.selectAll(searchKey, searchWord).size();
		log.info("cnt: {}", cnt);
		
		return cnt;
	}
	
	@RequestMapping(value = "/party/json/searchList.do", method = RequestMethod.GET)
	@ResponseBody
	public List<PartyVO> searchList(String searchKey, String searchWord, int page) {
		log.info("/party/json/selectAll.do...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);
		
		
		List<PartyVO> vos = service.searchList(searchKey, searchWord, page);
		log.info("vos: {}", vos);
		
		return vos;
	}
	
//	@RequestMapping(value = "/party/json/selectOne.do", method = RequestMethod.GET)
//	@ResponseBody
//	public String selectOne(PartyVO vo, Model model) {
//		log.info("/par_selectOne.do...");
//		
//		service.vCountUp(vo);
//		
//		PartyVO vo2 = service.selectOne(vo);
//		log.info("vo2: {}", vo2);
//		
//		model.addAttribute("vo2", vo2);
//		
//		return "party/selectOne";
//	}	
}
