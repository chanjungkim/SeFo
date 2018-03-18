package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

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
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectContentCount(id);
	};
	public MemberVO selectProfileInfo(String id) {
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectInfo(id);
	}
	public List<ArticleVO> selectFisrtArticleList(String id){
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectFisrtArticleList(id);
	};
	public List<ArticleVO> selectMoreArticleList(String id, int articleNum) {
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectMoreArticleList(id, articleNum);
	};
	public int update(MemberVO member){
		System.out.println(TAG);
		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.update(member);
	}
	public int updatePw(String id,String pw) {
		System.out.println(TAG);
		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.updatePw(id,pw);
	}
	
	public int insertFollow(String id, String followee){
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.insertFollow(id, followee);
	}
	public int deleteFollow(String id, String followee) {
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.deleteFollow(id, followee);
	}
	
	public int selectFollowCount(String id) {
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectTotalfollowCount(id);
	}
	public int selectFollowerCount(String followee) {
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectTotalfolloweeCount(followee);
	}
	
	public List<FollowVO> selectAllfollow(String id) {
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectAllfollow(id);
	}
	public List<FollowVO> selectAllfollower(String followee) {
		System.out.println(TAG);
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectAllfollower(followee);
	}

	public int deleteMember(String id, String pw) {
		System.out.println(TAG);
		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.deleteMember(id, pw);
	}
	public int deleteArticle(String id) {
		System.out.println(TAG);
		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.deleteArticle(id);
	}
	public int insertArticlePhoto(FileVO file) {
		System.out.println(TAG);
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		int result = mapper.insertArticlePhoto(file);
		System.out.println("insertArticlePhoto :" + result);
		return result;
	}

	public int updateProfilePhoto(String userId, String photo_path) {
		System.out.println(TAG);
		ProfileMapper mapper=session.getMapper(ProfileMapper.class);
		return mapper.updateProfilePhoto(userId, photo_path);
	}
}
