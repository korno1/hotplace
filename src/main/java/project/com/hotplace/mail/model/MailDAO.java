package project.com.hotplace.mail.model;

import java.util.List;

public interface MailDAO {
	List<MailVO> selectAll(int sender_num, int recipient_num,int page);
	MailVO selectOne(MailVO vo);
	int insertOK(MailVO vo);
	int deleteOK(MailVO vo);
	int readOK(MailVO vo);
	List<MailVO> selectAllAdmin(int page);
	
	
}
