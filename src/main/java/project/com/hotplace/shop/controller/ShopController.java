package project.com.hotplace.shop.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.service.MemberService;
import project.com.hotplace.party.model.PartyVO;
import project.com.hotplace.party.service.PartyService;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;
import project.com.hotplace.shopreview.model.ShopReviewVO;
import project.com.hotplace.shopreview.service.ShopReviewService;

@Slf4j
@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	ShopService service;
	
	@Autowired
	ShopReviewService sreService;
	
	@Autowired
	PartyService parService;
	
	@Autowired
	MemberService memService;
	
	@Autowired
	ServletContext sContext;
	
	@Autowired
    HttpSession session;

	@RequestMapping(value = "/selectAll.do", method = RequestMethod.GET)
	public String selectAll(Model model) {
		log.info("/selectAll.do");
		
		return "shop/selectAll.tiles";
	}
	
	@RequestMapping(value = "/searchList.do", method = RequestMethod.GET)
	public String searchList(String searchWord, int page) {
		log.info("/searchList.do");
		
		List<ShopVO> vos = service.searchList(searchWord);
		log.info("{}", vos);
		
		return "shop/selectAll.tiles";
	}
	
	@RequestMapping(value = "/insert.do", method = RequestMethod.GET)
	public String insert() {
		log.info("/shop/insert.do");

		return "shop/insert";
	}
	
	@RequestMapping(value = "/selectOne.do", method = RequestMethod.GET)
	public String selectOne(ShopVO vo, Model model, int page) {
	    ShopVO shoVO = service.selectOne(vo);
	    
	    log.info("{}",vo);
	    
	    int num = shoVO.getNum();

	    ShopReviewVO sreVO = new ShopReviewVO();
	    sreVO.setShopNum(num);
	    
	    List<ShopReviewVO> sreVOS = sreService.selectAll(sreVO, page);
	    
	    int totalCount = sreService.count(sreVO);
	    int pageSize = 5; // Number of items per page
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);
	    
	    List<PartyVO> parVOS = parService.selectAll("place", shoVO.getName(), 1);
	    
	    log.info("/sreList...{}", sreVOS);
	    
	    log.info("/PartyVOs...{}", parVOS);
	    
	    log.info("total_count...{}", totalCount);
	    
	    log.info("total_page...{}", totalPages);

	    model.addAttribute("shoVO", shoVO);
	    model.addAttribute("sreVOS", sreVOS);
	    model.addAttribute("page", page);
	    model.addAttribute("totalPages", totalPages);

	    return "shop/selectOne.tiles";
	}
}