package project.com.hotplace.notice.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class NoticeDAOimpl implements NoticeDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public NoticeDAOimpl() {
		log.info("NoticeDAOimpl()...");
	}
	
	
	@Override
	public List<NoticeVO> selectAll(String searchKey, String searchWord) {
		log.info("selectAll()...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		
		Map<String, String> map = new HashMap<String, String>();
		
		String key = "NOT_SELECTALL";
		
		map.put("searchKey", searchKey);
		map.put("searchWord", "%" + searchWord + "%");
	
		sqlSession.delete("NOT_OVERDATE_DELETE");
		
		return sqlSession.selectList(key, map);
	}

	@Override
	public NoticeVO selectOne(NoticeVO vo) {
		log.info("selectOne()...{}", vo);
		
		return sqlSession.selectOne("NOT_SELECT_ONE", vo);
	}

	@Override
	public List<NoticeVO> searchList(String searchKey, String searchWord, int page) {
		log.info("searchList()...");
		
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);
		Map<String, Object> map = new HashMap<String, Object>();
		
		String key = "NOT_SEARCHLIST";
		
		map.put("searchKey", searchKey);
		map.put("searchWord", "%" + searchWord + "%");
	
		map.put("st", (page-1)*10+1);
		map.put("en", page*10);
		
		
		return sqlSession.selectList(key, map);
	}

	@Override
	public int insert(NoticeVO vo) {
		log.info("insert()...{}", vo);
		
		return sqlSession.insert("NOT_INSERT", vo);
	}

	@Override
	public int update(NoticeVO vo) {
		log.info("update()...{}", vo);
		return sqlSession.update("NOT_UPDATE", vo);
	}

	@Override
	public int delete(NoticeVO vo) {
		log.info("delete()...{}", vo);
		return sqlSession.delete("NOT_DELETEDATE_UPDATE", vo);
	}

	@Override
	public void vCountUp(NoticeVO vo) {
		log.info("vCountUp()...{}", vo);
		sqlSession.update("NOT_VCOUNT_UPDATE", vo);
	}


//	@Override
//	public void deleteOverDate() {
//		int res = sqlSession.delete("NOT_OVERDATE_DELETE");
//		log.info("res: {}", res);
//	}

}
