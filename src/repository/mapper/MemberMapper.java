package repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.MemberVO;

public interface MemberMapper {
	public int loginMember(@Param("id")String id, @Param("password")String password);
	public MemberVO initMain(String id);
	public int insertMember(MemberVO member);
	public int checkOverlabID(String id);
	public List<String> searchAllId(String searchWord);
}
