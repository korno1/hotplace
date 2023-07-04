package project.com.hotplace;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;

/**
 * Handles requests for the application home page.
 */

@Controller
@Slf4j
public class HomeController {
	
	@Autowired
	private ShopService shopService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/** 
	 * Simply selects the home view to render by returning its name.
	 * 
	 */
	@RequestMapping(value = {"/","/*.do"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		// 데이터 조회
	    List<ShopVO> shopList = shopService.selectAllHome();

	    // 모델에 데이터 추가
	    model.addAttribute("vos", shopList);
		
		return "home";
	}
	
}
