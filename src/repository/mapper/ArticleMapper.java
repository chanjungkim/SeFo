package repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.ArticleVO;
import vo.CommentVO;
import vo.FileVO;
import vo.ReactVO;

public interface ArticleMapper {
	public int insertArticle(ArticleVO article);
	public List<ArticleVO> selectAllArticle(String id);
	public List<CommentVO> selectAllComment(long article_num);
	public int deleteComment(long comment_num);
	public int deleteNewComment(@Param("id")String id, @Param("Content")String content);
	public int insertComment(CommentVO comment);
	public int insertArticlePhoto(FileVO vo);
	public List<FileVO> selectArticlePhoto(long article_num);
	public int updatePhotoCount(@Param("count")int count, @Param("article_num") long article_num);
	public int selectReact(@Param("article_num") long article_num, @Param("id") String id);
	public int countReact(@Param("article_num") long article_num);
	public int updateReact(@Param("article_num") long article_num, @Param("id") String id, @Param("expression") String expression);
	public int insertReact(@Param("article_num") long article_num, @Param("id") String id, @Param("expression") String expression);
	public List<ReactVO> selectAllReact(long article_num);
	public ArticleVO selectArticle(long article_num);
}
