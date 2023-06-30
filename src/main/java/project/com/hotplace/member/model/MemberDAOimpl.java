package project.com.hotplace.member.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDAOimpl implements MemberDAO {

	@Autowired
	SqlSession sqlSession;

	public MemberDAOimpl() {
		log.info("MemberDAOimpl()...");
	}

	@Override
	public List<MemberVO> selectAll(String searchKey, String searchWord, int page) {
		log.info("selectAll()...searchKey: {}", searchKey);
		log.info("selectAll()...searchWord: {}", searchWord);
		log.info("selectAll()...page: {}", page);

		// SQL 쿼리에 전달할 파라미터를 저장할 변수를 생성
		Map<String, Object> parameters = new HashMap<String, Object>();

		// offset으로 1페이지당 출력할 내용 계산
		int itemsPerPage = 10;
		int end = itemsPerPage * page;
		int start = (page - 1) * itemsPerPage + 1;
		// 1 -> 1 ~ 10 // 2 -> 11~20

		// 페이징을 위한 오프셋과 제한(limit) 파라미터를 설정합니다.
		parameters.put("end", end);
		parameters.put("start", start);

		// 검색 키워드(searchKey)와 검색어(searchWord)가 null이 아닌 경우에만 파라미터로 설정
		if (!searchKey.isEmpty() && !searchWord.isEmpty()) {
			parameters.put("searchKey", searchKey);
			parameters.put("searchWord", "%" + searchWord + "%");
			log.info("parameters...search{}", parameters.toString());
			return sqlSession.selectList("MEM_SEARCHLIST", parameters);
		} else {
			log.info("parameters...select{}", parameters.toString());
			return sqlSession.selectList("MEM_SELECTALL", parameters);
		}

	}

	@Override
	public MemberVO selectOne(MemberVO vo) {
		log.info("selectOne()...{}", vo);

		return sqlSession.selectOne("MEM_SELECTONE", vo);
	}

	@Override
	public int insertOK(MemberVO vo) {
		log.info("insertOK()...{}", vo);
		int flag = sqlSession.insert("MEM_INSERTOK", vo);

		return flag;
	}

	@Override
	public int updateOK(MemberVO vo) {
		log.info("updateOK()...{}", vo);
		int flag = sqlSession.update("MEM_UPDATEOK", vo);

		return flag;
	}

	@Override
	public int deleteOK(MemberVO vo) {
		log.info("deleteOK()...{}", vo);
		int flag = sqlSession.delete("MEM_DELETEOK", vo);

		return flag;
	}

	@Override
	public MemberVO login(MemberVO vo) {
		log.info("login()...{}", vo);
		MemberVO vo2 = sqlSession.selectOne("MEM_LOGIN", vo);
		;

		return vo2;
	}

	@Override
	public int logout(MemberVO vo) {
		log.info("logout()...{}", vo);
		int flag = sqlSession.selectOne("MEM_LOGOUT", vo);

		return flag;
	}

	@Override
	public MemberVO nickNameCheck(MemberVO vo) {
		log.info("nikeNameCheck()...{}", vo);

		return sqlSession.selectOne("MEM_NICK_NAME_CHECK", vo);
	}

	@Override
	public MemberVO emailCheck(MemberVO vo) {
		log.info("emailCheck()...{}", vo);

		return sqlSession.selectOne("MEM_EMAIL_CHECK", vo);
	}

	@Override
	public int upgradeOK(MemberVO vo) {
		log.info("upgradeOK()...{}", vo);

		return sqlSession.update("MEM_UPGRADEOK", vo);
	}

}
