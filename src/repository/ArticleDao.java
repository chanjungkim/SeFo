package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.ArticleMapper;
import vo.ArticleVO;
import vo.CommentVO;

@Component
public class ArticleDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public int insertArticle(ArticleVO article) {
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		System.out.println("articleDAO ����!"+article.getContent());
		return mapper.insertArticle(article);
	}
	
	public List<ArticleVO> selectAllArticle(String id){
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectAllArticle(id);
	}
	
	public List<CommentVO> selectAllComment(long article_num){
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectAllComment(article_num);
	}

	public int deleteComment(long comment_num) {
//		System.out.println("deleteComment Dao ����"+comment_num);
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.deleteComment(comment_num);
		System.out.println(result);
		return result;
	}

	public int deleteNewComment(String id, String content) {
		System.out.println("deleteNewComment Dao ����"+id+":"+content);
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.deleteNewComment(id, content);
		System.out.println(result);
		return result;
	}

	public int insertComment(CommentVO comment) {
		System.out.println("insertComment Dao ����");
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.insertComment(comment);
		System.out.println(result);
		return result;
	}
}