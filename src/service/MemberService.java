package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.MemberDao;
import vo.MemberVO;

@Component
public class MemberService {
	@Autowired
	private MemberDao dao;
	
	//로그인 함슈
	public boolean login(String email, String pwd) {
		if(dao.loginMember(email, pwd) == 1) return true;
		else return false;
	}
	
	public MemberVO initMain(String email) {
		return dao.initMain(email);
	}
	
	//회원가입 함슈
	public boolean signup(MemberVO member) {
		if(dao.insertMember(member) > 0) return true;
		else return false;
	}
	
	public boolean checkOverlabID(String id) {
		if(dao.checkOverlabID(id) == 1) return false;
		return true;
	}

	public List<String> searchId(String searchWord) {
		return dao.searchAllId(searchWord);
	}
}
