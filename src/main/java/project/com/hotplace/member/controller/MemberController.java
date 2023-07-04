package project.com.hotplace.member.controller;

import java.io.IOException;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.email.Email;
import project.com.hotplace.email.EmailSender;
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@Autowired
    private EmailSender emailSender;
	
	@RequestMapping(value = "/jonggwan", method = RequestMethod.GET)
	public String jonggwan() {
		log.info("jonggwan.do...");
		
		return "jonggwan";
	}
	
	@RequestMapping(value = {"member/selectAll.do"}, method = RequestMethod.GET)
	public String selectAll() {
		log.info("member/selectAll.do...");
		
		return "/member/selectAll";
	}
	
	@RequestMapping(value = {"member/insert.do"}, method = RequestMethod.GET)
	public String insert() {
		log.info("member/insert.do...");
		
		return "/member/insert";
	}
	
	@RequestMapping(value = {"member/findId.do"}, method = RequestMethod.GET)
	public String findId() {
		log.info("findId.do...");
		
		return "member/findId";
		
	}
	@RequestMapping(value = {"member/findPw.do"}, method = RequestMethod.GET)
	public String findPw() {
		log.info("findPw.do...");
		
		return "member/findPw";
		
	}
	
	@RequestMapping(value = {"member/selectOne.do"}, method = RequestMethod.GET)
	public String selectOne(MemberVO vo, Model model) {
		log.info("member/selectOne.do...");
		
		MemberVO vo2 = service.selectOne(vo);
		log.info("vo2 outinfo...{}",vo2);
		
		model.addAttribute("vo2",vo2);
		
		return "member/selectOne";
	}
	
	@RequestMapping(value = {"login.do"}, method = RequestMethod.GET)
	public String login(MemberVO vo) {
		log.info("login.do...");
		
			return "member/login";
		
	}

	@RequestMapping(value = "/member/idAuth.do", method = RequestMethod.POST)
	public ModelAndView idAuth(MemberVO vo,HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
	    vo.setNick_name(request.getParameter("nick_name"));

	    MemberVO vo2 = service.idAuth(vo);
		log.info("idAuth checked..email..{}",vo2);
	    
		if(vo2 != null) {
		    int num = ThreadLocalRandom.current().nextInt(100_000, 1_000_000); // 100000 이상 1000000 미만의 난수 생성
		    String formattedNum = String.format("%06d", num); // 6자리로 포맷팅된 문자열 생성
		
		if (vo2.getNick_name().equals(request.getParameter("nick_name"))) {
			session.setAttribute("email", vo2.getEmail());
			session.setAttribute("authNum", formattedNum);
			session.setMaxInactiveInterval(5*60);
			
			Email email = new Email();
			String reciver = vo2.getEmail(); //받는사람
			String subject = "[HOTPLACE] 이메일 찾기 인증 이메일 입니다"; 
			String content = System.getProperty("line.separator") + "안녕하세요 회원님" + System.getProperty("line.separator")
					+ "HOTPLACE 이메일 찾기 인증번호는 " + formattedNum + " 입니다." + System.getProperty("line.separator"); // 

			try {
				email.setReciver(reciver);
				email.setSubject(subject);
				email.setContent(content);

				emailSender.SendEmail(email);
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}

			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/idAuth");
			mv.addObject("num", formattedNum);
			return mv;
		}else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/findId");
		    mv.addObject("errorMessage", "일치하는 정보가 존재하지 않습니다."); // 에러 메시지 추가
			return mv;
		}
		}else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/findId");
		    mv.addObject("errorMessage", "일치하는 정보가 존재하지 않습니다."); // 에러 메시지 추가
			return mv;
		}
	}
	@RequestMapping(value = "/member/pwAuth.do", method = RequestMethod.POST)
	public ModelAndView pwAuth(MemberVO vo,HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		vo.setNick_name(request.getParameter("nick_name"));
		vo.setEmail(request.getParameter("email"));
		
		MemberVO vo2 = service.pwAuth(vo);
		log.info("pwAuth checked..{}",vo2);
		
		if(vo2 != null) {
			int num = ThreadLocalRandom.current().nextInt(100_000, 1_000_000); // 100000 이상 1000000 미만의 난수 생성
			String formattedNum = String.format("%06d", num); // 6자리로 포맷팅된 문자열 생성
			
			if (vo2.getNick_name().equals(request.getParameter("nick_name"))) {
				session.setAttribute("authNum", formattedNum);
				session.setMaxInactiveInterval(5*60);
				
				Email email = new Email();
				String reciver = vo2.getEmail(); //받는사람
				String subject = "[HOTPLACE] 비밀번호 찾기 인증 이메일 입니다"; 
				String content = System.getProperty("line.separator") + "안녕하세요 회원님" + System.getProperty("line.separator")
				+ "HOTPLACE 비밀번호 찾기 인증번호는 " + formattedNum + " 입니다." + System.getProperty("line.separator"); // 
				
				try {
					email.setReciver(reciver);
					email.setSubject(subject);
					email.setContent(content);
					
					emailSender.SendEmail(email);
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
				
				ModelAndView mv = new ModelAndView();
				mv.setViewName("member/pwAuth");
				mv.addObject("num", formattedNum);
				mv.addObject("vo2Num", vo2.getNum());
				return mv;
			}else {
				ModelAndView mv = new ModelAndView();
				mv.setViewName("member/findPw");
			    mv.addObject("errorMessage", "일치하는 정보가 존재하지 않습니다."); // 에러 메시지 추가
				return mv;
			}
		}else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/findPw");
		    mv.addObject("errorMessage", "일치하는 정보가 존재하지 않습니다."); // 에러 메시지 추가
			return mv;
		}
	}
}
