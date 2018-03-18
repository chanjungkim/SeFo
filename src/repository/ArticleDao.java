package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.ArticleMapper;
import vo.ArticleVO;
import vo.CommentVO;
import vo.FileVO;
import vo.ReactVO;

@Component
public class ArticleDao {
	private String TAG = this.getClass().getSimpleName();

	@Autowired
	private SqlSessionTemplate session;

	public int insertArticle(ArticleVO article) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		System.out.println("articleDAO 角青!" + article.getContent());
		return mapper.insertArticle(article);
	}

	public List<ArticleVO> selectAllArticle(String id) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectAllArticle(id);
	}

	public List<CommentVO> selectAllComment(long article_num) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectAllComment(article_num);
	}

	public int deleteComment(long comment_num) {
		System.out.println(TAG);

		// System.out.println("deleteComment Dao 角青"+comment_num);
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.deleteComment(comment_num);
		System.out.println(result);
		return result;
	}

	public int deleteNewComment(String id, String content) {
		System.out.println(TAG);

		System.out.println("deleteNewComment Dao 角青" + id + ":" + content);
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.deleteNewComment(id, content);
		System.out.println(result);
		return result;
	}

	public int insertComment(CommentVO comment) {
		System.out.println(TAG);

		System.out.println("insertComment Dao 角青");
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.insertComment(comment);
		System.out.println(result);
		return result;
	}

	public int insertArticlePhoto(FileVO file) {
		System.out.println(TAG);

		System.out.println("insertArticlePhoto 角青");
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.insertArticlePhoto(file);
		System.out.println("insertArticlePhoto :" + result);
		return result;
	}

	public List<FileVO> selectArticlePhoto(long article_num) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectArticlePhoto(article_num);
	}
	public int updatePhotoCount(long article_num, int count) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.updatePhotoCount(count, article_num);
	}

	public int selectReact(long article_num, String id) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectReact(article_num, id);
	}
	
	public int countReact(long article_num) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.countReact(article_num);
	}
	
	public int updateReact(long article_num, String id, String expression) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.updateReact(article_num, id, expression);
	}

	public int insertReact(long article_num, String id, String expression) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.insertReact(article_num, id, expression);
	}

	public List<ReactVO> selectAllReact(long article_num) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectAllReact(article_num);
	}

	public ArticleVO selectArticle(long article_num) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectArticle(article_num);
	}
	public CommentVO selectLastComment(long article_num, String id) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectLastComment(article_num, id);
	}
	public int removeArticle(long article_num) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.removeArticle(article_num);
	}
	public long selectLeftArticleNum(long article_num, String id) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectLeftArticleNum(article_num, id);
	}
	
	public long selectRightArticleNum(long article_num, String id) {
		System.out.println(TAG);

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectRightArticleNum(article_num, id);
	}
} 