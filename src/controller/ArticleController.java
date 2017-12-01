package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.ArticleService;
import vo.ArticleVO;
import vo.CommentVO;
import vo.ReactVO;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService service;

	@RequestMapping(value = "/writePost.do", method = RequestMethod.POST)
	@ResponseBody
	public ArticleVO writePost(HttpSession session, HttpServletRequest request, HttpServletResponse response,
		ArticleVO article) throws UnsupportedEncodingException {
		String id = (String) session.getAttribute("loginId");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String timeStr = sdf.format(new Date());
		Date now;
		if (article.getFileList() != null && article.getFileList().size() > 0) {
			article.getFileList().remove(article.getFileList().size() - 1);
		}
		try {
			//////////////////////////////////
			now = sdf.parse(timeStr);
			article.setId(id);
			article.setWrite_time(now);
			System.out.println(article.toString());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("writePost.do 실행");
		article = service.writeArticle(article, request);
		
		if (article.getPhotoList() != null && article.getPhotoList().size() > 0)
			service.updatePhotoCount(article.getArticle_num(), article.getPhotoList().size());
		return article;
	}

	@RequestMapping(value = "/writeComment.do", method = RequestMethod.POST)
	public void writeComment(HttpSession session, HttpServletResponse response, String content, long article_num) {
		System.out.println("writeComment 컨틀롤러 실행" + content);
		CommentVO comment = new CommentVO();

		String id = (String) session.getAttribute("loginId");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String timeStr = sdf.format(new Date());
		Date now;
		try {
			now = sdf.parse(timeStr);

			comment.setId(id);
			comment.setArticle_num(article_num);
			comment.setContent(content);
			comment.setWrite_time(now);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		boolean result = service.writeComment(comment);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
	public void deleteComment(HttpSession session, HttpServletResponse response, long comment_num) {
		System.out.println("deleteComment컨트롤러 실행: " + comment_num);
		boolean result = service.deleteComment(comment_num);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/deleteNewComment.do", method = RequestMethod.POST)
	public void deleteComment(HttpSession session, HttpServletResponse response, String id, String content) {
		System.out.println("deleteNewComment컨트롤러 실행: " + id + ":" + content);
		boolean result = service.deleteNewComment(id, content);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/react.do", method = RequestMethod.POST)
	public void saveReact(HttpSession session, HttpServletResponse response, String id, long article_num, String expression) {
		System.out.println("react 컨틀롤러 실행: "+article_num+" "+id+" "+expression);
		service.saveReact(article_num, id, expression);
	}
	
	@RequestMapping("/showReactList.do")
	public List<ReactVO> getReactList(long article_num){
		return service.getReactList(article_num);
	}
}