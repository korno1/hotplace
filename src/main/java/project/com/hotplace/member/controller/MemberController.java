package project.com.hotplace.member.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String home(Locale locale, Model model) {
		log.info("member/selectAll.do...");
		
		return "/member/selectAll";
	}
	
}
