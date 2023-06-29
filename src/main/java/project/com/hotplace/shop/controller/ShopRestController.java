package project.com.hotplace.shop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;

@Slf4j
@Controller
@RequestMapping("/shop")
public class ShopRestController {

	@Autowired
	ShopService service;
	
	@ResponseBody
	@RequestMapping(value = "/json_selectAll.do", method = RequestMethod.GET)
	public String json_selectAll() {
		log.info("/json_selectAll.do");
		
		List<ShopVO> vos = service.selectAll();
		
		log.info("/json_result...{}", vos);
		
		return null;
	}
}
