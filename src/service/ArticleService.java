package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.ArticleDao;
import vo.ArticleVO;
import vo.CommentVO;

@Component
public class ArticleService {
	@Autowired
	private ArticleDao dao;
	
	public boolean writeArticle(ArticleVO article) {
		System.out.println("articleService 실행!");
		int result = dao.insertArticle(article);
		System.out.println(result + " : "+article.getContent());
		
		if(result > 0) return true;
		else return false;
	}
	
	public List<ArticleVO> getArticleList(String id){
		List<ArticleVO> articleList = dao.selectAllArticle(id);
		for(ArticleVO article: articleList) {
			article.setCommentList(dao.selectAllComment(article.getArticle_num()));
//			System.out.println(article.getArticle_num()+"/"+article.getCommentList().size());
		}
		return articleList;	
	}
	
	public List<CommentVO> getCommentList(long article_num){
		return dao.selectAllComment(article_num);
	}

	public boolean deleteComment(long comment_num) {
		System.out.println("deleteComment서비스 실행"+comment_num);
		int result = dao.deleteComment(comment_num);
		System.out.println(result);
		if(result > 0) return true;
		else return false;
	}

	public boolean deleteNewComment(String id, String content) {
		System.out.println("deleteNewComment서비스 실행"+id+":"+content);
		int result = dao.deleteNewComment(id, content);
		System.out.println(result);
		if(result > 0) return true;
		else return false;
	}

	public boolean writeComment(CommentVO comment) {
		System.out.println("writeComment 서비스 실행"+comment.getId()+":"+comment.getContent());
		int result = dao.insertComment(comment);
		if(result > 0) return true;
		else return false;
	}
}
