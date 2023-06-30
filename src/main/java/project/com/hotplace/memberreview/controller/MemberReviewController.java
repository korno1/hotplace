package project.com.hotplace.memberreview.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class MemberReviewController {
	

	@RequestMapping(value = {"/userpage.do"}, method = RequestMethod.GET)
	public String userpage() {
		log.info("/userpage.do");
		
		
		return "memberreview/userpage";
	}
	
	
}
