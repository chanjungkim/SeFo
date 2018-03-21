package service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lib.FileLib;
import lib.MyLog;
import repository.MemberDao;
import repository.ProfileDao;
import vo.ArticleVO;
import vo.FileVO;
import vo.FollowVO;
import vo.MemberVO;

@Component
public class ProfileService {
	private String TAG = this.getClass().getSimpleName();

	@Autowired
	private ProfileDao dao;

	public int getProfileContentCount(String id) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());
		return dao.selectContentCount(id);
	};

	public MemberVO getProfileInfo(String loginId, String id) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());
		// ÆÈ·Î¿ì ÆÈ·Î¿ö Á¤º¸ ³Ö±â
		// int followCount = dao.selectFollowCount(id);
		// int followeeCount = dao.selectFollowerCount(id);
		MemberVO vo = dao.selectProfileInfo(id);
		List<FollowVO> followList = dao.selectAllfollow(id);
		List<FollowVO> followerList = dao.selectAllfollower(id);

		List<FollowVO> follow = getFollowList(loginId);

		for (int i = 0; i < followList.size(); i++) {
			for (int j = 0; j < follow.size(); j++) {
				if (followList.get(i).getFollowee().equals(follow.get(j).getFollowee())) {
					followList.get(i).setCheckMyFollow(true);
				}
			}
		}

		for (int i = 0; i < followerList.size(); i++) {
			for (int j = 0; j < follow.size(); j++) {
				if (followerList.get(i).getId().equals(follow.get(j).getFollowee())) {
					followerList.get(i).setCheckMyFollow(true);
				}
			}
		}

		vo.setFollowList(followList);
		vo.setFollowerList(followerList);
		// vo.setFollow_count(followCount);
		// vo.setFollower_count(followeeCount);

		return vo;
	}

	public List<ArticleVO> getProfileFistArticleList(String id) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());
		return dao.selectFisrtArticleList(id);
	};

	public List<ArticleVO> getProfileMoreArticleList(String id, int articleNum) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());
		return dao.selectMoreArticleList(id, articleNum);
	};

	public boolean update(MemberVO member) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());

		int original = dao.update(member);
		if (original > 0) {
			return true;
		}
		return false;
	}

	public boolean getUpdatePw(String id, String pw) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());

		int original = dao.updatePw(id, pw);
		if (original > 0) {
			return true;
		} else {
			return false;
		}
	}

	public String follow(String id, String followee) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());

		int result = dao.insertFollow(id, followee);
		if (result == 1) {
			int followCount = dao.selectFollowCount(id);
			return String.valueOf(followCount);
		} else {
			return "0";
		}
	}

	public String unFollow(String id, String followee) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());

		int result = dao.deleteFollow(id, followee);
		if (result == 1) {
			int followCount = dao.selectFollowCount(id);
			return String.valueOf(followCount);
		} else {
			return "0";
		}
	}

	public List<FollowVO> getFollowList(String followee) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName());

		return dao.selectAllfollow(followee);
	}

	public List<FollowVO> getFollowerList(String id) {
		MyLog.d(TAG, "selectContentCount()");

		return dao.selectAllfollower(id);
	}

	public boolean deleteAll(String id, String pw) {
		MyLog.d(TAG, "deleteAll()");

		int result = dao.deleteMember(id, pw);
		int result2 = dao.deleteArticle(id);
		if (result > 0 && result2 > 0) {
			return true;
		} else {
			return false;
		}
	}

	public int insertArticlePhoto(FileVO file) {
		MyLog.d(TAG, "insertArticlePhoto()");

		int result = dao.insertArticlePhoto(file);
		return result;
	}

	public int changeProfilePhoto(MemberVO member, HttpServletRequest request) {
		MyLog.d(TAG, Thread.currentThread().getStackTrace()[1].getMethodName() + " = member: " + member.toString());

		int result = FileLib.getInstane().uploadProfileImageFile(dao, member, request);
		
		return result;
	}
}
