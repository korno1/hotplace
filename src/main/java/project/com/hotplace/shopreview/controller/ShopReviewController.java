package project.com.hotplace.shopreview.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;
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
	ShopService shoService;
	
	@Autowired
	MemberService memService;
	
	@RequestMapping(value = "/shop/review/insert.do", method = RequestMethod.GET)
	public String insertReview(Model model, String nickName, int shopNum) {
		log.info("/ShopReviewInsert.do");
		
		ShopVO vo = new ShopVO();
		vo.setNum(shopNum);
		
		vo = shoService.selectOne(vo);
		log.info("{}", vo);
		
		model.addAttribute("nickName", nickName);
		model.addAttribute("shopNum", shopNum);
		model.addAttribute("shopVO", vo);
		
		return "shop/review/insert";
	}
	
	@RequestMapping(value = "/shop/review/update.do", method = RequestMethod.GET)
	public String update(Model model, int num, int shopNum) {
		log.info("/update.do...");

		ShopVO shoVO = new ShopVO();
		shoVO.setNum(shopNum);
		
		shoVO = shoService.selectOne(shoVO);
		
		ShopReviewVO sreVO = new ShopReviewVO();
		sreVO.setNum(num);
		
		sreVO = service.selectOne(sreVO);
		
		log.info("shopVO:{}", shoVO);
		log.info("shopReviewVO:{}", sreVO);

		model.addAttribute("shoVO", shoVO);
		model.addAttribute("sreVO", sreVO);

		return "shop/review/update";
	}
	
}
