package project.com.hotplace.mail.controller;

import java.io.IOException;
import java.util.List;

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

	@RequestMapping(value = "/Mail/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public List<MailVO> selectAll(int user_num, int page) {
		int pageNumber = 1;

		log.info("Mail/json/selectAll.do");
		if (page > 0) {
			pageNumber = page;
		}

		// selectAll, searchList
		List<MailVO> vos = service.selectAll(user_num, pageNumber);
		log.info("vos.size():{}", vos.size());

		return vos;
	}

	@RequestMapping(value = "/Mail/json/insertOK.do", method = RequestMethod.POST)
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

	@RequestMapping(value = "/Mail/json/updateOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateOK(MailVO vo) throws IllegalStateException, IOException {
		log.info("updateOK...{}", vo);

			int result = service.updateOK(vo);
			log.info("result:{}", result);
			if (result == 1) {
				return "{\"result\":\"OK\"}";
			} else {
				return "{\"result\":\"NotOK\"}";
			}
			
	}
	
	
	@RequestMapping(value = "/Mail/json/deleteOK.do", method = RequestMethod.POST)
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
