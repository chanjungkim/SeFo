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
	
	public int loginMember(String id, String pwd) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.loginMember(id, pwd);
	}
	
	public MemberVO initMain(String id) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.initMain(id);
	}
	
	public int insertMember(MemberVO member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.insertMember(member);
	}
	
	public int checkOverlabID(String id) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.checkOverlabID(id);
	}
}
