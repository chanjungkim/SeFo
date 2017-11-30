package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.ProfileDao;
import vo.ArticleVO;
import vo.MemberVO;

@Component
public class ProfileService {
	
	@Autowired
	private ProfileDao dao;
	
	public int getProfileContentCount(String id) {
		return dao.selectContentCount(id);
	};
	public MemberVO getProfileInfo(String id) {
		return dao.selectProfileInfo(id);
	}
	public List<ArticleVO> getProfileArticleList(String id){
		return dao.selectArticleList(id);
	};
}
