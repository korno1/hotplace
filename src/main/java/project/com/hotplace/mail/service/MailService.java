package project.com.hotplace.mail.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.mail.model.MailDAO;
import project.com.hotplace.mail.model.MailVO;

@Slf4j
@Service
public class MailService {

	@Autowired
	MailDAO dao;

	public MailService() {
		log.info("MailService()...");
	}
	public List<MailVO> selectAll(int sender_num, int recipient_num, int page) {
		return dao.selectAll(sender_num,recipient_num,page);
	}

	public List<MailVO> selectAllAdmin(String searchKey, String searchWord, int page) {
		return dao.selectAllAdmin(searchKey,searchWord,page);
	}
	public MailVO selectOne(MailVO vo) {
		return dao.selectOne(vo);
	}

	public int insertOK(MailVO vo) {
		return dao.insertOK(vo);
	}

	public int deleteOK(MailVO vo) {
		return dao.deleteOK(vo);
	}
	public int readOK(MailVO vo) {
		return dao.readOK(vo);
	}
	public int newMailCnt(MailVO vo) {
		return dao.newMailCnt(vo);
	}
	
}
