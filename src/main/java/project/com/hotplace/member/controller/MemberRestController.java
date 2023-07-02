package project.com.hotplace.member.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.mail.model.MailVO;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class MemberRestController {

	@Autowired
	ServletContext sContext;

	@Autowired
	private MemberService service;

	@RequestMapping(value = "/member/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> selectAll(String searchKey, String searchWord, int page) {
		int pageNumber = 1;
		int nextPageNumber = page + 1;
		
		log.info("member/json/selectAll.do");
		if (page > 0) {
			pageNumber = page;
		}

		// selectAll, searchList
		List<MemberVO> vos = service.selectAll(searchKey, searchWord, pageNumber);
	    List<MemberVO> vos2 = service.selectAll(searchKey, searchWord, nextPageNumber);

	    boolean isLast = vos2.isEmpty();
		log.info("vos.size():{}", vos.size());
		
		Map<String, Object> response = new HashMap<String, Object>();
	    response.put("vos", vos);
	    response.put("isLast", isLast);

		return response;
	}
	
	@RequestMapping(value = "/member/json/selectOne.do", method = RequestMethod.POST)
	@ResponseBody
	public MemberVO selectOne(MemberVO vo) {
		log.info("member/json/selectOne...{}",vo);
		
		MemberVO vo2 = service.selectOne(vo);
		log.info("selectOne matching member...{}", vo2);
		
		return vo2;
	}

	@RequestMapping(value = "/member/json/nickNameCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String nickNameCheck(MemberVO vo) {
		log.info("nickNameCheck:{}", vo);

		MemberVO vo2 = service.nickNameCheck(vo);
		log.info("{}", vo2);
		if (vo2 == null) {
			return "{\"result\":\"OK\"}";
		} else {
			return "{\"result\":\"NotOK\"}";
		}
	}

	@RequestMapping(value = "/member/json/emailCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public String emailCheck(MemberVO vo) {
		log.info("nickNameCheck:{}", vo);

		MemberVO vo2 = service.emailCheck(vo);
		log.info("{}", vo2);
		if (vo2 == null) {
			return "{\"result\":\"OK\"}";
		} else {
			return "{\"result\":\"NotOK\"}";
		}
	}

	@RequestMapping(value = "/member/json/insertOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String insertOK(MemberVO vo) {
		log.info("insert...{}", vo);

		int result = service.insertOK(vo);
		log.info("result:{}", result);
		if (result == 1) {
			return "{\"result\":\"OK\"}";
		} else {
			return "{\"result\":\"NotOK\"}";
		}
	}

	@RequestMapping(value = "/member/json/updateOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateOK(MemberVO vo) throws IllegalStateException, IOException {
		log.info("updateOK...{}", vo);

		if (vo.getMultipartFile() != null && !vo.getMultipartFile().isEmpty()) {
		String getOriginalFilename = vo.getMultipartFile().getOriginalFilename();
		int fileNameLength = vo.getMultipartFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

//		if (fileNameLength != 0) {
			String originalFilename = vo.getMultipartFile().getOriginalFilename();
			String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
			String newFilename = vo.getNum() + extension;

			String realPath = sContext.getRealPath("resources/ProfileImage");
			String filePath = realPath + File.separator + newFilename;
			File file = new File(filePath);
			vo.getMultipartFile().transferTo(file);

			// 썸네일 이미지 생성 코드
			BufferedImage originalBufferedImage = ImageIO.read(file);
			BufferedImage thumbnailBufferedImage = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphics = thumbnailBufferedImage.createGraphics();
			graphics.drawImage(originalBufferedImage, 0, 0, 200, 200, null);

			String thumbnailFilePath = realPath + File.separator + vo.getNum() + extension;
			File thumbnailFile = new File(thumbnailFilePath);
			ImageIO.write(thumbnailBufferedImage, extension.substring(1), thumbnailFile);

			int result = service.updateOK(vo);
			log.info("result:{}", result);
			if (result == 1) {
				return "{\"result\":\"OK\"}";
			} else {
				return "{\"result\":\"NotOK\"}";
			}
		}else {
			int result = service.updateOK(vo);
			log.info("result:{}", result);
			if (result == 1) {
				return "{\"result\":\"OK\"}";
			} else {
				return "{\"result\":\"NotOK\"}";
			}
			
		}
	}

	@RequestMapping(value = "/member/json/upgradeOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String upgradeOK(MemberVO vo) {
		log.info("upgradeOK...{}", vo);
		
		int result = service.upgradeOK(vo);
		log.info("result:{}", result);
		if (result == 1) {
			return "{\"result\":\"OK\"}";
		} else {
			return "{\"result\":\"NotOK\"}";
		}
	}
	
	@RequestMapping(value = "/member/json/deleteOK.do", method = RequestMethod.POST)
	@ResponseBody
	public String deleteOK(MemberVO vo) {
		log.info("insert...{}", vo);

		int result = service.deleteOK(vo);
		log.info("result:{}", result);
		if (result == 1) {
			return "{\"result\":\"OK\"}";
		} else {
			return "{\"result\":\"NotOK\"}";
		}
	}

}
