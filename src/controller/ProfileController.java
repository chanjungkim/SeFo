package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import service.ProfileService;
import vo.ArticleVO;
import vo.MemberVO;

@Controller
public class ProfileController {
	
	@Autowired
	private ProfileService service;
	
	/*
	 * myProfile 첫 페이지
	 * */
	@RequestMapping("/myProfile.do")
	public ModelAndView myprofilePage(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		ModelAndView mv = new ModelAndView("profile");
		List<ArticleVO> articleVO = service.getProfileArticleList(id);
		int totalContentCnt = service.getProfileContentCount(id);
		MemberVO memberVO = service.getProfileInfo(id);
		mv.addObject("articleList", articleVO);
		mv.addObject("totalContentCnt", totalContentCnt);
		mv.addObject("memberVO", memberVO);
		return mv;
	}
}
