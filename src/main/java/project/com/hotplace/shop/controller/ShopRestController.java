package project.com.hotplace.shop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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

	
	@RequestMapping(value = "shop/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> selectAll(Model model, String searchKey, int pageNum, String searchWord) {
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
}
