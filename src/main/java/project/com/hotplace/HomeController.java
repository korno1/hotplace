package project.com.hotplace;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	MemberService memService;
	
	@Autowired
	ShopService shopService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/** 
	 * Simply selects the home view to render by returning its name
	 * 
	 */
	@RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {    
	    HttpSession session = request.getSession();
	    Object nickName = session.getAttribute("nick_name");
	    
	    logger.info("nickName....{}", nickName);
	    
	    if(nickName != null) {
	    	MemberVO memVO = new MemberVO();
		    
		    memVO.setNick_name(nickName.toString());
		    
		    memVO = memService.idAuth(memVO);
		    
		    if(memVO.getGrade() == 1 || memVO.getGrade() == 2)
		    	model.addAttribute("Authority", "true");
		    else
		    	model.addAttribute("Authority", "false");
		    
		    logger.info("{}", memVO);
	    }
	    else
	    	model.addAttribute("Authority", "false");

	    
	    // 데이터 조회
	    List<ShopVO> shopList = shopService.selectAllHome();

	    // 모델에 데이터 추가
	    model.addAttribute("vos", shopList);
	    
	    return "home.tiles"; // 수정된 반환값
	}
	
}