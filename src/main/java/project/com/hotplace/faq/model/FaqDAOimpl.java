package project.com.hotplace.faq.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
@Repository
@Slf4j
public class FaqDAOimpl implements FaqDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public FaqDAOimpl() {
		log.info("FaqDAOimpl()...");
	}

	@Override
	public List<FaqVO> selectAll(String searchKey, String searchWord) {
		log.info("selectAll()...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);

		Map<String, String> map = new HashMap<String, String>();
		
		String key = "FAQ_SELECTALL";
		
		map.put("searchKey", searchKey);
		map.put("searchWord", "%" + searchWord + "%");
	
		sqlSession.delete("FAQ_OVERDATE_DELETE");
		
		return sqlSession.selectList(key, map);
	}

	@Override
	public List<FaqVO> searchList(String searchKey, String searchWord, int page) {
		log.info("searchList()...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);

		Map<String, Object> map = new HashMap<String, Object>();
		
		String key = "FAQ_SEARCHLIST";
		
		map.put("searchKey", searchKey);
		map.put("searchWord", "%" + searchWord + "%");
	
		map.put("st", (page-1)*10+1);
		map.put("en", page*10);
		
		
		return sqlSession.selectList(key, map);
	}

	@Override
	public int insert(FaqVO vo) {
		log.info("insert()...{}", vo);
		return sqlSession.insert("FAQ_INSERT", vo);
	}

	@Override
	public int update(FaqVO vo) {
		log.info("update()...{}", vo);
		return sqlSession.update("FAQ_UPDATE", vo);
	}

	@Override
	public int delete(FaqVO vo) {
		log.info("delete()...{}", vo);
		return sqlSession.update("FAQ_DELETEDATE_UPDATE", vo);
	}

	@Override
	public FaqVO selectOne(FaqVO vo) {
		log.info("selectOne()...{}", vo);
		return sqlSession.selectOne("FAQ_SELECTONE", vo);
	}

}
