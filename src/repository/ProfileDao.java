package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lib.MyLog;
import repository.mapper.ArticleMapper;
import repository.mapper.ProfileMapper;
import vo.ArticleVO;
import vo.FileVO;
import vo.FollowVO;
import vo.MemberVO;

@Component
public class ProfileDao {
	private String TAG = this.getClass().getSimpleName();
	
	@Autowired
	private SqlSessionTemplate session;
	
	public int selectContentCount(String id) {
		MyLog.d(TAG, "selectContentCount()");
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectContentCount(id);
	};
	public MemberVO selectProfileInfo(String id) {
		MyLog.d(TAG, "selectProfileInfo()");
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectInfo(id);
	}
	public List<ArticleVO> selectFisrtArticleList(String id){
		MyLog.d(TAG, "selectFirstArticleList()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectFisrtArticleList(id);
	};
	public List<ArticleVO> selectMoreArticleList(String id, int articleNum) {
		MyLog.d(TAG, "selectMoreARticleList()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectMoreArticleList(id, articleNum);
	};
	public int update(MemberVO member){
		MyLog.d(TAG, "update()");

		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.update(member);
	}
	public int updatePw(String id,String pw) {
		MyLog.d(TAG, "updatePw()");

		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.updatePw(id,pw);
	}
	
	public int insertFollow(String id, String followee){
		MyLog.d(TAG, "insertFollow()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.insertFollow(id, followee);
	}
	public int deleteFollow(String id, String followee) {
		MyLog.d(TAG, "deleteFollow()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.deleteFollow(id, followee);
	}
	
	public int selectFollowCount(String id) {
		MyLog.d(TAG, "selectFollowCount()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectTotalfollowCount(id);
	}
	public int selectFollowerCount(String followee) {
		MyLog.d(TAG, "selectFollowerCount()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectTotalfolloweeCount(followee);
	}
	
	public List<FollowVO> selectAllfollow(String id) {
		MyLog.d(TAG, "selectAllfollow()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectAllfollow(id);
	}
	public List<FollowVO> selectAllfollower(String followee) {
		MyLog.d(TAG, "selectAllfollower()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectAllfollower(followee);
	}

	public int deleteMember(String id, String pw) {
		MyLog.d(TAG, "deleteMember()");

		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.deleteMember(id, pw);
	}
	public int deleteArticle(String id) {
		MyLog.d(TAG, "deleteArticle()");

		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.deleteArticle(id);
	}
	public int insertArticlePhoto(FileVO file) {
		MyLog.d(TAG, "insertArticlePhoto()");

		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.insertArticlePhoto(file);
		System.out.println("insertArticlePhoto :" + result);
		return result;
	}

	public int updateProfile(MemberVO member) {
		MyLog.d(TAG, "updateProfile()");

		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.updateProfile(member);
	}
}
