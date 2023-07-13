package project.com.hotplace.event.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class EventDAOimpl implements EventDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<EventVO> selectAll(String searchKey, String searchWord) {
		log.info("selectAll()...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);

		Map<String, String> map = new HashMap<String, String>();
		
		String key = "EVE_SELECTALL";
		
		map.put("searchKey", searchKey);
		map.put("searchWord", "%" + searchWord + "%");
	
		sqlSession.delete("EVE_OVERDATE_DELETE");
		
		return sqlSession.selectList(key, map);
	}

	@Override
	public EventVO selectOne(EventVO vo) {
		log.info("selectOne()...{}", vo);
		return sqlSession.selectOne("EVE_SELECTONE", vo);
	}

	@Override
	public List<EventVO> searchList(String searchKey, String searchWord, int page) {
		log.info("searchList()...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);

		Map<String, Object> map = new HashMap<String, Object>();
		
		String key = "EVE_SEARCHLIST";
		
		map.put("searchKey", searchKey);
		map.put("searchWord", "%" + searchWord + "%");
	
		map.put("st", (page-1)*10+1);
		map.put("en", page*10);
		
		
		return sqlSession.selectList(key, map);
	}

	@Override
	public int insert(EventVO vo) {
		log.info("insert()...{}", vo);
		return sqlSession.insert("EVE_INSERT", vo);
	}

	@Override
	public int update(EventVO vo) {
		log.info("update()...{}", vo);
		return sqlSession.update("EVE_UPDATE", vo);
	}

	@Override
	public int delete(EventVO vo) {
		log.info("delete()...{}", vo);
		return sqlSession.update("EVE_DELETEDATE_UPDATE", vo);
	}

	@Override
	public void vCountUp(EventVO vo) {
		log.info("vCountUp()...{}", vo);
		sqlSession.update("EVE_VCOUNT_UPDATE", vo);
	}

}
