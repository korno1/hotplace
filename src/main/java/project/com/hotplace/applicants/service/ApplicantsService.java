package project.com.hotplace.applicants.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.com.hotplace.applicants.model.ApplicantsDAO;
import project.com.hotplace.applicants.model.ApplicantsVO;

@Service
public class ApplicantsService {
	@Autowired
	ApplicantsDAO dao;
	
	public List<ApplicantsVO> selectAll(ApplicantsVO vo){
		return dao.selectAll(vo);
	}
	
	public int insert(ApplicantsVO vo) {
		return dao.insert(vo);
	}
	public int approve(ApplicantsVO vo) {
		return dao.approve(vo);
	}
	public int reject(ApplicantsVO vo) {
		return dao.reject(vo);
	}
}
