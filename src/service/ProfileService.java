package service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import repository.ProfileDao;
import repository.mapper.ProfileMapper;
import vo.ArticleVO;
import vo.FileVO;
import vo.FollowVO;
import vo.MemberVO;

@Component
public class ProfileService {
	
	@Autowired
	private ProfileDao dao;
	
	public int getProfileContentCount(String id) {
		return dao.selectContentCount(id);
	};
	public MemberVO getProfileInfo(String loginId,  String id) {
		//팔로우 팔로워 정보 넣기
//		int followCount = dao.selectFollowCount(id);
//		int followeeCount = dao.selectFollowerCount(id);
		MemberVO vo = dao.selectProfileInfo(id);
		List<FollowVO> followList = dao.selectAllfollow(id);
		List<FollowVO> followerList = dao.selectAllfollower(id);
		
		List<FollowVO> follow = getFollowList(loginId);
		
		for(int i=0; i<followList.size(); i++) {
			for(int j=0; j<follow.size(); j++) {
				if(followList.get(i).getFollowee().equals(follow.get(j).getFollowee())) {
					followList.get(i).setCheckMyFollow(true);
				}
			}
		}
		
		for(int i=0; i<followerList.size(); i++) {
			for(int j=0; j<follow.size(); j++) {
				if(followerList.get(i).getId().equals(follow.get(j).getFollowee())) {
					followerList.get(i).setCheckMyFollow(true);
				}
			}
		}
		
		vo.setFollowList(followList);
		vo.setFollowerList(followerList);
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
	public String follow(String id, String followee){
		int result = dao.insertFollow(id, followee);
		if (result == 1) {
			int followCount = dao.selectFollowCount(id);
			return String.valueOf(followCount);
		} else {
			return "0";
		}
	}
	public String unFollow(String id, String followee) {
		int result = dao.deleteFollow(id, followee);
		if (result == 1) {
			int followCount = dao.selectFollowCount(id);
			return String.valueOf(followCount);
		} else {
			return "0";
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
	public int insertArticlePhoto(FileVO file) {
		int result=dao.insertArticlePhoto(file);
		return result;
	}
	public int changeProfilePhoto(HttpServletRequest request, String userId, MultipartFile m) {
		System.out.println("PhotoService: changeAProfilePhoto 실행!");
		
		// 파일처리
		String uploadPath = request.getServletContext().getRealPath("assets/img/profile_pictures");
		
		File dir = new File(uploadPath + '/' );
		
		// 폴더가 없을 경우 생성
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		
		String savedName = null;

		try {
			savedName = URLDecoder.decode(m.getOriginalFilename(),"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		long time = System.currentTimeMillis();

		File savedFile = new File(dir.getAbsolutePath() + "/"+time + savedName);
		
		int result = dao.updateProfilePhoto(userId, savedFile.getAbsolutePath());

		try {
			m.transferTo(savedFile);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
