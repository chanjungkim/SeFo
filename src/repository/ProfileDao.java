package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.ProfileMapper;
import vo.ArticleVO;
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
	public List<ArticleVO> selectArticleList(String id){
		ProfileMapper mapper = session.getMapper(ProfileMapper.class);
		return mapper.selectArticleList(id);
	};

}
