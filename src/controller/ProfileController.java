package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	@RequestMapping("/profile.do")
	public ModelAndView myprofilePage(HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		ModelAndView mv = new ModelAndView("profile");
		List<ArticleVO> articleList = profileService.getProfileFistArticleList(id);
		for(ArticleVO a : articleList) {
			List<FileVO> result = articleService.getArticlePhoto(a.getArticle_num());
			if (result != null && result.size() != 0) {
				a.setPhotoList(result);
			} 
		}
		int totalContentCnt = profileService.getProfileContentCount(id);
		MemberVO memberVO = profileService.getProfileInfo(id);
		mv.addObject("articleList", articleList);
		mv.addObject("totalContentCnt", totalContentCnt);
		mv.addObject("memberVO", memberVO);
		System.out.println(articleList.size());
		return mv;
	}
	
	/*
	 *	사진 정보 추가 요청 ajax 처리
	 **/
	@RequestMapping(value="profileMoreArticle.do", method=RequestMethod.POST)
	@ResponseBody
	public List<ArticleVO> getMoreArticle(HttpSession session, int articleNum){
		String id = (String) session.getAttribute("loginId");
		List<ArticleVO> articleList = profileService.getProfileMoreArticleList(id, articleNum);
		System.out.println("a size" + articleList.size());
		for(ArticleVO a : articleList) {
			List<FileVO> result = articleService.getArticlePhoto(a.getArticle_num());
			if (result != null && result.size() != 0) {
				a.setPhotoList(result);
			} 
		}
		return articleList;
	}
	
	
}
