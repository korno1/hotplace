package project.com.hotplace.faq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.com.hotplace.faq.model.FaqDAO;
import project.com.hotplace.faq.model.FaqVO;

@Service
public class FaqService {
	
	@Autowired
	FaqDAO dao;
	
	public List<FaqVO> selectAll(String searchKey, String searchWord){
		return dao.selectAll(searchKey, searchWord);
	}
	
	public FaqVO selectOne(FaqVO vo) {
		return dao.selectOne(vo);
	}
	
	public List<FaqVO> searchList(String searchKey, String searchWord, int page){
		return dao.searchList(searchKey, searchWord, page);
	}
	
	public int insert(FaqVO vo) {
		return dao.insert(vo);
	}
	
	public int update(FaqVO vo) {
		return dao.update(vo);
	}
	
	public int delete(FaqVO vo) {
		return dao.delete(vo);
	}
}
