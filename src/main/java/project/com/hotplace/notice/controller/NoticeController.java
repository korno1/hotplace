package project.com.hotplace.notice.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.notice.model.NoticeVO;
import project.com.hotplace.notice.service.NoticeService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class NoticeController {
	
	@Autowired
	NoticeService service;
	
	@Autowired
	ServletContext sContext;
	/** 
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/jm.do", method = RequestMethod.GET)
	public String jm() {
		log.info("/jm.do...");
		
		
		return "jm";
	}
	
	@RequestMapping(value = "/notice/selectAll.do", method = RequestMethod.GET)
	public String selectAll(String searchKey, String searchWord, int page, Model model) {
		log.info("/not_selectAll.do...");
		
		List<NoticeVO> vos = service.searchList(searchKey, searchWord, page);
		log.info("vos: {}", vos);
		
		int cnt = service.selectAll(searchKey, searchWord).size();
		log.info("cnt: {}", cnt);
	
		
		model.addAttribute("vos", vos);
		model.addAttribute("cnt", cnt);
		
		
				
		return "notice/selectAll";
	}
	
	@RequestMapping(value = "/notice/selectOne.do", method = RequestMethod.GET)
	public String selectOne(NoticeVO vo, Model model) {
		log.info("/not_selectAll.do...");
		
		service.vCountUp(vo);
		
		NoticeVO vo2 = service.selectOne(vo);
		log.info("vo2: {}", vo2);
		
		

	

		model.addAttribute("vo2", vo2);
		
		return "notice/selectOne";
	}
	
	@RequestMapping(value = "/notice/insert.do", method = RequestMethod.GET)
	public String insert() {
		log.info("/not_insert.do...");
		
				
		return "notice/insert";
	}
	
	@RequestMapping(value = "/notice/insertOK.do", method = RequestMethod.POST)
	public String insertOK(NoticeVO vo) throws IllegalStateException, IOException {
		log.info("/not_insertOK.do...{}", vo);
		
		String getOriginalFilename = vo.getFile().getOriginalFilename();
		int fileNameLength = vo.getFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);
		
		
		
		if (getOriginalFilename.length() != 0) {
			UUID uuid = UUID.randomUUID();
			getOriginalFilename = uuid.toString() + getOriginalFilename;
			log.info("{}", getOriginalFilename);
			log.info("{}", getOriginalFilename.length());

			vo.setSaveName(getOriginalFilename);
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/PostImage");
			log.info("realPath : {}", realPath);

			File f = new File(realPath + "\\" + vo.getSaveName());
			vo.getFile().transferTo(f);

		}
		
		log.info("vo: {}", vo);
		
		vo.setWriterNum(1);
		int result = service.insert(vo);
		log.info("result: {}", result);
		
				
		return "redirect:selectAll.do?searchKey=title&searchWord=&page=1";
	}
	
	@RequestMapping(value = "/notice/update.do", method = RequestMethod.GET)
	public String update(NoticeVO vo, Model model) {
		log.info("/not_update.do...");
		
		NoticeVO vo2 = service.selectOne(vo);
		log.info("vo2: {}", vo2);
		
		model.addAttribute("vo2", vo2);
				
		return "notice/update";
	}
	
	@RequestMapping(value = "/notice/updateOK.do", method = RequestMethod.POST)
	public String updateOK(NoticeVO vo) throws IllegalStateException, IOException {
		log.info("/not_updateOK.do...{}", vo);
		
		String getOriginalFilename = vo.getFile().getOriginalFilename();
		int fileNameLength = vo.getFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);
		
		
		
		if (getOriginalFilename.length() != 0) {
			UUID uuid = UUID.randomUUID();
			getOriginalFilename = uuid.toString() + getOriginalFilename;
			log.info("{}", getOriginalFilename);
			log.info("{}", getOriginalFilename.length());

			vo.setSaveName(getOriginalFilename);
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/PostImage");
			log.info("realPath : {}", realPath);

			File f = new File(realPath + "\\" + vo.getSaveName());
			vo.getFile().transferTo(f);

		}
		
		int result = service.update(vo);
		log.info("result: {}", result);
		
		return "redirect:selectOne.do?num=" + vo.getNum();
	}
	
	@RequestMapping(value = "/notice/deleteOK.do", method = RequestMethod.GET)
	public String deleteOK(NoticeVO vo) {
		log.info("/not_deleteOK.do...{}", vo);
		
		int result = service.delete(vo);
		log.info("result: {}", result);
		
		return "redirect:selectAll.do?searchKey=title&searchWord=&page=1";
	}
	
}
