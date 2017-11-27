package repository.mapper;

import java.util.List;

import vo.ArticleVO;

public interface MyProfileMapper {
	public int selectMyContentCount(String id);
	public int selectMyFollowCount(String id); 
	public int selectMyFollowerCount(String id); 
	
	public List<ArticleVO> selectAllMyArticle(String id);
}
