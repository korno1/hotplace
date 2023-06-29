package project.com.hotplace.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.member.model.MemberDAO;
import project.com.hotplace.member.model.MemberVO;

@Slf4j
@Service
public class MemberService {

	@Autowired
	MemberDAO dao;

	public MemberService() {
		log.info("MemberService()...");
	}

	public List<MemberVO> selectAll(String serachKey, String searchWord, int page) {
		return dao.selectAll(serachKey, searchWord, page);
	}

	public MemberVO selectOne(MemberVO vo) {
		return dao.selectOne(vo);
	}

	public int insertOK(MemberVO vo) {
		return dao.insertOK(vo);
	}

	public int updateOK(MemberVO vo) {
		return dao.updateOK(vo);
	}

	public int deleteOK(MemberVO vo) {
		return dao.deleteOK(vo);
	}
	
	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}
	public int logout(MemberVO vo) {
		return dao.logout(vo);
	}
	public MemberVO nickNameCheck(MemberVO vo) {
		return dao.nickNameCheck(vo);
	}
	public MemberVO emailCheck(MemberVO vo) {
		return dao.emailCheck(vo);
	}

	public int upgradeOK(MemberVO vo) {
		return dao.upgradeOK(vo);
	}
}
