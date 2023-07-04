package project.com.hotplace.mail.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MailDAOimpl implements MailDAO {

	@Autowired
	SqlSession sqlSession;

	public MailDAOimpl() {
		log.info("MailDAOimpl()...");
	}

	@Override
	public List<MailVO> selectAll(int sender_num, int recipient_num, int page) {
		log.info("selectAll()...sender_num: {}", sender_num);
		log.info("selectAll()...recipient_num: {}", recipient_num);
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
		if (sender_num == 0) {
			parameters.put("searchKey", "recipient_num");
			parameters.put("user_num", recipient_num);
		} else if (recipient_num == 0) {
			parameters.put("searchKey", "sender_num");
			parameters.put("user_num", sender_num);
		}
		return sqlSession.selectList("MAI_SELECTALL", parameters);
	}
	

	@Override
	public List<MailVO> selectAllAdmin(String searchKey, String searchWord,int page) {
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
			return sqlSession.selectList("MAI_SEARCHLIST_ADMIN", parameters);
		} else {
			log.info("parameters...select{}", parameters.toString());
			return sqlSession.selectList("MAI_SELECTALL_ADMIN", parameters);
		}
	}

	@Override
	public MailVO selectOne(MailVO vo) {
		log.info("selectOne()...{}", vo);

		return sqlSession.selectOne("SELECTONE", vo);
	}

	@Override
	public int insertOK(MailVO vo) {
		log.info("insertOK()...{}", vo);
		int flag = sqlSession.insert("INSERTOK", vo);

		return flag;
	}

	@Override
	public int deleteOK(MailVO vo) {
		log.info("deleteOK()...{}", vo);
		int flag = sqlSession.delete("DELETEOK", vo);

		return flag;
	}

	@Override
	public int readOK(MailVO vo) {
		log.info("readOK()...{}", vo);
		int flag = sqlSession.update("READOK", vo);

		return flag;
	}


}
