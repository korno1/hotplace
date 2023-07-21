package project.com.hotplace.shop.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ShopDAOimpl implements ShopDAO {
	
	@Autowired
	SqlSession sqlSession;

	public ShopDAOimpl() {
		log.info("shopDAOimpl....");
	}
	
	@Override
	public int insert(ShopVO vo) {
		log.info("insert()....{}", vo);
		return sqlSession.insert("SHO_INSERT",vo);
	}

	@Override
	public int update(ShopVO vo) {
		log.info("update()....{}", vo);
		return sqlSession.update("SHO_UPDATE",vo);
	}

	@Override
	public int delete(ShopVO vo) {
		log.info("delete()....{}", vo);
		return sqlSession.delete("SHO_DELETE",vo);
	}
	
	public List<ShopVO> selectAllHome() {
		log.info("selectAllHome()...");
		
		return sqlSession.selectList("SHO_SELECT_ALL_HOME");
	}
	
	public int countNum() {
		log.info("countNum()...");
		
		Integer maxNum = sqlSession.selectOne("SHO_SEQ_NUM");
	    return maxNum != null ? maxNum : 0;
	}

	@Override
	public ShopVO selectOne(ShopVO vo) {
		log.info("selectOne()....{}", vo);
		return sqlSession.selectOne("SHO_SELECT_ONE",vo);
	}
	
	public int updateRate(int num, int rate, int reviewCount)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("num", num);
		param.put("rate", rate);
		param.put("reviewCount", reviewCount);
		
		log.info("updateRate()....{}", param);
		
		return sqlSession.update("SHO_UPDATE_RATE", param);
	}
	
	@Override
	public List<ShopVO> searchList(String searchWord) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("searchWord", searchWord);
		return sqlSession.selectList("SHO_SEARCH_LIST", param);
	}

	@Override
	public int decreaseReview(int shopNum) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("shopNum", shopNum);
		return sqlSession.update("SHO_DECREASE_REVIEW", param);
	}

}