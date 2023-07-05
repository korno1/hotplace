package project.com.hotplace.shopreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.shopreview.service.ShopReviewService;

@Slf4j
@Controller
public class ShopReviewController {
	
	@Autowired
	ShopReviewService Service;
	
	@RequestMapping(value = "/shop/review/insert.do", method = RequestMethod.GET)
	public String insertReview(Model model, int userNum, int shopNum) {
		log.info("/ShopReviewInsert.do");
		
		return "shop/review/insert";
	}
}
