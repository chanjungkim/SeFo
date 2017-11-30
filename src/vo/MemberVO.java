package vo;

import java.util.Date;

public class MemberVO {
	private int member_num;
	private String id;
	private String password;
	private String name;
	private String email;
	private Date birth;
	private String photo_path;
	private String phone;
	private Character gender;
	private int follow_count;
	private int follower_count;
	private String self_info;
	
	/////////////////////////////////////////////////////////////

	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getPhoto_path() {
		return photo_path;
	}

	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Character getGender() {
		return gender;
	}

	public void setGender(Character gender) {
		this.gender = gender;
	}

	public int getFollow_count() {
		return follow_count;
	}

	public void setFollow_count(int follow_count) {
		this.follow_count = follow_count;
	}

	public int getFollower_count() {
		return follower_count;
	}

	public void setFollower_count(int follower_count) {
		this.follower_count = follower_count;
	}

	public String getSelf_info() {
		return self_info;
	}

	public void setSelf_info(String self_info) {
		this.self_info = self_info;
	}

	@Override
	public String toString() {
		return "MemberVO [member_num=" + member_num + ", id=" + id + ", password=" + password + ", name=" + name
				+ ", email=" + email + ", birth=" + birth + ", photo_path=" + photo_path + ", phone=" + phone
				+ ", gender=" + gender + ", follow_count=" + follow_count + ", follower_count=" + follower_count
				+ ", self_info=" + self_info + "]";
	}
}
