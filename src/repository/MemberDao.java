package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.MemberMapper;
import vo.MemberVO;

@Component
public class MemberDao {
	private String TAG = this.getClass().getSimpleName();

	@Autowired
	private SqlSessionTemplate session;
	
	public int loginMember(String id, String pwd) {
		System.out.println(TAG + ", loginMember() = id: "+id+" | pwd: "+pwd);
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.loginMember(id, pwd);
	}
	
	public MemberVO initMain(String id) {
		System.out.println(TAG + ", initMain()");
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.initMain(id);
	}
	
	public int insertMember(MemberVO member) {
		System.out.println(TAG+ ", insertMember()");
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.insertMember(member);
	}
	
	public int checkOverlabID(String id) {
		System.out.println(TAG+ ", checkOverlabID()");
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.checkOverlabID(id);
	}

	public List<String> searchAllId(String searchWord) {
		System.out.println(TAG+ ", searchAllId()");
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.searchAllId(searchWord);
	}
}
