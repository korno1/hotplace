package project.com.hotplace.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class MemberController {
	
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
}
