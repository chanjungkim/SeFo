package controller;

import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
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
				a.setCommentList(articleService.getCommentList(a.getArticle_num()));
			} 
		}
		int totalContentCnt = profileService.getProfileContentCount(id);
		MemberVO memberVO = profileService.getProfileInfo(id);
		mv.addObject("articleList", articleList);
		mv.addObject("totalContentCnt", totalContentCnt);
		mv.addObject("memberVO", memberVO);
		mv.addObject("accessAut", "self");
		System.out.println(articleList.size());
		return mv;
	}
	
	@RequestMapping(value = "/other_profile.do", method=RequestMethod.GET)
	public ModelAndView otherProfilePage(HttpServletRequest httpServletRequest) {
		String id = httpServletRequest.getParameter("srch-term");
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
		mv.addObject("accessAut", "other");
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
	@RequestMapping("myPage.do")
	public ModelAndView mypage(MemberVO member,HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		ModelAndView mv = new ModelAndView();
		member = profileService.getProfileInfo(loginId);
		mv.addObject("original", member);
		mv.setViewName("myPage");
		return mv;
	}
	@RequestMapping(value="updateProfile.do",method=RequestMethod.POST)
	public ModelAndView update(MemberVO member, HttpSession session) {
		String loginId=(String)session.getAttribute("loginId");
		boolean result=profileService.update(member);
		ModelAndView mv=new ModelAndView();
		
		if(result) {
			mv.addObject("original",member);
			mv.setViewName("profile");
			System.out.println("디비 확인:"+member);
		}else {
			 mv.setViewName("updateProfile");
		}
		return mv;
	}
}
