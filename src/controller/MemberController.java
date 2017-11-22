package controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import service.MemberService;
import vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public void login(String email, @RequestParam("password")String pwd, HttpSession session, HttpServletResponse response) {
		if(service.login(email, pwd)) {
		    String personJson = "true";
		    try {
		    	session.setAttribute("loginEmail", email);
				response.getWriter().print(personJson);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			String personJson = "false";
		    try {
				response.getWriter().print(personJson);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
 	}
	
	@RequestMapping("/initMain.do")
	public ModelAndView initMain(HttpSession session) {
		String email = (String) session.getAttribute("loginEmail");
		ModelAndView mv = new ModelAndView();
		MemberVO member = service.initMain(email);
		mv.addObject("memberInfo", member);
		mv.setViewName("main");
		return mv;
 	}
	
	@RequestMapping("/loginPageMove.do")
	public String loginPageMove(HttpSession session) {
		return "login";
 	}
}
