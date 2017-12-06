package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
	 * myProfile ù ������
	 * */
	@RequestMapping(value = "/profile.do/{userId}", method= {RequestMethod.GET,RequestMethod.POST})
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
		mv.addObject("accessAut", "self");
		System.out.println(articleList.size());
		return mv;
	}
	
//	@RequestMapping(value = "/other_profile.do", method=RequestMethod.GET)
//	public ModelAndView otherProfilePage(HttpServletRequest httpServletRequest) {
//		String id = httpServletRequest.getParameter("srch-term");
//		ModelAndView mv = new ModelAndView("profile");
//		List<ArticleVO> articleList = profileService.getProfileFistArticleList(id);
//		for(ArticleVO a : articleList) {
//			List<FileVO> result = articleService.getArticlePhoto(a.getArticle_num());
//			if (result != null && result.size() != 0) {
//				a.setPhotoList(result);
//			} 
//		}
//		int totalContentCnt = profileService.getProfileContentCount(id);
//		MemberVO memberVO = profileService.getProfileInfo(id);
//		mv.addObject("articleList", articleList);
//		mv.addObject("totalContentCnt", totalContentCnt);
//		mv.addObject("memberVO", memberVO);
//		mv.addObject("accessAut", "other");
//		return mv;
//	}
	
	/*
	 *	���� ���� �߰� ��û ajax ó��
	 **/
	@RequestMapping(value="profileMoreArticle.do", method=RequestMethod.POST)
	@ResponseBody
	public List<ArticleVO> getMoreArticle(HttpSession session, int articleNum){
		String id = (String) session.getAttribute("loginId");
		List<ArticleVO> articleList = profileService.getProfileMoreArticleList(id, articleNum);
		System.out.println("profileMoreArticle : " + articleList);
		for(ArticleVO a : articleList) {
			List<FileVO> result = articleService.getArticlePhoto(a.getArticle_num());
			if (result != null && result.size() != 0) {
				a.setPhotoList(result);
			} 
		}
		return articleList;
	}
	
	@RequestMapping(value="myPage.do",method= {RequestMethod.GET,RequestMethod.POST})
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
			mv.setViewName("updateProfile");
		}else {
			mv.setViewName("myPage");
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
	@RequestMapping(value="deleteAll.do",method={RequestMethod.GET, RequestMethod.POST})
	public void deleteAll(String id, String deletePw,HttpSession session,HttpServletResponse response) {
		boolean result=profileService.deleteAll(id, deletePw);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping(value="profilePhoto.do",method=RequestMethod.POST)
	public void insertPhoto(HttpSession session, HttpServletResponse response,HttpServletRequest request) {
		ArticleVO article = new ArticleVO();
		String path="assets/img/profile_pictures/";
		FileVO file=new FileVO();
		String uploadPath = request.getServletContext().getRealPath(path);
		File dir = new File(uploadPath + "/" + article.getArticle_num());


		if (!dir.exists()) {
			dir.mkdir(); // �ش� ���丮 ������ ����
		}

		// ���ε� ���� ������ �Ʒ� �̸��� ���Ϸ� ����
		// �������� �����Ű��
		String savedName = new Random().nextInt(100) + file.getMemImg().getOriginalFilename();

		File savedFile = new File(uploadPath + "/" + savedName);

		// ���޹��� ���� ���ε� �۾�.
		try {
			file.getMemImg().transferTo(savedFile);

			// �� ������ �����ͺ��̽��� ���ε� ���� ���
			file.setArticle_num(article.getArticle_num());
			file.setFile_name(savedName);
			file.setFile_origiName(path + article.getArticle_num() + "/" + savedName);
			file.setFile_path(savedFile.getAbsolutePath());
			// DB�� ���ε� ���� ���
			profileService.insertArticlePhoto(file);
			// ���� ���� �ϳ��� �ֱ�
			article.getPhotoList().add(file);
			System.out.println("---------------");
			System.out.println("���ε� �Ϸ�");
			System.out.println("�����̸�:" + file.getMemImg().getOriginalFilename());
			System.out.println("fileVO origiName:" + file.getFile_origiName());
			System.out.println("����� ���:" + savedFile.getAbsolutePath());
			System.out.println("---------------");
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
//		// ������ ���� ��� ����
//		if (!dir.exists()) {
//			dir.mkdirs();
//		}
//		if (article.getFileList() != null && article.getFileList().size() != 0) {
//			//���� ����Ʈ
//			article.setPhotoList(new ArrayList<FileVO>());
//			article.setPhoto_count(article.getFileList().size());
//			MultipartFile m = (MultipartFile) article.getFileList();
//				FileVO fileVO = new FileVO();
//				String savedName = new Random().nextInt(1000000) + m.getOriginalFilename();
//				File savedFile = new File(dir.getAbsolutePath() + "/" + savedName);
//				try {
//					m.transferTo(savedFile);
//					fileVO.setArticle_num(article.getArticle_num());
//					fileVO.setFile_name(savedName);
//					fileVO.setFile_origiName(path + article.getArticle_num() + "/" + savedName);
//					fileVO.setFile_path(savedFile.getAbsolutePath());
//					// DB�� ���ε� ���� ���
//					profileService.insertArticlePhoto(fileVO);
//					// ���� ���� �ϳ��� �ֱ�
//					article.getPhotoList().add(fileVO);
//					System.out.println("---------------");
//					System.out.println("���ε� �Ϸ�");
//					System.out.println("�����̸�:" + m.getOriginalFilename());
//					System.out.println("fileVO origiName:" + fileVO.getFile_origiName());
//					System.out.println("����� ���:" + savedFile.getAbsolutePath());
//					System.out.println("---------------");
//				} catch (IllegalStateException | IOException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//			}
			// article�� fileVo �ֱ�
		}
	}
	
		
