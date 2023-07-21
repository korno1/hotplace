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
	public List<PartyVO> selectAll(String searchKey, String searchWord, int status) {
		log.info("selectAll()...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		
		Map<String, String> map = new HashMap<String, String>();
		String key = "";
		if(status==0) {
			key = "par_selectAll";
		}
		else if(status==1) {
			key = "par_selectAll_recruiting";
		}
		else {
			key = "par_selectAll_completion";
		}
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
	public List<PartyVO> searchList(String searchKey, String searchWord, int page, int status) {
		log.info("searchList()...");
		
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);
		Map<String, Object> map = new HashMap<String, Object>();
		
		String key = "";
		if(status==0) {
			key = "par_searchList";
		}
		else if(status==1) {
			key = "par_searchList_recruiting";
		}
		else {
			key = "par_searchList_completion";
		}
		
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
		log.info("approveOK()...{}", vo);
		
		return sqlSession.update("par_approveOK", vo);		
	}

	@Override
	public List<PartyVO> myParty(PartyVO vo, int page) {
		
		log.info("myParty()...{}", vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		String key = "par_myParty";
		
		map.put("writerNum", vo.getWriterNum());
		map.put("st", (page-1)*6+1);
		map.put("en", page*6);
	
		return sqlSession.selectList(key, map);
	}


	@Override
	public int totalCount(PartyVO vo) {
		log.info("totalCount()...{}", vo);
		
		return sqlSession.selectOne("totalCount", vo);
	}

	@Override
	public List<PartyVO> myAppcants(PartyVO vo, int page) {
		log.info("myAppcants()...{}", vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		String key = "par_myAppilcants";
		
		map.put("userNum", vo.getUserNum());
		map.put("status", vo.getStatus());
		map.put("st", (page-1)*5+1);
		map.put("en", page*5);
	
		return sqlSession.selectList(key, map);
	}


	@Override
	public int myPartyCount(PartyVO vo) {
		log.info("myPartyCount()...{}", vo);
		
		return sqlSession.selectOne("myPartyCount", vo);
	}


	@Override
	public int shopPartyCount(String searchWord) {
		log.info("shopPartyCount()...{}", searchWord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchWord", searchWord);
		
		return sqlSession.selectOne("partyCount", map);
	}

}
 