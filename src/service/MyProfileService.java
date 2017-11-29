package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.MyProfileDao;
import vo.ArticleVO;

@Component
public class MyProfileService {
	
	@Autowired
	private MyProfileDao dao;
	
	public int getMyContentCount(String id) {
		return dao.selectMyContentCount(id);
	};
	
	public List<ArticleVO> getAllMyArticle(String id){
		return dao.selectAllMyArticle(id);
	};

}
