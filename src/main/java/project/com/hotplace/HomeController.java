package project.com.hotplace;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	ShopService shopService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/** 
	 * Simply selects the home view to render by returning its name
	 * 
	 */
	@RequestMapping(value = {"/home","/"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
<<<<<<< HEAD
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
=======
>>>>>>> branch 'main' of https://github.com/Multi-hotplace/hotplace.git
	    logger.info("Welcome home! The client locale is {}.", locale);
	    
	    // 데이터 조회
//	    List<ShopVO> shopList = shopService.selectAllHome();

	    // 모델에 데이터 추가
	    model.addAttribute("vos", shopList);
//	    
	    return "home.tiles"; // 수정된 반환값
	}
	
}
