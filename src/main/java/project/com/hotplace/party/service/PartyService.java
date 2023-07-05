package project.com.hotplace.party.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.party.model.PartyDAO;
import project.com.hotplace.party.model.PartyVO;

@Service
@Slf4j
public class PartyService {
	
	@Autowired
	PartyDAO dao;

	public PartyService() {
		log.info("PartyService()...");
	}
	
	public List<PartyVO> selectAll(String searchKey, String searchWord){
		return dao.selectAll(searchKey, searchWord);
	}
	
	public PartyVO selectOne(PartyVO vo) {
		return dao.selectOne(vo);
	}
	
	public List<PartyVO> searchList(String searchKey, String searchWord, int page){
		return dao.searchList(searchKey, searchWord, page);
	}
	
	public int insert(PartyVO vo) {
		return dao.insert(vo);
	}
	
	public int update(PartyVO vo) {
		return dao.update(vo);
	}
	
	public int delete(PartyVO vo) {
		return dao.delete(vo);
	}
	
	
	public void vCountUp(PartyVO vo) {
		dao.vCountUp(vo);
	}
}
