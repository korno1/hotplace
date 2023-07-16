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
	
	@RequestMapping(value = "/shop/review/insertOK.do", method = RequestMethod.POST)
	public String insertOK(Model model, ShopReviewVO vo) throws IllegalStateException, IOException {
		log.info("/ShopReviewInsertOK.do");
		log.info("VO:{}", vo);
		
		MemberVO memVO = new MemberVO();
		
		memVO.setNick_name(vo.getWriterName());
		
		memVO = memService.idAuth(memVO);
		
		log.info("memVO:{}",memVO);
		
		vo.setWriter(memVO.getNum());
		
		MultipartFile file = vo.getMultipartFile();
	    
		if(file != null) {
			String realPath = sContext.getRealPath("../resources/ShopReviewImage");
			log.info("realPath : {}",realPath);
			
			File f = new File(realPath+"\\"+vo.getWdate() + vo.getShopNum() + vo.getWriterName() + ".png");
			
			vo.getMultipartFile().transferTo(f);
			
			BufferedImage originalBufferedImage = ImageIO.read(f);
			BufferedImage thumbnailBufferedImage = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphics = thumbnailBufferedImage.createGraphics();
			graphics.drawImage(originalBufferedImage, 0, 0, 200, 200, null);

			String thumbnailFilePath = realPath+"\\"+ vo.getWdate() + vo.getShopNum() + vo.getWriterName() + ".png";
			File thumbnailFile = new File(thumbnailFilePath);
			ImageIO.write(thumbnailBufferedImage, ".png", thumbnailFile);
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
