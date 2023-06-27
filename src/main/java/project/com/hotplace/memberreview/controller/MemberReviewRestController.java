package project.com.hotplace.memberreview.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	@RequestMapping(value = {"/json_mre_selectAll.do"}, method = RequestMethod.GET)
	public List<MemberReviewVO> selectAll(MemberReviewVO vo) {
		log.info("json_mre_selectAll.do...{}", vo);
		
		List<MemberReviewVO> vos = service.selectAll(vo);
		log.info("vos.size():{}", vos.size());
		
		return vos;
	}
	
}
