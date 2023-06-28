package project.com.hotplace.notice.model;

import java.util.List;

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
	public List<NoticeVO> selectAll() {
		log.info("selectAll()...");
		
		return sqlSession.selectList("NOT_SELECT_ALL");
	}

	@Override
	public NoticeVO selectOne(NoticeVO vo) {
		log.info("selectOne()...{}", vo);
		
		return sqlSession.selectOne("NOT_SELECT_ONE", vo);
	}

	@Override
	public List<NoticeVO> selectList(String searchKey, String searchWord) {
		log.info("selectOne()...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		
		String key = "";
		if(searchKey.equals("title")) {
			key = "NOT_SEARCHLIST_TITLE";
		}
		else {
			key = "NOT_SEARCHLIST_CONTENT";
		}
		
		return selectList(key, "%" + searchWord + "%");
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
		return sqlSession.delete("NOT_DELETE", vo);
	}

	@Override
	public void vCountUp(NoticeVO vo) {
		log.info("vCountUp()...{}", vo);
		sqlSession.update("NOT_VCOUNT_UPDATE", vo);
	}

}
