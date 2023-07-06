package project.com.hotplace.shopreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.shopreview.service.ShopReviewService;

@Slf4j
@Controller
public class ShopReviewRestController {
	    
		@Autowired
	    ShopReviewService service;
	    
	    @RequestMapping(value = "/shop/review/json/delete.do", method = RequestMethod.POST)
	    @ResponseBody
	    public String deleteReview(int num) {
	        log.info("/ShopReviewDelete.do");
	        
	        // 삭제 로직 수행
	        int result = service.delete(num);
	        if (result > 0) {
	            return "success";
	        } else {
	            return "failure";
	        }
	    }
	    
	    // 이후 코드 생략
}
