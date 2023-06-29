package project.com.hotplace.member.model;

import java.util.List;

public interface MemberDAO {
	List<MemberVO> selectAll(String serachKey,String searchWord, int page);
	MemberVO selectOne(MemberVO vo);
	int insertOK(MemberVO vo);
	int updateOK(MemberVO vo);
	int deleteOK(MemberVO vo);
	MemberVO login(MemberVO vo);
	int logout(MemberVO vo);
	MemberVO nickNameCheck(MemberVO vo);
	MemberVO emailCheck(MemberVO vo);
	int upgradeOK(MemberVO vo);
	
	
}
