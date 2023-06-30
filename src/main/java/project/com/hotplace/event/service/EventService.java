package project.com.hotplace.event.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.com.hotplace.event.model.EventDAO;
import project.com.hotplace.event.model.EventVO;

@Service
public class EventService {

	@Autowired
	EventDAO dao;
	
	public List<EventVO> selectAll(String searchKey, String searchWord){
		return dao.selectAll(searchKey, searchWord);
	}
	
	public EventVO selectOne(EventVO vo) {
		return dao.selectOne(vo);
	}
	
	public List<EventVO> searchList(String searchKey, String searchWord, int page){
		return dao.searchList(searchKey, searchWord, page);
	}
	
	public int insert(EventVO vo) {
		return dao.insert(vo);
	}
	
	public int update(EventVO vo) {
		return dao.update(vo);
	}
	
	public int delete(EventVO vo) {
		return dao.delete(vo);
	}
	
	public void vCountUp(EventVO vo) {
		dao.vCountUp(vo);
	}
}
