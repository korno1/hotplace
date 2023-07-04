package project.com.hotplace.event.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.event.model.EventVO;
import project.com.hotplace.event.service.EventService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class EventRestController {
	
	@Autowired
	EventService service;
	
	@Autowired
	ServletContext sContext;
	/** 
	 * Simply selects the home view to render by returning its name.
	 */

	
	@RequestMapping(value = "/event/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public int selectAll(String searchKey, String searchWord) {
		log.info("/eve/json/selectAll.do...");
		
		
		int cnt = service.selectAll(searchKey, searchWord).size();
		log.info("cnt: {}", cnt);
//		
		return cnt;
	}
	
	@RequestMapping(value = "/event/json/searchList.do", method = RequestMethod.GET)
	@ResponseBody
	public List<EventVO> searchList(String searchKey, String searchWord, int page) {
		log.info("/event/json/selectAll.do...");
		log.info("searchKey: {}", searchKey);
		log.info("searchWord: {}", searchWord);
		log.info("page: {}", page);
		
		
		List<EventVO> vos = service.searchList(searchKey, searchWord, page);
		log.info("vos: {}", vos);
		
		return vos;
	}
//	
	@RequestMapping(value = "/event/json/selectOne.do", method = RequestMethod.GET)
	@ResponseBody
	public EventVO selectOne(EventVO vo) {
		log.info("/event/json/selectOne.do...");
		
		service.vCountUp(vo);
		
		EventVO vo2 = service.selectOne(vo);
		log.info("vo2: {}", vo2);
		
		return vo2;
	}
//	
	@RequestMapping(value = "/event/json/insertOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String insertOK(EventVO vo) throws IllegalStateException, IOException {
		log.info("/event/json/insertOK.do...{}", vo);
		
		
		
		
		if (vo.getFile()!=null && vo.getFile().getOriginalFilename().length() != 0) {
			String getOriginalFilename = vo.getFile().getOriginalFilename();
			log.info("getOriginalFilename:{}", getOriginalFilename);
			
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

		vo.setDeadline(vo.getDeadline().replace("T", " "));
		int result = service.insert(vo);
		log.info("result: {}", result);
		
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}"; // {"result" : 1}
		}
		else msg = "{\"result\" : 0}";
		
		return msg;
	
	}
//	
	@RequestMapping(value = "/event/json/updateOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateOK(EventVO vo) throws IllegalStateException, IOException {
		log.info("/event/json/updateOK.do...{}", vo);
		
		if (vo.getFile()!=null && vo.getFile().getOriginalFilename().length() != 0) {
			String getOriginalFilename = vo.getFile().getOriginalFilename();
			log.info("getOriginalFilename:{}", getOriginalFilename);
			
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
		vo.setDeadline(vo.getDeadline().replace("T", " ").substring(0, 16));
		int result = service.update(vo);
		log.info("result: {}", result);
		
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}"; // {"result" : 1}
		}
		else msg = "{\"result\" : 0}";
		
		return msg;
	
	}
//	
	@RequestMapping(value = "/event/json/deleteOK.do", method = RequestMethod.GET)
	@ResponseBody
	public String deleteOK(EventVO vo) {
		log.info("/event/json/deleteOK.do...{}", vo);

		int result = service.delete(vo);
		log.info("result: {}", result);
		
		String msg = "";
		
		if(result==1) {
			msg = "{\"result\" : 1}"; // {"result" : 1}
		}
		else msg = "{\"result\" : 0}";
		
		return msg;
	
	}
	
	
}
