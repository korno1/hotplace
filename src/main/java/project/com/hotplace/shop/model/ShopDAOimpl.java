package project.com.hotplace.shop.model;

import java.util.List;

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
		return sqlSession.insert("INSERT",vo);
	}

	@Override
	public int update(ShopVO vo) {
		log.info("update()....{}", vo);
		return sqlSession.update("UPDATE",vo);
	}

	@Override
	public int delete(ShopVO vo) {
		log.info("delete()....{}", vo);
		return sqlSession.delete("DELETE",vo);
	}

	@Override
	public List<ShopVO> selectAll() {
		log.info("selectAll()....{}");
		return sqlSession.selectList("SELECT_ALL");
	}

	@Override
	public ShopVO selectOne(ShopVO vo) {
		log.info("selectOne()....{}", vo);
		return sqlSession.selectOne("SELECT_ONE",vo);
	}

	@Override
	public List<ShopVO> searchList(String searchKey, String searchWord) {
		log.info("searchList()....searchKey:{}",searchKey);
		log.info("searchList()....searchWord:{}",searchWord);
		String key = "";
		if(searchKey.equals("name")) {
			key = "SEARCH_LIST_NAME";
		}else {
			key = "SEARCH_LIST_CATE";
		}
		return sqlSession.selectList(key,"%"+searchWord+"%");
	}

}
