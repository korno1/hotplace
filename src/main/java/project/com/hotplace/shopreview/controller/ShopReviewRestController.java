package project.com.hotplace.shopreview.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;
import project.com.hotplace.shopreview.model.ShopReviewVO;
import project.com.hotplace.shopreview.service.ShopReviewService;

@Slf4j
@Controller
public class ShopReviewRestController {
	    
		@Autowired
		ServletContext sContext;
	
		@Autowired
	    ShopReviewService service;
		
		@Autowired
		MemberService memService;
	    
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
	    
	    @RequestMapping(value = "shop/review/json/insertOK.do", method = RequestMethod.POST)
	    @ResponseBody
	    public String insertReview(ShopReviewVO vo) throws IllegalStateException, IOException {
	    	log.info("/ShopReviewInsertOK.do");
			MemberVO memVO = new MemberVO();
			
			
			memVO.setNick_name(vo.getWriterName());
			
			memVO = memService.idAuth(memVO);
			
			log.info("memVO:{}",memVO);
			
			vo.setWriter(memVO.getNum());
			
			MultipartFile file = vo.getMultipartFile();
		    
			if(file == null) {
				vo.setSaveName("default.png");
			} else {
				String getOriginalFilename = vo.getMultipartFile().getOriginalFilename();
				vo.setSaveName(getOriginalFilename);
				String realPath = sContext.getRealPath("resources/ShopReviewImage");
				log.info("realPath : {}",realPath);
				
				File f = new File(realPath+"\\"+vo.getSaveName());
				
				vo.getMultipartFile().transferTo(f);
			}
			
			log.info("vo:{}", vo);
		       
		    int result = service.insert(vo);
		    log.info("result:{}",result);
		    if (result > 0) {
	            // 삽입 성공
	            return "success";
	        } else {
	            // 삽입 실패
	            return "error";
	        }
	    }
}
