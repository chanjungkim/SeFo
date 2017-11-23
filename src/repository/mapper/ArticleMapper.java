package repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.ArticleVO;

public interface ArticleMapper {
	public int insertArticle(ArticleVO article);
	public List<ArticleVO> selectAllArticle(String id);	
}
