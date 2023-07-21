package project.com.hotplace.shopreview.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
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
import project.com.hotplace.shop.service.ShopService;
import project.com.hotplace.shopreview.model.ShopReviewVO;
import project.com.hotplace.shopreview.service.ShopReviewService;

@Slf4j
@Controller
public class ShopReviewRestController {
	    
		@Autowired
		ServletContext sContext;
	
		@Autowired
		ShopService shoService;
		
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
	    
	    @RequestMapping(value = "/shop/review/json/insertOK.do", method = RequestMethod.POST)
	    @ResponseBody
	    public String insertReview(ShopReviewVO vo) throws IllegalStateException, IOException {
	    	log.info("/ShopReviewInsertOK.do");
			MemberVO memVO = new MemberVO();
			
			vo.setNum(service.countNum() + 1);
			
			memVO.setNick_name(vo.getWriterName());
			
			memVO = memService.idAuth(memVO);
			
			log.info("memVO:{}",memVO);
			
			vo.setWriter(memVO.getNum());
		    
			MultipartFile file = vo.getMultipartFile();
		    
			if(file != null) {
				String realPath = sContext.getRealPath("/resources/ShopReviewImage");
				log.info("realPath : {}",realPath);
				
				File f = new File(realPath+"\\"+vo.getNum() + ".png");
				
				vo.getMultipartFile().transferTo(f);
				
				BufferedImage originalBufferedImage = ImageIO.read(f);
				BufferedImage thumbnailBufferedImage = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
				Graphics2D graphics = thumbnailBufferedImage.createGraphics();
				graphics.drawImage(originalBufferedImage, 0, 0, 200, 200, null);

				String thumbnailFilePath = realPath+"\\"+ vo.getNum() + ".png";
				File thumbnailFile = new File(thumbnailFilePath);
				ImageIO.write(thumbnailBufferedImage, ".png", thumbnailFile);
			}
			
			log.info("vo:{}", vo);
		       
		    int result = service.insert(vo);
		    
		    shoService.updateRate(vo.getShopNum(), vo.getRated());
		    log.info("result:{}",result);
		    if (result > 0) {
	            // 삽입 성공
	            return "success";
	        } else {
	            // 삽입 실패
	            return "error";
	        }
	    }
	    
	    @RequestMapping(value = "/shop/review/json/updateOK.do", method = RequestMethod.POST)
	    @ResponseBody
	    public String updateReview(ShopReviewVO vo) throws IllegalStateException, IOException {
	    	log.info("/ShopReviewInsertOK.do");
		    
			MultipartFile file = vo.getMultipartFile();
		    
			if(file != null) {
				String realPath = sContext.getRealPath("/resources/ShopReviewImage");
				log.info("realPath : {}",realPath);
				
				File f = new File(realPath+"\\"+vo.getNum() + ".png");
				
				vo.getMultipartFile().transferTo(f);
				
				BufferedImage originalBufferedImage = ImageIO.read(f);
				BufferedImage thumbnailBufferedImage = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
				Graphics2D graphics = thumbnailBufferedImage.createGraphics();
				graphics.drawImage(originalBufferedImage, 0, 0, 200, 200, null);

				String thumbnailFilePath = realPath+"\\"+ vo.getNum() + ".png";
				File thumbnailFile = new File(thumbnailFilePath);
				ImageIO.write(thumbnailBufferedImage, ".png", thumbnailFile);
			}
			
			log.info("vo:{}", vo);
		       
		    int result = service.update(vo);
		    shoService.updateRate(vo.getShopNum(), vo.getRated());
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
