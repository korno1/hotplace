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
		log.info("/par_selectAll.do...");
		
		List<PartyVO> vos = service.searchList(searchKey, searchWord, page);
		log.info("vos: {}", vos);
		
		int cnt = service.selectAll(searchKey, searchWord).size();
		log.info("cnt: {}", cnt);
	
		
		model.addAttribute("vos", vos);
		model.addAttribute("cnt", cnt);
		
		return "party/selectAll.tiles";
	}
	
	@RequestMapping(value = "/party/selectOne.do", method = RequestMethod.GET)
	public String selectOne(PartyVO vo, Model model) {
		log.info("/par_selectOne.do...");
		
		service.vCountUp(vo);
		
		PartyVO vo2 = service.selectOne(vo);
		log.info("vo2: {}", vo2);
		
		model.addAttribute("vo2", vo2);
		
		return "party/selectOne.tiles";
	}
	
	@RequestMapping(value = "/party/insert.do", method = RequestMethod.GET)
	public String insert() {
		log.info("/par_insert.do...");
		
		return "party/insert.tiles";
	}
	
	@RequestMapping(value = "/party/insertOK.do", method = RequestMethod.POST)
	public String insertOK(PartyVO vo) {
		log.info("/par_insertOK.do...{}", vo);
		
		vo.setTimeLimit(vo.getTimeLimit().replace("T", " "));
		vo.setDeadLine(vo.getDeadLine().replace("T", " "));
		vo.setWriterNum(3);
		
		int result = service.insert(vo);
		log.info("result: {}", result);
		
		if(result==1) {
			return "redirect:selectAll.do?searchKey=title&searchWord=&page=1";
		}else {
			return "redirect:insert.do";
		}		
	}
	
	@RequestMapping(value = "/party/update.do", method = RequestMethod.GET)
	public String update(PartyVO vo, Model model) {
		log.info("/par_update.do...");
		
		PartyVO vo2 = service.selectOne(vo);
		log.info("vo2: {}", vo2);
		
		model.addAttribute("vo2", vo2);
				
		return "party/update.tiles";
	}
	
	@RequestMapping(value = "/party/updateOK.do", method = RequestMethod.POST)
	public String updateOK(PartyVO vo) {
		log.info("/par_updateOK.do...{}", vo);
		
		vo.setTimeLimit(vo.getTimeLimit().replace("T", " "));
		vo.setDeadLine(vo.getDeadLine().replace("T", " "));
		
		int result = service.update(vo);
		log.info("result: {}", result);
		
		if(result==1) {
			return "redirect:selectAll.do?searchKey=title&searchWord=&page=1";
		}else {
			return "redirect:selectOne.do?partyNum=" + vo.getPartyNum();
		}	
	}
	
	@RequestMapping(value = "/party/deleteOK.do", method = RequestMethod.GET)
	public String deleteOK(PartyVO vo) {
		log.info("/par_deleteOK.do...{}", vo);
		
		int result = service.delete(vo);
		log.info("result: {}", result);
		
		return "redirect:selectAll.do?searchKey=title&searchWord=&page=1";
	}
	
}
