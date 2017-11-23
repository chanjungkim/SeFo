package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
		String id = (String) session.getAttribute("loginId");
		
		SimpleDateFormat sdf = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		String timeStr = sdf.format(new Date());
		Date now;
		try {
			now = sdf.parse(timeStr);
			
			article.setId(id);
			article.setContent(content);
			article.setWrite_time(now);
			article.setPhoto_path(""); // modify...
			
			System.out.println(article.toString());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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
