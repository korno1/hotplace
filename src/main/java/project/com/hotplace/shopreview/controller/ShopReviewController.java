package project.com.hotplace.shopreview.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;
import project.com.hotplace.shopreview.model.ShopReviewVO;
import project.com.hotplace.shopreview.service.ShopReviewService;

@Slf4j
@Controller
public class ShopReviewController {
	
	@Autowired
	ServletContext sContext;
	
	@Autowired
	ShopReviewService service;
	
	@Autowired
	MemberService memService;
	
	@RequestMapping(value = "/shop/review/insert.do", method = RequestMethod.GET)
	public String insertReview(Model model, String nickName, int shopNum) {
		log.info("/ShopReviewInsert.do");
		
		model.addAttribute("nickName", nickName);
		model.addAttribute("shopNum", shopNum);
		
		return "shop/review/insert";
	}
	
	@RequestMapping(value = "/shop/review/update.do", method = RequestMethod.GET)
	public String updateReview(Model model, String nickName, int num) {
		log.info("/ShopReviewUpdate.do");
		
		ShopReviewVO vo = new ShopReviewVO();
		vo.setNum(num);
		
		vo = service.selectOne(vo);
		
		log.info("vo...{}",vo);
		
		model.addAttribute("nickName", nickName);
	    model.addAttribute("vo", vo);
		
		return "shop/review/update";
	}
	
	@RequestMapping(value = "/shop/review/insertOK.do", method = RequestMethod.POST)
	public String insertOK(Model model, ShopReviewVO vo) throws IllegalStateException, IOException {
		log.info("/ShopReviewInsertOK.do");
		log.info("VO:{}", vo);
		
		MemberVO memVO = new MemberVO();
		
		memVO.setNick_name(vo.getWriterName());
		
		memVO = memService.idAuth(memVO);
		
		log.info("memVO:{}",memVO);
		
		vo.setWriter(memVO.getNum());
	    
	    String getOriginalFilename = vo.getMultipartFile().getOriginalFilename();
	    int fileNameLength = vo.getMultipartFile().getOriginalFilename().length();
	    log.info("getOriginalFilename:{}",getOriginalFilename);
		log.info("fileNameLength:{}",fileNameLength);
			
		if(getOriginalFilename.length()==0) {
			vo.setSaveName("default.png");
		} else {
			vo.setSaveName(getOriginalFilename);
			String realPath = sContext.getRealPath("resources/ShopReviewImage");
			log.info("realPath : {}",realPath);
			
			File f = new File(realPath+"\\"+vo.getSaveName());
			
			vo.getMultipartFile().transferTo(f);
		}
		
		log.info("vo:{}", vo);
	       
	    int result = service.insert(vo);
	    log.info("result:{}",result);
	      
	    return "redirect:/shop/selectOne.do?num=" + vo.getShopNum();
	}

	@RequestMapping(value = "/shop/review/updateOK.do", method = RequestMethod.POST)
	public String updateOK(Model model, ShopReviewVO vo) {
		log.info("/ShopReviewUpdateOK.do");
		log.info("이전페이지VO:{}", vo);
		
		//빈 VO 객체 생성
		MemberVO memVO = new MemberVO();
		ShopReviewVO sreVO = new ShopReviewVO();
		
		//vo.num에 있는 데이터 사용해서 sreVO 데이터 가져옴
		sreVO = service.selectOne(vo);
		
		//
		memVO.setNick_name(vo.getWriterName());
		memVO = memService.idAuth(memVO);
		
		// 작성자 일치 여부 확인
	    if (memVO.getNum() != sreVO.getWriter()) {
	    	
	    	log.info("?");
	        // 작성자가 일치하지 않을 경우 처리
	        return "redirect:/shop/selectOne.do?num=" + vo.getShopNum();
	    }
		
		sreVO.setContent(vo.getContent());
		sreVO.setRated(vo.getRated());

		log.info("update vo:{}", sreVO);
	       
		int result = service.update(sreVO);
		log.info("result:{}",result);
	      
	    return "redirect:/shop/selectOne.do?num=" + vo.getShopNum();
	}
}
