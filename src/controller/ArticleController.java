package controller;

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
	public String writePost(HttpSession session) {
		ArticleVO article = (ArticleVO) session.getAttribute("article");
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("memberInfo", member);
//		mv.setViewName("main");
		
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
