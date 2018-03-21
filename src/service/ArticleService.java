package service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lib.FileLib;
import lib.MyLog;
import repository.ArticleDao;
import repository.MemberDao;
import vo.ArticleVO;
import vo.CommentVO;
import vo.FileVO;
import vo.ReactVO;

@Component
public class ArticleService {
	private String TAG = this.getClass().getSimpleName();

	@Autowired
	private ArticleDao dao;

	@Autowired
	private MemberDao memberDao;
	
	public ArticleVO writeArticle(ArticleVO article, HttpServletRequest req) throws UnsupportedEncodingException {
		MyLog.d(TAG, "writeArticle()");

		FileLib.getInstane().uploadArticleImageFiles(dao, memberDao, article, req);

		article.setReactList(getReactList(article.getArticle_num()));
		article.setPhoto_path(memberDao.initMain(article.getId()).getPhoto_path());
		return article;
	}

	public List<ArticleVO> getArticleList(String id) {
		MyLog.d(TAG, "getArticleList()");
		List<ArticleVO> articleList = dao.selectAllArticle(id);
		
		for (ArticleVO article : articleList) {
			//TODO 트랜잭션 처리
			article.setCommentList(dao.selectAllComment(article.getArticle_num()));
			article.setReactList(dao.selectAllReact(article.getArticle_num()));
			// System.out.println(article.getArticle_num()+"/"+article.getCommentList().size());
			article.toString();
		}
		return articleList;
	}

	public List<CommentVO> getCommentList(long article_num) {
		MyLog.d(TAG, "getCommentList()");
		return dao.selectAllComment(article_num);
	}

	public boolean deleteComment(long comment_num) {
		MyLog.d(TAG, "deleteComment()");
		int result = dao.deleteComment(comment_num);
		System.out.println(result);
		if (result > 0)
			return true;
		else
			return false;
	}

	public boolean deleteNewComment(String id, String content) {
		MyLog.d(TAG, "deleteNewComment()");
		int result = dao.deleteNewComment(id, content);
		System.out.println(result);
		if (result > 0)
			return true;
		else
			return false;
	}

	public CommentVO writeComment(CommentVO comment) {
		MyLog.d(TAG, "writeComment()");
		int result = dao.insertComment(comment);
		if (result > 0)
			return dao.selectLastComment(comment.getArticle_num(), comment.getId());
		else
			return null;
	}

	public List<FileVO> getArticlePhoto(long article_num) {
		MyLog.d(TAG, "getARticlePhoto()");
		return dao.selectArticlePhoto(article_num);
	}
	
	public boolean updatePhotoCount(long article_num, int count) {
		MyLog.d(TAG, "updatePhotoCount()");
		int result = dao.updatePhotoCount(article_num, count);
		if (result > 0)
			return true;
		else
			return false;
	}

	public boolean selectReact(long article_num, String id) {
		MyLog.d(TAG, "selectReact()");
		int result = dao.selectReact(article_num, id);
		if(result > 0) return true;
		else return false;
	}
	
	public boolean countReact(long article_num) {
		MyLog.d(TAG, "countReact()");

		int result = dao.countReact(article_num);
		if( result > 0) return true;
		else return false;
	}

	public boolean saveReact(long article_num, String id, String expression) {
		MyLog.d(TAG, "saveReact()");

		int result = dao.insertReact(article_num, id, expression);
		if( result > 0) return true;
		else return false;
	}

	public List<ReactVO> getReactList(long article_num) {
		MyLog.d(TAG, "getReactList()");

		return dao.selectAllReact(article_num);
	}

	public boolean updateReact(long article_num, String id, String expression) {
		MyLog.d(TAG, "updateReact()");

		int result = dao.updateReact(article_num, id, expression);
		if(result > 0) return true;
		else return false;
	}
	
	public ArticleVO getAnArticle(long article_num) {
		MyLog.d(TAG, "getAnArticle()");

		ArticleVO article = dao.selectArticle(article_num);
		article.setCommentList(dao.selectAllComment(article_num));
		for (CommentVO v : article.getCommentList()) {
			v.setPhoto_path(memberDao.initMain(v.getId()).getPhoto_path());
		}
		article.setReactList(dao.selectAllReact(article_num));
		article.setPhotoList(dao.selectArticlePhoto(article_num));
		
		// System.out.println(article.getArticle_num()+"/"+article.getCommentList().size());
		article.toString();
		return article;
	}
	
	public boolean removeArticle(long article_num) {
		MyLog.d(TAG, "removeArticle()");

		int result = dao.removeArticle(article_num);
		System.out.println("result="+result);
		if(result > 0) return true;
		else return false;
	}

	public Long getLeftArticleNum(long article_num, String id) {
		MyLog.d(TAG, "getLeftArticleNum()");

		return dao.selectLeftArticleNum(article_num, id);
	}
	
	public Long getRightArticleNum(long article_num, String id) {
		MyLog.d(TAG, "getRightArticleNum()");

		return dao.selectRightArticleNum(article_num, id);
	}
}