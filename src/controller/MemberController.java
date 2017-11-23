package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import service.ArticleService;
import service.MemberService;
import vo.ArticleVO;
import vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public void login(String id, @RequestParam("password")String pwd, HttpSession session, HttpServletResponse response) {
		if(service.login(id, pwd)) {
		    String personJson = "true";
		    try {
		    	session.setAttribute("loginId", id);
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
		String id = (String) session.getAttribute("loginId");
		ModelAndView mv = new ModelAndView();
		MemberVO member = service.initMain(id);
		List<ArticleVO> articleList = articleService.getArticleList(id);
		for(ArticleVO a : articleList) {
			System.out.print(a.getId()+" "+a.getWrite_time()+" "+a.getContent());
		}
		mv.addObject("articleList", articleList);
		mv.addObject("memberInfo", member);
		mv.setViewName("timeline");
		return mv;
 	}
	
	@RequestMapping("/loginPageMove.do")
	public String loginPageMove(HttpSession session) {
		return "login";
 	}
}
