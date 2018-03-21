package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import lib.MyLog;
import service.ArticleService;
import vo.ArticleVO;
import vo.CommentVO;
import vo.ReactVO;

@Controller
public class ArticleController {
	private String TAG = this.getClass().getSimpleName();
	
	@Autowired
	private ArticleService service;

	@RequestMapping(value = "/writePost.do", method = RequestMethod.POST)
	@ResponseBody
	public ArticleVO writePost(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			ArticleVO article) throws UnsupportedEncodingException {
		MyLog.d(TAG, "writePost() = article: " + article.toString());

		String decodedData = URLDecoder.decode(article.getContent(), "UTF-8");
		article.setContent(decodedData);
		
		if (article.getFileList() != null) {
			for (MultipartFile m : article.getFileList()) {
				String filename = URLDecoder.decode(m.getOriginalFilename(), "UTF-8");
				MyLog.d(TAG, "tt:"+filename);
			}
		}
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
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		article = service.writeArticle(article, request);

		if (article.getPhotoList() != null && article.getPhotoList().size() > 0)
			service.updatePhotoCount(article.getArticle_num(), article.getPhotoList().size());
		return article;
	}

	@RequestMapping(value = "/writeComment.do", method = RequestMethod.POST)
	@ResponseBody
	public CommentVO writeComment(HttpSession session, HttpServletResponse response, String content, long article_num) {
		System.out.println(TAG+ ", writeComment()");
		
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

		CommentVO result = service.writeComment(comment);
		return result ;
	}

	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
	public void deleteComment(HttpSession session, HttpServletResponse response, long comment_num) {
		System.out.println(TAG + "deleteComment()");
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
		System.out.println(TAG + ", deleteComment()");

		boolean result = service.deleteNewComment(id, content);
		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/react.do", method = RequestMethod.POST)
	public void saveReact(HttpSession session, HttpServletResponse response, String id, long article_num,
			String expression) {
		System.out.println(TAG + ", saveReact()");

		if(service.selectReact(article_num, id)) {
			//�̹� ������ ���
			service.updateReact(article_num, id, expression);
		} else {
			//ó�� ������ ���
			service.saveReact(article_num,id, expression);
			service.countReact(article_num);
		}
	}

	@RequestMapping("/showReactList.do")
	public List<ReactVO> getReactList(long article_num) {
		System.out.println(TAG + ", getReactList()");

		return service.getReactList(article_num);
	}
	
	@RequestMapping("/article.do/{article_num}")
	public void getAnArticle(HttpSession session, HttpServletResponse response, @PathVariable long article_num) {
		System.out.println(TAG + ", getAnArticle()");

		ArticleVO article = service.getAnArticle(article_num);		
		PrintWriter writer = null;
 
		try {
			writer = response.getWriter();
			System.out.println("�޾ƿ� article ����:"+article);
			Gson gson = new Gson();
			writer.print(gson.toJson(article));    
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/remove-article.do", method = RequestMethod.POST)
	public void  removeArticle(HttpSession session, HttpServletResponse response, long article_num) throws IOException {
		System.out.println(TAG + ", removeArticle()");

		PrintWriter writer = null;
		writer = response.getWriter();
		if(service.removeArticle(article_num)) writer.print(true);
		else writer.print(false);
	}
	@RequestMapping("/leftArticle.do")
	public void getLeftArticleNum(HttpSession session, HttpServletResponse response, long article_num, String id) {
		System.out.println(TAG + ", getLeftAticleNum()");

		long leftArticleNum = service.getLeftArticleNum(article_num, id);
		
		PrintWriter writer = null;

		try {
			writer = response.getWriter();
			System.out.println("�޾ƿ� left ArticleNum����:"+leftArticleNum);
			Gson gson = new Gson();
			writer.print(gson.toJson(leftArticleNum));    
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/rightArticle.do")
	public void getRightArticleNum(HttpSession session, HttpServletResponse response, long article_num, String id) {
		System.out.println(TAG + ", getRightArticleNum()");

		long rightArticleNum = service.getRightArticleNum(article_num, id);	
		PrintWriter writer = null;

		try {
			writer = response.getWriter();
			System.out.println("�޾ƿ� rightArticleNum ����:"+rightArticleNum);
			Gson gson = new Gson();
			writer.print(gson.toJson(rightArticleNum));    
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}