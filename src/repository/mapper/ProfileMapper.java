package repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.ArticleVO;
import vo.MemberVO;

public interface ProfileMapper {
	public int selectContentCount(String id);
	public MemberVO selectInfo(String id);
	public List<ArticleVO> selectFisrtArticleList(String id);
	public List<ArticleVO> selectMoreArticleList(@Param("id") String id, @Param("articleNum") int articleNum);
	public int update(MemberVO member);
	public int updatePw(@Param("id")String id,@Param("password")String pw);
	public int deleteMember(@Param("id")String id, @Param("password")String pw);
	public int deleteArticle(@Param("id")String id);
}
