package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.ArticleDao;
import vo.ArticleVO;

@Component
public class ArticleService {
	@Autowired
	private ArticleDao dao;
	
	public boolean writeArticle(ArticleVO article) {
		System.out.println("articleService ½ÇÇà!");
		int result = dao.insertArticle(article);
		System.out.println(result + " : "+article.getContent());
		
		if(result > 0) return true;
		else return false;
	}
	
	public List<ArticleVO> getArticleList(String id){
		return dao.selectAllArticle(id);	
	}
//	public MemberVO initMain(String email) {
//		return dao.initMain(email);
//	}
}
