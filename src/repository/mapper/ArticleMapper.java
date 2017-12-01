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
	public int insertReact(long article_num, String id, String result);
	public List<ReactVO> selectAllReact(long article_num);
}
