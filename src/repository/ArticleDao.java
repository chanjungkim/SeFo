package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.ArticleMapper;
import vo.ArticleVO;

@Component
public class ArticleDao {
	@Autowired
	private SqlSessionTemplate session;
	
	
	public int insertArticle(ArticleVO article) {
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		System.out.println("articleDAO ½ÇÇà!"+article.getContent());
		return mapper.insertArticle(article);
	}
	
	public List<ArticleVO> selectAllArticle(String id){
		ArticleMapper mapper = session.getMapper(ArticleMapper.class);
		return mapper.selectAllArticle(id);
	}
}
