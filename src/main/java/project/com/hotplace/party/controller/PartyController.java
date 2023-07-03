package project.com.hotplace.party.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.party.model.PartyVO;
import project.com.hotplace.party.service.PartyService;


@Slf4j
@Controller
public class PartyController {
	
	@Autowired
	private PartyService service;
	
	@RequestMapping(value = "/my.do", method = RequestMethod.GET)
	public String my() {
		log.info("/my.do...");
		
		return "my";
	}
	
	@RequestMapping(value = "/party/selectAll.do", method = RequestMethod.GET)
	public String selectAll(String searchKey, String searchWord, int page, Model model) {
		log.info("/not_selectAll.do...");
		
		List<PartyVO> vos = service.searchList(searchKey, searchWord, page);
		log.info("vos: {}", vos);
		
		int cnt = service.selectAll(searchKey, searchWord).size();
		log.info("cnt: {}", cnt);
	
		
		model.addAttribute("vos", vos);
		model.addAttribute("cnt", cnt);
		
		return "party/selectAll";
	}
	
	@RequestMapping(value = "/party/selectOne.do", method = RequestMethod.GET)
	public String selectOne(PartyVO vo, Model model) {
		log.info("/not_selectAll.do...");
		
		service.vCountUp(vo);
		
		PartyVO vo2 = service.selectOne(vo);
		log.info("vo2: {}", vo2);
		
		

	

		model.addAttribute("vo2", vo2);
		
		return "party/selectOne";
	}
	
	@RequestMapping(value = "/party/insert.do", method = RequestMethod.GET)
	public String insert() {
		log.info("/not_insert.do...");
		
				
		return "party/insert";
	}
	
	@RequestMapping(value = "/party/insertOK.do", method = RequestMethod.GET)
	public String insertOK(PartyVO vo) {
		log.info("/not_insertOK.do...{}", vo);
		
		vo.setWriter_num(1);
		int result = service.insert(vo);
		log.info("result: {}", result);
		
				
		return "redirect:selectAll.do?searchKey=title&searchWord=&page=1";
	}
	
	@RequestMapping(value = "/party/update.do", method = RequestMethod.GET)
	public String update(PartyVO vo, Model model) {
		log.info("/not_update.do...");
		
		PartyVO vo2 = service.selectOne(vo);
		log.info("vo2: {}", vo2);
		
		model.addAttribute("vo2", vo2);
				
		return "party/update";
	}
	
	@RequestMapping(value = "/party/updateOK.do", method = RequestMethod.GET)
	public String updateOK(PartyVO vo) {
		log.info("/not_updateOK.do...{}", vo);
		
		int result = service.update(vo);
		log.info("result: {}", result);
		
		return "redirect:selectOne.do?Party_num=" + vo.getParty_num();
	}
	
	@RequestMapping(value = "/party/deleteOK.do", method = RequestMethod.GET)
	public String deleteOK(PartyVO vo) {
		log.info("/not_deleteOK.do...{}", vo);
		
		int result = service.delete(vo);
		log.info("result: {}", result);
		
		return "redirect:selectAll.do?searchKey=title&searchWord=&page=1";
	}
	
}
