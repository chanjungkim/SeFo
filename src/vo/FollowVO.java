package vo;

public class FollowVO {
	private long follow_num;
	private String id;
	private String followee;
	
	/////////////////////////////////////

	public long getFollow_num() {
		return follow_num;
	}

	public void setFollow_num(long follow_num) {
		this.follow_num = follow_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFollowee() {
		return followee;
	}

	public void setFollowee(String followee) {
		this.followee = followee;
	}
	
	@Override
	public String toString() {
		return "FollowVO [follow_num=" + follow_num + ", id=" + id + ", followee=" + followee + "]";
	}
	
}
