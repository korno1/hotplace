package project.com.hotplace.party.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PartyDAOimpl implements PartyDAO {
	
	@Autowired
	SqlSession sqlSession;

	public PartyDAOimpl() {
		log.info("PartyDAOimpl()...");
	}
	
	
	@Override
	public List<PartyVO> selectAll(String searchKey, String searchWord) {
		log.info("selectAll()...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		
		Map<String, String> map = new HashMap<String, String>();
		
		String key = "par_selectAll";
		
		map.put("searchKey", searchKey);
		map.put("searchWord", "%" + searchWord + "%");
	
		return sqlSession.selectList(key, map);
	}

	@Override
	public PartyVO selectOne(PartyVO vo) {
		log.info("selectOne()...{}", vo);
		
		return sqlSession.selectOne("par_selectOne", vo);
	}

	@Override
	public List<PartyVO> searchList(String searchKey, String searchWord, int page) {
		log.info("searchList()...");
		
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);
		Map<String, Object> map = new HashMap<String, Object>();
		
		String key = "par_searchList";
		
		map.put("searchKey", searchKey);
		map.put("searchWord", "%" + searchWord + "%");
	
		map.put("st", (page-1)*6+1);
		map.put("en", page*6);
		
		return sqlSession.selectList(key, map);
	}

	@Override
	public int insert(PartyVO vo) {
		log.info("insert()...{}", vo);
		
		return sqlSession.insert("par_insert", vo);
	}

	@Override
	public int update(PartyVO vo) {
		log.info("update()...{}", vo);
		return sqlSession.update("par_update", vo);
	}

	@Override
	public int delete(PartyVO vo) {
		log.info("delete()...{}", vo);
		return sqlSession.delete("par_delete", vo);
	}

	@Override
	public void vCountUp(PartyVO vo) {
		log.info("vCountUp()...{}", vo);
		sqlSession.update("par_views", vo);
	}


	@Override
	public int approveOK(PartyVO vo) {
		return sqlSession.update("par_approveOK", vo);		
	}

}
 