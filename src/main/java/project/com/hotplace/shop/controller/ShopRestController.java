package project.com.hotplace.shop.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;
import project.com.hotplace.shopreview.service.ShopReviewService;

@Slf4j
@Controller
public class ShopRestController {
	
	@Autowired
	ShopService service;
	
	@Autowired
	ShopReviewService sreService;
	
	@Autowired
	ServletContext sContext;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping(value = "shop/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> selectAll(Model model, String searchKey, String searchWord, int pageNum) {
		log.info("/selectAll.do");
		log.info("searchKey:{}",searchKey);
		log.info("searchWord:{}",searchWord);
		
		List<ShopVO> vos = service.selectAll(searchKey,searchWord, pageNum);
		
		List<ShopVO> nextVos = service.selectAll(searchKey,searchWord,pageNum+1);
		
		boolean isLast = nextVos.isEmpty();
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("vos", vos);
		response.put("isLast", isLast);
		
		return response;
	}
	
	@RequestMapping(value = "shop/json/insertOK.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> insertOK(ShopVO vo) throws IllegalStateException, IOException {
		vo.setNum(service.countNum() + 1);
		
		log.info("/insertOK.do...{}", vo);
		
		MultipartFile file = vo.getMultipartFile();
				
		if(file != null) {
			String realPath = sContext.getRealPath("/resources/ShopSymbol");
			log.info("realPath : {}",realPath);
			
			File f = new File(realPath+"\\"+ vo.getNum() + ".png");
			
			vo.getMultipartFile().transferTo(f);
			
			BufferedImage originalBufferedImage = ImageIO.read(f);
			BufferedImage thumbnailBufferedImage = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphics = thumbnailBufferedImage.createGraphics();
			graphics.drawImage(originalBufferedImage, 0, 0, 200, 200, null);

			String thumbnailFilePath = realPath+"\\"+vo. getNum() + ".png";
			File thumbnailFile = new File(thumbnailFilePath);
			ImageIO.write(thumbnailBufferedImage, ".png", thumbnailFile);
		}
		
		log.info("VO:{}", vo);
		
		int result = service.insert(vo);
		log.info("result...{}", result);
		
	    Map<String, String> response = new HashMap<>();
	    
	    response.put("result", "success");
	    return response;
	}
}
