package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import service.ArticleService;
import vo.ArticleVO;
import vo.CommentVO;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService service;

	@RequestMapping(value = "/writePost.do", method = RequestMethod.POST)
	public void login(HttpSession session, HttpServletResponse response, String content) {
		ArticleVO article = new ArticleVO();
		String id = (String) session.getAttribute("loginId");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
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
		System.out.println("writePost.do 실행");

		try {
			response.getWriter().print(service.writeArticle(article));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/writeComment.do", method = RequestMethod.POST)
	public void writeComment(HttpSession session, HttpServletResponse response, String content, long article_num) {
		System.out.println("writeComment 컨틀롤러 실행"+content);
		CommentVO comment = new CommentVO();

		String id = (String)session.getAttribute("loginId");
		
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
	
	@RequestMapping(value="/deleteComment.do", method= RequestMethod.POST)
	public void deleteComment(HttpSession session, HttpServletResponse response, long comment_num) {
		System.out.println("deleteComment컨트롤러 실행: "+comment_num);
		boolean result = service.deleteComment(comment_num);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/deleteNewComment.do", method= RequestMethod.POST)
	public void deleteComment(HttpSession session, HttpServletResponse response, String id, String content) {
		System.out.println("deleteNewComment컨트롤러 실행: "+id+":"+content);
		boolean result = service.deleteNewComment(id, content);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}