package project.com.hotplace.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class MemberRestController {
	
	@Autowired
	private MemberService service;
	
	@RequestMapping(value = "/member/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public List<MemberVO> selectAll(String searchKey, String searchWord, int page) {
	    int pageNumber = 1;
	    
	    log.info("member/json/selectAll.do");
	    if (page > 0) {
	        pageNumber = page;
	    }
	    
	    // selectAll, searchList
	    List<MemberVO> vos = service.selectAll(searchKey, searchWord, pageNumber);
	    log.info("vos.size():{}", vos.size());
	    
	    return vos;
	}
	@RequestMapping(value = "/member/json/nickNameCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String nickNameCheck(MemberVO vo) {
		log.info("nickNameCheck:{}",vo);
		
		MemberVO vo2 = service.nickNameCheck(vo);
		log.info("{}",vo2);
		if(vo2==null) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}
	
	@RequestMapping(value = "/member/json/emailCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String emailCheck(MemberVO vo) {
		log.info("nickNameCheck:{}",vo);
		
		MemberVO vo2 = service.emailCheck(vo);
		log.info("{}",vo2);
		if(vo2==null) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}
	@RequestMapping(value = "/member/json/insertOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String insertOK(MemberVO vo) {
		log.info("insert...{}",vo);
		
		int result = service.insertOK(vo);
		log.info("result:{}",result);
		if(result==1) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}

	
}
