package project.com.hotplace.mail.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

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
	@RequestMapping(value = "/mail/json/selectAll_admin.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> selectAll_admin(int page) {
		int pageNumber = 1;
		int nextPageNumber = page + 1;
		
		log.info("json/selectAll_admin.do");
		if (page > 0) {
			pageNumber = page;
		}
		List<MailVO> vos = service.selectAllAdmin(pageNumber);
		List<MailVO> vos2 = service.selectAllAdmin(nextPageNumber);
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

	@RequestMapping(value = "/mail/json/readOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String readOK(MailVO vo) throws IllegalStateException, IOException {
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
