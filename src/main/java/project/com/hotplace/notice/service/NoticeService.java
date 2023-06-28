package project.com.hotplace.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.com.hotplace.notice.model.NoticeDAO;
import project.com.hotplace.notice.model.NoticeVO;

@Service
public class NoticeService {
	@Autowired
	NoticeDAO dao;
	
	public List<NoticeVO> selectAll(){
		return dao.selectAll();
	}
	
	public NoticeVO selectOne(NoticeVO vo) {
		return dao.selectOne(vo);
	}
	
	public List<NoticeVO> selectList(String searchKey, String searchWord){
		return dao.selectList(searchKey, searchWord);
	}
	
	public int insert(NoticeVO vo) {
		return dao.insert(vo);
	}
	
	public int update(NoticeVO vo) {
		return dao.update(vo);
	}
	
	public int delete(NoticeVO vo) {
		return dao.delete(vo);
	}
	
	
	public void vCountUp(NoticeVO vo) {
		dao.vCountUp(vo);
	}
}
