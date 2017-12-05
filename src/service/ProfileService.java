package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.ProfileDao;
import repository.mapper.ProfileMapper;
import vo.ArticleVO;
import vo.FollowVO;
import vo.MemberVO;

@Component
public class ProfileService {
	
	@Autowired
	private ProfileDao dao;
	
	public int getProfileContentCount(String id) {
		return dao.selectContentCount(id);
	};
	public MemberVO getProfileInfo(String id) {
		//ÆÈ·Î¿ì ÆÈ·Î¿ö Á¤º¸ ³Ö±â
//		int followCount = dao.selectFollowCount(id);
//		int followeeCount = dao.selectFollowerCount(id);
		MemberVO vo = dao.selectProfileInfo(id);
		vo.setFollowList(dao.selectAllfollow(id));
		vo.setFollowerList(dao.selectAllfollower(id));
//		vo.setFollow_count(followCount);
//		vo.setFollower_count(followeeCount);
		
		return vo;
	}
	public List<ArticleVO> getProfileFistArticleList(String id){
		return dao.selectFisrtArticleList(id);
	};
	
	public List<ArticleVO> getProfileMoreArticleList(String id, int articleNum) {
		return dao.selectMoreArticleList(id, articleNum);
	};
	public boolean update(MemberVO member) {
		int original = dao.update(member);
		if(original > 0) {
			return true;
		}
		return false;
	}
	public boolean getUpdatePw(String id,String pw) {
		int original =dao.updatePw(id, pw);
		if(original>0) {
			return true;
		}else {
			return false;
		}
	}
	public boolean follow(String id, String followee){
		int result = dao.insertFollow(id, followee);
		if (result == 1) {
			return true;
		} else {
			return false;
		}
	}
	public boolean unFollow(String id, String followee) {
		int result = dao.deleteFollow(id, followee);
		if (result == 1) {
			return true;
		} else {
			return false;
		}
	}
	public List<FollowVO> getFollowList(String followee){
		return dao.selectAllfollow(followee);
	}
	public List<FollowVO> getFollowerList(String id) {
		return dao.selectAllfollower(id);
	}
	public boolean deleteAll(String id, String pw) {
		int result=dao.deleteMember(id, pw);
		int result2=dao.deleteArticle(id);
		if(result>0&&result2>0) {
			return true;
		}
		else {
			return false;
		}
	}
}
