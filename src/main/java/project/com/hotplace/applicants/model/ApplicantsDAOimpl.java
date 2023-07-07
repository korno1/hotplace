package project.com.hotplace.applicants.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ApplicantsDAOimpl implements ApplicantsDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public ApplicantsDAOimpl() {
		log.info("ApplicantsDAOimpl()...");
	}

	@Override
	public List<ApplicantsVO> selectAll(ApplicantsVO vo) {
		log.info("selectAll()...");
		return sqlSession.selectList("APP_SELECTALL", vo);
	}

	@Override
	public int insert(ApplicantsVO vo) {
		log.info("insert()...{}", vo);
		return sqlSession.insert("APP_INSERT", vo);
	}

	@Override
	public int approve(ApplicantsVO vo) {
		log.info("approve()...{}", vo);
		return sqlSession.update("APP_APPROVE", vo);
	}

	@Override
	public int reject(ApplicantsVO vo) {
		log.info("reject()...{}", vo);
		return sqlSession.delete("APP_REJECT", vo);
	}

	@Override
	public int delete(ApplicantsVO vo) {
		log.info("delete()...{}", vo);
		return sqlSession.delete("APP_DELETE", vo);
	}
}
