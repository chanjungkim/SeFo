package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

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
//		for(ArticleVO a : articleList) {
//			System.out.print(a.getId()+" "+a.getWrite_time()+" "+a.getContent());
//		}
		mv.addObject("articleList", articleList);
		mv.addObject("memberInfo", member);
		mv.setViewName("timeline");
		return mv;
 	}
	
	@RequestMapping("/loginPageMove.do")
	public String loginPageMove(HttpSession session) {
		return "login";
 	}
	
	@RequestMapping("/moveSignupForm.do")
	public String moveSignupForm() {
		return "signup_form";
	}
	
	@RequestMapping("/signup.do")
	public String join(HttpServletRequest request) {
		MemberVO member = new MemberVO();
		member.setId(request.getParameter("id"));
		member.setPassword(request.getParameter("password"));
		member.setName(request.getParameter("name"));
		member.setEmail("email");
		String from = request.getParameter("birth_year")+"-"+request.getParameter("birth_month")+"-"+request.getParameter("birth_day");
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date to = transFormat.parse(from);
			member.setBirth(to);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String phone = request.getParameter("phone_1")+"-"+request.getParameter("phone_2")+"-"+request.getParameter("phone_3");
		member.setPhone(phone);
		member.setGender(request.getParameter("gender").charAt(0));
		if(service.signup(member)) return "login";
		else return "join_fail";
	}
	
	@RequestMapping("/overlab-check.do")
	public void CheckOverlabID(String id, HttpServletResponse response) {
		System.out.println(id);
		if(service.checkOverlabID(id)) {
		    try {
				response.getWriter().print("true");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
		    try {
				response.getWriter().print("false");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
    @RequestMapping("/logout.do")
    public String logout(HttpSession session) {
        session.invalidate();
        return "login";
    }
	
    @RequestMapping("/search.do")
    public void searchUserId(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
    	request.setCharacterEncoding("utf8");
    	String searchWord = request.getParameter("searchWord");
    	
    	PrintWriter writer = response.getWriter();
    	
    	System.out.println("search.do 실행됨:"+searchWord);
    	
    	List<String> userIdList = service.searchId(searchWord);
    	
    	System.out.println("받아온 사이즈:"+userIdList.size());
    	for(String str : userIdList) {
    		System.out.println(str);
    	}
    	
    	Gson gson = new Gson();
    	writer.print(gson.toJson(userIdList));    	
    }
}