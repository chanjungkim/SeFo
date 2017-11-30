package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import service.ArticleService;
import service.ProfileService;
import vo.ArticleVO;
import vo.FileVO;
import vo.MemberVO;

@Controller
public class ProfileController {
	
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private ArticleService articleService;
	
	/*
	 * myProfile 첫 페이지
	 * */
	@RequestMapping("/myProfile.do")
	public ModelAndView myprofilePage(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		ModelAndView mv = new ModelAndView("profile");
		List<ArticleVO> articleVO = profileService.getProfileArticleList(id);
		for(ArticleVO a : articleVO) {
			List<FileVO> result = articleService.getArticlePhoto(a.getArticle_num());
			if (result != null && result.size() != 0) {
				System.out.println(result.get(0).getFile_origiName());
				a.setPhotoList(result);
			} 
		}
		int totalContentCnt = profileService.getProfileContentCount(id);
		MemberVO memberVO = profileService.getProfileInfo(id);
		mv.addObject("articleList", articleVO);
		mv.addObject("totalContentCnt", totalContentCnt);
		mv.addObject("memberVO", memberVO);
		return mv;
	}
}
