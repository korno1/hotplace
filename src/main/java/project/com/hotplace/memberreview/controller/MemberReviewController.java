package project.com.hotplace.memberreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;


@Slf4j
@Controller
public class MemberReviewController {
	
	@Autowired
	private MemberService mem_service;

	@RequestMapping(value = {"/userpage.do"}, method = RequestMethod.GET)
	public String userpage(MemberVO vo, Model model) {
		log.info("/userpage.do");
		
		MemberVO vo2 = mem_service.selectOne(vo);
		log.info("vo2 outinfo...{}",vo2);
		
		model.addAttribute("vo2",vo2);
		
		return "memberreview/userpage.tiles";
	}
	
}
