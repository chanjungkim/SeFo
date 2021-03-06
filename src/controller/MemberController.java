package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
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

import lib.MyLog;
import service.ArticleService;
import service.MemberService;
import vo.ArticleVO;
import vo.FileVO;
import vo.MemberVO;

@Controller
public class MemberController {
	private String TAG = this.getClass().getSimpleName();
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private ArticleService articleService;
	
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public void login(String id, @RequestParam("password")String pwd, HttpSession session, HttpServletResponse response) {
		System.out.println(TAG + ", login()");

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
	public ModelAndView initMain(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {   	
		System.out.println(TAG + ", initMain()");

		String id = (String) session.getAttribute("loginId");
		Cookie cookie = new Cookie("sefoId", id);
		cookie.setComment("last id");
		cookie.setMaxAge(60*60*24*3);
		cookie.setValue(id);
		response.addCookie(cookie);
		
		ModelAndView mv = new ModelAndView();
		MemberVO member = service.initMain(id);
		List<ArticleVO> articleList = articleService.getArticleList(id);
		for(ArticleVO a : articleList) {
			List<FileVO> result = articleService.getArticlePhoto(a.getArticle_num());
			if (result != null && result.size() != 0) {
				a.setPhotoList(result);
			} 
		}
		for(int i=0; i<articleList.size(); i++) {
			for(int j=0; j<articleList.get(i).getReactList().size(); j++) {
				if(articleList.get(i).getReactList().get(j).getType_num() == 1)
					articleList.get(i).setReact_like(true);
				if(articleList.get(i).getReactList().get(j).getType_num() == 2)
					articleList.get(i).setReact_love(true);
				if(articleList.get(i).getReactList().get(j).getType_num() == 3)
					articleList.get(i).setReact_angly(true);
				if(articleList.get(i).getReactList().get(j).getType_num() == 4)
					articleList.get(i).setReact_sad(true);
			}
		}

		mv.addObject("articleList", articleList);
		mv.addObject("memberInfo", member);
		mv.setViewName("timeline");
		return mv;
 	}
	
	@RequestMapping("/loginPageMove.do")
	public String loginPageMove(HttpSession session) {
		System.out.println(TAG + ", loginPageMove()");

		return "login";
 	}
	
	@RequestMapping("/moveSignupForm.do")
	public String moveSignupForm() {
		System.out.println(TAG +", moveSignupForm()");

		return "signup_form";
	}
	
	@RequestMapping(value="/signup.do", method=RequestMethod.POST)
	public String join(HttpServletRequest request) {
		System.out.println(TAG + ", join()");

		MemberVO member = new MemberVO();
		try {
			request.setCharacterEncoding("UTF-8");

			member.setId(request.getParameter("id"));
			member.setName(request.getParameter("name"));
			member.setGender(request.getParameter("gender"));
			member.setPassword(request.getParameter("password"));
			member.setEmail(request.getParameter("email"));

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

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
		
		MyLog.d(TAG, member.toString());
		
		if(service.signup(member)) return "login";
		else return "join_fail";
	}
	
	@RequestMapping("/overlab-check.do")
	public void CheckOverlabID(String id, HttpServletResponse response) {
		System.out.println(TAG+", CheckOverlabID()");
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
		System.out.println(TAG + ", logout()");

        session.invalidate();
        return "login";
    }
	
    @RequestMapping("/search.do")
    public void searchUserId(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println(TAG + ", searchUserId()");

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