package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.ArticleMapper;
import vo.ArticleVO;
import vo.CommentVO;
import vo.FileVO;

@Component
public class ArticleDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public int insertArticle(ArticleVO article) {
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		System.out.println("articleDAO 角青!"+article.getContent());
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
//		System.out.println("deleteComment Dao 角青"+comment_num);
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.deleteComment(comment_num);
		System.out.println(result);
		return result;
	}

	public int deleteNewComment(String id, String content) {
		System.out.println("deleteNewComment Dao 角青"+id+":"+content);
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.deleteNewComment(id, content);
		System.out.println(result);
		return result;
	}

	public int insertComment(CommentVO comment) {
		System.out.println("insertComment Dao 角青");
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.insertComment(comment);
		System.out.println(result);
		return result;
	}
	public int insertArticlePhoto(FileVO file) {
		System.out.println("insertArticlePhoto 角青");
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.insertArticlePhoto(file);
		System.out.println("insertArticlePhoto :" + result);
		return result;
	}
	public List<FileVO> selectArticlePhoto(long article_num) {
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectArticlePhoto(article_num);
	}
}