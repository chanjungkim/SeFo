package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import service.ArticleService;
import vo.ArticleVO;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService service;
	
	@RequestMapping("/writePost.do")
	public String writePost(HttpSession session, String content) {
		ArticleVO article = new ArticleVO();
		String id = (String) session.getAttribute("id");
		
//		
//		Date now = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss").parse();
//				
//		article.setId(id);
//		article.setContent(content);
//		article.setWrite_time(now);
		
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("memberInfo", member);
//		mv.setViewName("main");

//		System.out.println(now);
		System.out.println("22writePost.do ½ÇÇà");
		
		if(service.writeArticle(article)) {
			return "post_success";			
		}else {
			return "post_fail";
		}
 	}
	
//	@RequestMapping("/loginPageMove.do")
//	public String loginPageMove(HttpSession session) {
//		return "login";
// 	}
}
