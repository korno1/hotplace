package project.com.hotplace.mail.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.mail.model.MailVO;
import project.com.hotplace.mail.service.MailService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class MailRestController {

	@Autowired
	ServletContext sContext;

	@Autowired
	private MailService service;

	@RequestMapping(value = "/mail/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> selectAll(int sender_num, int recipient_num, int page) {
	    int pageNumber = 1;
	    int nextPageNumber = page + 1;
	    
	    log.info("mail/json/selectAll.do");
	    if (page > 0) {
	        pageNumber = page;
	    }
	    List<MailVO> vos = service.selectAll(sender_num, recipient_num, pageNumber);
	    List<MailVO> vos2 = service.selectAll(sender_num, recipient_num, nextPageNumber);
	    log.info("nextPageis...{}", vos2.toString());
	    
	    boolean isLast = vos2.isEmpty();
	    
	    log.info("vos.size():{}", vos.size());
	    
	    Map<String, Object> response = new HashMap<String, Object>();
	    response.put("vos", vos);
	    response.put("isLast", isLast);
	    
	    return response;
	}
	@RequestMapping(value = "/mail/json/newMailCnt.do", method = RequestMethod.GET)
	@ResponseBody
	public int newMailCnt(MailVO vo) {
		
		int result = service.newMailCnt(vo);
		log.info("newMailCnt...{}", result);
		
		return result;
	}
	@RequestMapping(value = "/mail/json/selectAll_admin.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> selectAll_admin(String searchKey, String searchWord, int page) {
		int pageNumber = 1;
		int nextPageNumber = page + 1;
		
		log.info("json/selectAll_admin.do");
		if (page > 0) {
			pageNumber = page;
		}
		List<MailVO> vos = service.selectAllAdmin(searchKey,searchWord,pageNumber);
		List<MailVO> vos2 = service.selectAllAdmin(searchKey,searchWord,nextPageNumber);
		log.info("nextPageis...{}", vos2.toString());
		
		boolean isLast = vos2.isEmpty();
		
		log.info("vos.size():{}", vos.size());
		
		Map<String, Object> response = new HashMap<String, Object>();
		response.put("vos", vos);
		response.put("isLast", isLast);
		
		return response;
	}


	@RequestMapping(value = "/mail/json/insertOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String insertOK(MailVO vo) {
		log.info("insert...{}", vo);

		int result = service.insertOK(vo);
		log.info("result:{}", result);
		if (result == 1) {
			return "{\"result\":\"OK\"}";
		} else {
			return "{\"result\":\"NotOK\"}";
		}
	}

	@RequestMapping(value = "/mail/json/readOK.do", method = RequestMethod.GET)
	@ResponseBody
	public String readOK(MailVO vo) {
	    // 핸들러 메서드의 내용은 이전과 동일합니다
	    log.info("readOK...{}", vo);
	    int result = service.readOK(vo);
	    log.info("result:{}", result);
	    if (result == 1) {
	        return "{\"result\":\"OK\"}";
	    } else {
	        return "{\"result\":\"NotOK\"}";
	    }
	}

	
	@RequestMapping(value = "/mail/json/deleteOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String deleteOK(MailVO vo) {
		log.info("insert...{}", vo);

		int result = service.deleteOK(vo);
		log.info("result:{}", result);
		if (result == 1) {
			return "{\"result\":\"OK\"}";
		} else {
			return "{\"result\":\"NotOK\"}";
		}
	}

}
