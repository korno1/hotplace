package project.com.hotplace.shopreview.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<ShopReviewVO> selectAllReview(int shopNum) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("shopNum", shopNum);

		return sqlSession.selectList("SRE_SELECT_ALL", param);
		
	}

	@Override
	public List<ShopReviewVO> selectAll(ShopReviewVO vo, int page) {
		log.info("selectAll()...");
		log.info("{}", vo);
		log.info("page...:{}", page);
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		int itemsPerPage = 5;
		int end = itemsPerPage * page;
		int start = (page - 1) * itemsPerPage + 1;
		
		param.put("end", end);
		param.put("start", start);
		param.put("shopNum", vo.getShopNum());

		return sqlSession.selectList("SRE_SELECT_ALL_PAGE", param);
	}
	
	@Override
	public int countNum() {
		log.info("countNum()...");
		
		Integer maxNum = sqlSession.selectOne("SRE_SEQ_NUM");
	    return maxNum != null ? maxNum : 0;
	}
	
	@Override
	public ShopReviewVO selectOne(ShopReviewVO vo) {
		log.info("selectOne()...");
		
		return sqlSession.selectOne("SRE_SELECT_ONE", vo);
	}

	@Override
	public int insert(ShopReviewVO vo) {
		log.info("insert()...");
		
		return sqlSession.insert("SRE_INSERT", vo);
	}

	@Override
	public int update(ShopReviewVO vo) {
		log.info("update()...");
		
		return sqlSession.update("SRE_UPDATE", vo);
	}

	@Override
	public int delete(int num) {
		log.info("delete()...");
		
		return sqlSession.delete("SRE_DELETE", num);
	}
	
	public int count(ShopReviewVO vo) {
		log.info("countVOS()...");
		
		return sqlSession.selectOne("SRE_COUNT_VO", vo);
	}
	
	public int rateAvg(int shopNum) {
		log.info("rateAvg()...{}", shopNum);
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("shopNum", shopNum);
		
		return sqlSession.selectOne("SRE_AVG_RATE", param);
	}

}
