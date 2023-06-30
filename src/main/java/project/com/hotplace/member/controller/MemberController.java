package project.com.hotplace.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@RequestMapping(value = "/jonggwan", method = RequestMethod.GET)
	public String jonggwan() {
		log.info("jonggwan.do...");
		
		return "jonggwan";
	}
	
	@RequestMapping(value = {"member/selectAll.do"}, method = RequestMethod.GET)
	public String selectAll() {
		log.info("member/selectAll.do...");
		
		return "/member/selectAll";
	}
	
	@RequestMapping(value = {"member/insert.do"}, method = RequestMethod.GET)
	public String insert() {
		log.info("member/insert.do...");
		
		return "/member/insert";
	}
	
	@RequestMapping(value = {"member/selectOne.do"}, method = RequestMethod.GET)
	public String selectOne(MemberVO vo, Model model) {
		log.info("member/selectOne.do...");
		
		MemberVO vo2 = service.selectOne(vo);
		log.info("vo2 outinfo...{}",vo2);
		
		model.addAttribute("vo2",vo2);
		
		return "member/selectOne";
	}
}
