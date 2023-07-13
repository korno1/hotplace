package project.com.hotplace.memberreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.memberreview.model.MemberReviewDAO;
import project.com.hotplace.memberreview.model.MemberReviewVO;

@Service
@Slf4j
public class MemberReviewService {

	@Autowired
	MemberReviewDAO dao;
	
	public MemberReviewService() {
		log.info("MemberReviewService()...");
	}

	public List<MemberReviewVO> selectAll(MemberReviewVO vo, Integer page) {
		return dao.selectAll(vo, page);
	}

	public int insert(MemberReviewVO vo) {
		return dao.insert(vo);
	}

	public int update(MemberReviewVO vo) {
		return dao.update(vo);
	}

	public int delete(MemberReviewVO vo) {
		return dao.delete(vo);
	}
	
	public int totalCount(MemberReviewVO vo) {
		return dao.totalCount(vo);
	}
	
	
}
