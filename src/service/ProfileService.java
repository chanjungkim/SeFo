package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.ProfileDao;
import repository.mapper.ProfileMapper;
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
	public List<ArticleVO> getProfileFistArticleList(String id){
		return dao.selectFisrtArticleList(id);
	};
	
	public List<ArticleVO> getProfileMoreArticleList(String id, int articleNum) {
		return dao.selectMoreArticleList(id, articleNum);
	};
}
