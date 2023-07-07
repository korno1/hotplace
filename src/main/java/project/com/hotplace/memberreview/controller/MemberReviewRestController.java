package project.com.hotplace.memberreview.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.memberreview.model.MemberReviewVO;
import project.com.hotplace.memberreview.service.MemberReviewService;

@Controller
@Slf4j
public class MemberReviewRestController {
	
	@Autowired
	private MemberReviewService service;
	
	@ResponseBody
	@RequestMapping(value = {"/memberreview/json/selectAll.do"}, method = RequestMethod.GET)
	public List<MemberReviewVO> selectAll(MemberReviewVO vo) {
		log.info("selectAll.do...{}", vo);
		
		List<MemberReviewVO> vos = service.selectAll(vo);
		log.info("vos..{}", vos.toString());
		log.info("vos.size():{}", vos.size());
		
		return vos;
	}

	@ResponseBody
	@RequestMapping(value = {"/memberreview/json/insertOK.do"}, method = RequestMethod.POST)
	public Map<String, String> insertOK(MemberReviewVO vo) {
		log.info("insertOK.do...{}", vo);
		
		int result = service.insert(vo);
		log.info("result...{}", result);
		
		String msg = result == 1 ? "1":"0";
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", msg);
		
		return map;
	}

	@ResponseBody
	@RequestMapping(value = {"/memberreview/json/updateOK.do"}, method = RequestMethod.POST)
	public Map<String, String> updateOK(MemberReviewVO vo) {
		log.info("insertOK.do...{}", vo);
		
		int result = service.update(vo);
		log.info("result...{}", result);
		
		String msg = result == 1 ? "1":"0";
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", msg);
		
		return map;
	}

	@ResponseBody
	@RequestMapping(value = {"/memberreview/json/deleteOK.do"}, method = RequestMethod.GET)
	public Map<String, String> deleteOK(MemberReviewVO vo) {
		log.info("insertOK.do...{}", vo);
		
		int result = service.delete(vo);
		log.info("result...{}", result);
		
		String msg = result == 1 ? "1":"0";
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", msg);
		
		return map;
	}

	
}
