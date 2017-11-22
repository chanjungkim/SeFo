package repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.MemberMapper;
import vo.MemberVO;

@Component
public class MemberDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public int loginMember(String email, String pwd) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.loginMember(email, pwd);
	}
	
	public MemberVO initMain(String email) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.initMain(email);
	}
}
