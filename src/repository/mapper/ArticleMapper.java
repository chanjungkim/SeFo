package repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.ArticleVO;
import vo.CommentVO;

public interface ArticleMapper {
	public int insertArticle(ArticleVO article);
	public List<ArticleVO> selectAllArticle(String id);
	public List<CommentVO> selectAllComment(long article_num);
	public int deleteComment(long comment_num);
	public int deleteNewComment(@Param("id")String id, @Param("Content")String content);
	public int insertComment(CommentVO comment);
}