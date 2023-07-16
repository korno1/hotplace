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

	@RequestMapping(value = "/searchLocation.do", method = RequestMethod.GET)
	public String searchLocation() {
		log.info("/shop/searchLocation.do");

		return "shop/searchLocation";
	}
	
	@RequestMapping(value = "/insert.do", method = RequestMethod.GET)
	public String insert() {
		log.info("/shop/insert.do");

		return "shop/insert";
	}
	
	@RequestMapping(value = "/insertOK.do", method = RequestMethod.POST)
	public String insertOK(ShopVO vo) {
		log.info("/insertOK.do...{}", vo);
		
		int result = service.insert(vo);
		log.info("result...{}", result);
		
		return "redirect:insert.do";
		
	}
	
	@RequestMapping(value = "/updateOK.do", method = RequestMethod.POST)
	public String updateOK(ShopVO vo) {
		log.info("/updateOK.do...{}", vo);
		
		int result = service.update(vo);
		log.info("result...{}", result);
		
		if(result==1) {
			return "redirect:selectOne.do?num="+vo.getNum();
		}else {
			return "redirect:update.do?num="+vo.getNum();
		}
		
	}
	
	@RequestMapping(value = "/deleteOK.do", method = RequestMethod.GET)
	public String deleteOK(ShopVO vo) {
		log.info("/deleteOK.do...{}", vo);
		
		int result = service.delete(vo);
		log.info("result...{}", result);
		
		if(result==1) {
			return "redirect:selectAll.do";
		}else {
			return "redirect:selectOne.do?num="+vo.getNum();
		}
		
	}
	
	@RequestMapping(value = "/selectOne.do", method = RequestMethod.GET)
	public String selectOne(ShopVO vo, Model model) {
	    ShopVO shoVO = service.selectOne(vo);
	    
	    log.info("{}",vo);
	    
	    int num = shoVO.getNum();

	    ShopReviewVO sreVO = new ShopReviewVO();
	    sreVO.setShopNum(num);

	    List<ShopReviewVO> sreVOS = sreService.selectAll(sreVO);
	    
	    double avgRate;
	    
	    if (sreVOS == null || sreVOS.isEmpty()) {
            avgRate = 0;
        }
	    else
	    {
	    	double totalRate = 0.0;
	    	for (ShopReviewVO review : sreVOS) {
	    		totalRate += review.getRated();
	    	}

	    	avgRate = totalRate / sreVOS.size();
	    }

	    // 소수점 한자리만 남도록
	    avgRate = Math.round(avgRate * 10) / 10;
	    
	    List<PartyVO> parVO = parService.selectAll("place", shoVO.getName(), 0);
	    
	    log.info("/sreList...{}", sreVOS);
	    
	    log.info("/partyList...{}", parVO);

	    model.addAttribute("shoVO", shoVO);
	    model.addAttribute("sreVOS", sreVOS);
	    model.addAttribute("avgRate", avgRate);

	    return "shop/selectOne.tiles";
	}
	
	@RequestMapping(value = "/test.do", method = RequestMethod.GET)
	public String test() {

		return "shop/test";
	}
	
}