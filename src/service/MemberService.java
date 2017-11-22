package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.MemberDao;
import vo.MemberVO;

@Component
public class MemberService {
	@Autowired
	private MemberDao dao;
	
	//·Î±×ÀÎ ÇÔ½´
	public boolean login(String email, String pwd) {
		if(dao.loginMember(email, pwd) == 1) return true;
		else return false;
	}
	
	public MemberVO initMain(String email) {
		return dao.initMain(email);
	}
}
