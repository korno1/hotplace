package project.com.hotplace.memberreview.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberReviewDAOimpl implements MemberReviewDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<MemberReviewVO> selectAll(MemberReviewVO vo, Integer page) {
		log.info("selectAll()...vo{}", vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		String key = "mre_selectAll";
		
		map.put("userNum", vo.getUserNum());
		map.put("st", (page-1)*6+1);
		map.put("en", page*6);
		
		return sqlSession.selectList(key, map);
	}

	@Override
	public int insert(MemberReviewVO vo) {
		log.info("insert()...vo{}", vo);
		int flag = 0;
		
		try {
			flag = sqlSession.insert("mre_insert", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

	@Override
	public int update(MemberReviewVO vo) {
		log.info("update()...vo{}", vo);
		
		int flag = 0;
		
		try {
			flag = sqlSession.insert("mre_update", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public int delete(MemberReviewVO vo) {
		log.info("delete()...vo{}", vo);
		
		int flag = 0;
		
		try {
			flag = sqlSession.insert("mre_delete", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

}
