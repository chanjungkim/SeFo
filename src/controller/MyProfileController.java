package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import service.MyProfileService;
import vo.ArticleVO;

@Controller
public class MyProfileController {
	
	@Autowired
	private MyProfileService service;
	
	/*
	 * myProfile 첫 페이지
	 * */
	@RequestMapping("/myProfile.do")
	public ModelAndView myprofilePage(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		ModelAndView mv = new ModelAndView("my_profile");
		List<ArticleVO> articleVO = service.getAllMyArticle(id);
		int followCnt = service.getMyFollowCount(id);
		int followerCnt = service.getMyFollowerCount(id);
		int totalContentCnt = service.getMyContentCount(id);
		
		mv.addObject("articleVO", articleVO);
		mv.addObject("followCnt", followCnt);
		mv.addObject("followerCnt",followerCnt );
		mv.addObject("totalContentCnt", totalContentCnt);
		
		return mv;
	}
}
