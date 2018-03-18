package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.MemberDao;
import vo.MemberVO;

@Component
public class MemberService {
	private String TAG = this.getClass().getSimpleName();

	@Autowired
	private MemberDao dao;
	
	//로그인 함슈
	public boolean login(String email, String pwd) {
		System.out.println(TAG + ", login()");
		if(dao.loginMember(email, pwd) == 1) return true;
		else return false;
	}
	
	public MemberVO initMain(String email) {
		System.out.println(TAG + ", initMain()");
		return dao.initMain(email);
	}
	
	//회원가입 함슈
	public boolean signup(MemberVO member) {
		System.out.println(TAG + ", signup()");
		if(dao.insertMember(member) > 0) return true;
		else return false;
	}
	
	public boolean checkOverlabID(String id) {
		System.out.println(TAG+ ", checkOverlabID()");
		if(dao.checkOverlabID(id) == 1) return false;
		return true;
	}

	public List<String> searchId(String searchWord) {
		System.out.println(TAG + ", searchId()");
		return dao.searchAllId(searchWord);
	}
}
