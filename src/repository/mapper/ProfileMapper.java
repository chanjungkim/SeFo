package repository.mapper;

import java.util.List;

import vo.ArticleVO;
import vo.MemberVO;

public interface ProfileMapper {
	public int selectContentCount(String id);
	public List<ArticleVO> selectArticleList(String id);
	public MemberVO selectInfo(String id);
}
