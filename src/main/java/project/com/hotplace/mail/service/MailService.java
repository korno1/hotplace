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

	public List<MailVO> selectAll(int user_num, int page) {
		return dao.selectAll(user_num,page);
	}

	public MailVO selectOne(MailVO vo) {
		return dao.selectOne(vo);
	}

	public int insertOK(MailVO vo) {
		return dao.insertOK(vo);
	}

	public int updateOK(MailVO vo) {
		return dao.updateOK(vo);
	}

	public int deleteOK(MailVO vo) {
		return dao.deleteOK(vo);
	}
	
}
