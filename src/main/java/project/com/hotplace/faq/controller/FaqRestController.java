package project.com.hotplace.faq.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.faq.model.FaqVO;
import project.com.hotplace.faq.service.FaqService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class FaqRestController {
	
	@Autowired
	FaqService service;
	
	/** 
	 * Simply selects the home view to render by returning its name.
	 */

	
	@RequestMapping(value = "/faq/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public int selectAll(String searchKey, String searchWord) {
		log.info("/faq/json/selectAll.do...");
		
		if(searchKey.equals("")) {
			searchKey = "title";
		}
		
		
		int cnt = service.selectAll(searchKey, searchWord).size();
		log.info("cnt: {}", cnt);
		
		return cnt;
	}
	
	@RequestMapping(value = "/faq/json/searchList.do", method = RequestMethod.GET)
	@ResponseBody
	public List<FaqVO> searchList(String searchKey, String searchWord, int page) {
		log.info("/faq/json/selectAll.do...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);
		
		if(searchKey.equals("")) {
			searchKey = "title";
		}
		
		
		List<FaqVO> vos = service.searchList(searchKey, searchWord, page);
		log.info("vos: {}", vos);
		
		return vos;
	}
	
	@RequestMapping(value = "/faq/json/selectOne.do", method = RequestMethod.GET)
	@ResponseBody
	public FaqVO selectOne(FaqVO vo) {
		log.info("/faq/json/selectOne.do...");
		
		FaqVO vo2 = service.selectOne(vo);
		log.info("vo2: {}", vo2);
		
		return vo2;
	}
	
	@RequestMapping(value = "/faq/json/insertOK.do", method = RequestMethod.GET)
	@ResponseBody
	public String insertOK(FaqVO vo) {
		log.info("/faq/json/insertOK.do...{}", vo);

		vo.setContent(vo.getContent().replaceAll("\r\n", "<BR>"));
		int result = service.insert(vo);
		log.info("result: {}", result);
		
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}"; // {"result" : 1}
		}
		else msg = "{\"result\" : 0}";
		
		return msg;
	
	}
	
	@RequestMapping(value = "/faq/json/updateOK.do", method = RequestMethod.GET)
	@ResponseBody
	public String updateOK(FaqVO vo) {
		log.info("/faq/json/updateOK.do...{}", vo);

		vo.setContent(vo.getContent().replaceAll("\r\n", "<BR>"));
		int result = service.update(vo);
		log.info("result: {}", result);
		
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}"; // {"result" : 1}
		}
		else msg = "{\"result\" : 0}";
		
		return msg;
	
	}
	
	@RequestMapping(value = "/faq/json/deleteOK.do", method = RequestMethod.GET)
	@ResponseBody
	public String deleteOK(FaqVO vo) {
		log.info("/faq/json/deleteOK.do...{}", vo);

		int result = service.delete(vo);
		log.info("result: {}", result);
		
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}"; // {"result" : 1}
		}
		else msg = "{\"result\" : 0}";
		
		return msg;
	
	}
	
	
}
