package project.com.hotplace.memberreview.model;

import java.util.List;

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
	public List<MemberReviewVO> selectAll(MemberReviewVO vo) {
		log.info("selectAll()...vo{}", vo);
		
		List<MemberReviewVO> vos = sqlSession.selectList("mre_selectAll", vo);
		
		return vos;
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
