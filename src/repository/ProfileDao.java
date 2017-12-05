package repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.ProfileMapper;
import vo.ArticleVO;
import vo.FollowVO;
import vo.MemberVO;

@Component
public class ProfileDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public int selectContentCount(String id) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectContentCount(id);
	};
	public MemberVO selectProfileInfo(String id) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectInfo(id);
	}
	public List<ArticleVO> selectFisrtArticleList(String id){
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectFisrtArticleList(id);
	};
	public List<ArticleVO> selectMoreArticleList(String id, int articleNum) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectMoreArticleList(id, articleNum);
	};
	public int update(MemberVO member){
		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.update(member);
	}
	public int updatePw(String id,String pw) {
		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.updatePw(id,pw);
	}
	
	public int insertFollow(String id, String followee){
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.insertFollow(id, followee);
	}
	public int deleteFollow(String id, String followee) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.deleteFollow(id, followee);
	}
	
	public int selectFollowCount(String id) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectTotalfollowCount(id);
	}
	public int selectFollowerCount(String followee) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectTotalfolloweeCount(followee);
	}
	
	public List<FollowVO> selectAllfollow(String id) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectAllfollow(id);
	}
	public List<FollowVO> selectAllfollower(String followee) {
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectAllfollower(followee);
	}
	

}
