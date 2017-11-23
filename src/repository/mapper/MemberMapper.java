package repository.mapper;

import org.apache.ibatis.annotations.Param;

import vo.MemberVO;

public interface MemberMapper {
	public int loginMember(@Param("id")String id, @Param("password")String password);
	public MemberVO initMain(String id);
}
