package project.com.hotplace.interceptor;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Interceptor extends HandlerInterceptorAdapter {

	@Autowired
	HttpSession session;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("preHandle()...");
		// 멤버 접속 허용 url 관리
		String memberAllowedPatterns = "/memberreview/json/selectAll\\.do|/memberreview/json/insertOK\\.do|/memberreview/json/updateOK\\.do|/memberreview/json/deleteOK\\.do|/memberreview/json/mre_totalCount\\.do|/party/selectAll\\.do|/party/selectOne\\.do|/party/insert\\.do|/party/insertOK\\.do|/party/update\\.do|/party/updateOK\\.do|/party/deleteOK\\.do|/party/myParty\\.do|/party/myPartyPaging.do|/party/json/selectAll\\.do|/party/json/par_totalCount\\.do|/party/json/approveOK\\.do|/shop/review/insert\\.do|/shop/insert\\.do|/shop/review/update\\.do|/shop/review/delete\\.do|/shop/update\\.do|/shop/delete\\.do|/member/json/selectOne\\.do|/member/json/updateOK\\.do|/member/json/deleteOK\\.do|/member/mypage\\.do|/member/selectOne\\.do|/mail/selectAll\\.do|/mail/insert\\.do|/mail/json/selectAll\\.do|/mail/json/newMailCnt\\.do|/mail/json/insertOK\\.do|/mail/json/readOK\\.do";		
		String managerAllowedPatterns = "/notice/insert\\.do|/notice/insertOK\\.do|/notice/update\\.do|/notice/updateOK\\.do|/notice/deleteOK\\.do|/faq/update\\.do|/faq/json/insertOK\\.do|/faq/json/updateOK\\.do|/faq/json/deleteOK\\.do|/faq/insert\\.do|/event/insert\\.do|/event/update\\.do|/event/json/insertOK\\.do|/event/json/updateOK\\.do|/event/json/deleteOK\\.do|/mail/selectAllAdmin\\.do|/member/json/selectAll\\.do|/member/json/upgradeOK\\.do|/mail/json/selectAll_admin\\.do|/mail/json/deleteOK\\.do";

		String sPath=request.getServletPath();
		log.info("preHandle-ServletPath...{}",sPath);
		boolean memberAllowed = Pattern.matches(memberAllowedPatterns, sPath);
		boolean managerAllowed = Pattern.matches(managerAllowedPatterns, sPath);
		// Session의 num값 할당
		Object num = session.getAttribute("num");
		log.info("preHandle()-isMemberNum...{}",num);
		// Session의 grade값 할당(0 : 일반, 1 관리자 , 2:점주)
		Object grade= session.getAttribute("grade");
		log.info("preHandle()-isMemberGrade...{}",grade);

		if (memberAllowed) {
		    if (num == null) {
		    	log.info("Not member");
		        response.sendRedirect("/hotplace/account/login.do");
		        return false;
		    }
		} else if(managerAllowed) {
			if(grade == null || !grade.equals(1)) {
				log.info("Not admin");
				response.sendRedirect("/hotplace/home");
				return false;
			}
		}
		return true;
	}

//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		log.info("postHandle()...");
//
//	}

}
