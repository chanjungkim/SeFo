package repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.ArticleVO;
import vo.FollowVO;
import vo.MemberVO;

public interface ProfileMapper {
	public int selectContentCount(String id);
	public MemberVO selectInfo(String id);
	public List<ArticleVO> selectFisrtArticleList(String id);
	public List<ArticleVO> selectMoreArticleList(@Param("id") String id, @Param("articleNum") int articleNum);
	public int update(MemberVO member);
	public int updatePw(@Param("id")String id,@Param("password")String pw);
	public int insertFollow(@Param("id") String id, @Param("followee") String followee);
	public int deleteFollow(@Param("id") String id, @Param("followee") String followee);
	public int selectTotalfollowCount(String id);
	public int selectTotalfolloweeCount(String followee);
	public List<FollowVO> selectAllfollow(String id);
	public List<FollowVO> selectAllfollower(String id);
}
