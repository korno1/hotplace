package project.com.hotplace.mail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.mail.model.MailVO;
import project.com.hotplace.mail.service.MailService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class MailController {
	
	@Autowired
	MailService service;
	
	@RequestMapping(value = {"mail/selectAll.do"}, method = RequestMethod.GET)
	public String selectAll() {
		log.info("mail/selectAll.do...");
		
		return "/mail/selectAll";
	}
	
	@RequestMapping(value = {"mail/insert.do"}, method = RequestMethod.GET)
	public String insert() {
		log.info("mail/insert.do...");
		
		return "/mail/insert";
	}
	
	@RequestMapping(value = {"mail/selectOne.do"}, method = RequestMethod.GET)
	public String selectOne(MailVO vo, Model model) {
		log.info("mail/selectOne.do...");
		
		MailVO vo2 = service.selectOne(vo);
		log.info("vo2 outinfo...{}",vo2);
		
		model.addAttribute("vo2",vo2);
		
		return "mail/selectOne";
	}
}
