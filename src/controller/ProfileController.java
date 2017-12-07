package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import service.ArticleService;
import service.ProfileService;
import vo.ArticleVO;
import vo.FileVO;
import vo.MemberVO;
import vo.SingleFileVO;

@Controller
public class ProfileController {
	
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private ArticleService articleService;
	
	/*
	 * myProfile 첫 페이지
	 * */
	@RequestMapping(value = "/profile.do/{userId}", method=RequestMethod.GET)
	public ModelAndView myprofilePage(HttpSession session, HttpServletRequest httpServletRequest, @PathVariable String userId) {
		ModelAndView mv = new ModelAndView("profile");
		List<ArticleVO> articleList = profileService.getProfileFistArticleList(userId);
		for(ArticleVO a : articleList) {
			List<FileVO> result = articleService.getArticlePhoto(a.getArticle_num());
			if (result != null && result.size() != 0) {
				a.setPhotoList(result);
				a.setCommentList(articleService.getCommentList(a.getArticle_num()));
			} 
		}
		int totalContentCnt = profileService.getProfileContentCount(userId);
		MemberVO memberVO = profileService.getProfileInfo(userId);
		mv.addObject("articleList", articleList);
		mv.addObject("totalContentCnt", totalContentCnt);
		mv.addObject("memberVO", memberVO);
		System.out.println("articlelist:" + articleList.size());
		return mv;
	}
	/*
	 *	사진 정보 추가 요청 ajax 처리
	 **/
	@RequestMapping("profileMoreArticle.do")
	@ResponseBody
	public List<ArticleVO> getMoreArticle(HttpSession session, String id, int articleNum){
		List<ArticleVO> articleList = profileService.getProfileMoreArticleList(id, articleNum);
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
	
	@RequestMapping(value="updatePw.do",method=RequestMethod.POST)
	public void updatePw(String id, String newPw,HttpSession session,HttpServletResponse response) {
		boolean result=profileService.getUpdatePw(id, newPw);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/follow.do", method=RequestMethod.POST)
	public @ResponseBody String follow (String follow_id, HttpSession session, HttpServletResponse response) {
		String id = (String) session.getAttribute("loginId");
		return profileService.follow(id, follow_id);
	}
	
	@RequestMapping(value="/unfollow.do", method=RequestMethod.POST)
	public @ResponseBody String unFollow (String follow_id, HttpSession session, HttpServletResponse response) {
		String id = (String) session.getAttribute("loginId");
		return profileService.unFollow(id, follow_id);
	}
	
	@RequestMapping(value="/deleteAll.do",method={RequestMethod.GET, RequestMethod.POST})
	public void deleteAll(String id, String deletePw,HttpSession session,HttpServletResponse response) {
		boolean result=profileService.deleteAll(id, deletePw);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/changeProfilePhoto.do", method= RequestMethod.POST)
	public void changePhofilePhoto (HttpSession sessoion, SingleFileVO singleFileVO)
			throws UnsupportedEncodingException {
		
//		String filename = URLDecoder.decode(m.getOriginalFilename(), "UTF-8");
		
//		System.out.println("tt:"+filename);
		System.out.println("changeProfilePhoto.do 실행");
		System.out.println(singleFileVO.getFile());
//		profileService.changeProfilePhoto(request, userId, file_1);
	}
}
