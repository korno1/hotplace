package project.com.hotplace.shopreview.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ShopReviewDAOimpl implements ShopReviewDAO {
	
	@Autowired
	SqlSession sqlSession;

	public ShopReviewDAOimpl() {
		log.info("ShopDAOimpl()...");
	}

	@Override
	public List<ShopReviewVO> selectAll(ShopReviewVO vo) {
		log.info("selectAll()...");

		return sqlSession.selectList("SELECT_ALL");
	}

	@Override
	public int insert(ShopReviewVO vo) {
		log.info("insert()...");
		
		return sqlSession.insert("INSERT", vo);
	}

	@Override
	public int update(ShopReviewVO vo) {
		log.info("update()...");
		
		return sqlSession.update("UPDATE", vo);
	}

	@Override
	public int delete(ShopReviewVO vo) {
		log.info("delete()...");
		
		return sqlSession.delete("DELETE", vo);
	}

}
