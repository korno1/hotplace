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
	ServletContext sContext;
	
	@Autowired
    HttpSession session;

	@RequestMapping(value = "/selectAll.do", method = RequestMethod.GET)
	public String selectAll(Model model) {
		log.info("/selectAll.do");
		
        Object grade = session.getAttribute("grade");
        if(grade != null)
        {
        	boolean showAddButton = (grade.equals(1) || grade.equals(2));
            model.addAttribute("showAddButton", showAddButton);
        }
		
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
	
	@RequestMapping(value = "/update.do", method = RequestMethod.GET)
	public String update(ShopVO vo, Model model) {
		log.info("/update.do...{}", vo);

		ShopVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);

		return "shop/update";
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

	    int num = shoVO.getNum();

	    ShopReviewVO sreVO = new ShopReviewVO();
	    sreVO.setShopNum(num);

	    List<ShopReviewVO> sreVOS = sreService.selectAll(sreVO);

	    log.info("/sreList...{}", sreVOS);

	    model.addAttribute("shoVO", shoVO);
	    model.addAttribute("sreVOS", sreVOS);

	    return "shop/selectOne.tiles";
	}
	
	@RequestMapping(value = "/test.do", method = RequestMethod.GET)
	public String test() {

		return "shop/test";
	}
	
}