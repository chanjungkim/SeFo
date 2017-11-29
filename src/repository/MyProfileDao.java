package repository;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.MyProfileMapper;
import vo.ArticleVO;

@Component
public class MyProfileDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public int selectMyContentCount(String id) {
		MyProfileMapper mapper = session.getMapper(MyProfileMapper.class);
		return mapper.selectMyContentCount(id);
	};
	
	public List<ArticleVO> selectAllMyArticle(String id){
		MyProfileMapper mapper = session.getMapper(MyProfileMapper.class);
		return mapper.selectAllMyArticle(id);
	};

}
