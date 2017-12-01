package vo;

import java.util.Date;

public class ReactVO {
	private String member_id;
	private int love;
	private int angry;
	private int sad;
	private Date react_time;
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getLove() {
		return love;
	}
	public void setLove(int love) {
		this.love = love;
	}
	public int getAngry() {
		return angry;
	}
	public void setAngry(int angry) {
		this.angry = angry;
	}
	public int getSad() {
		return sad;
	}
	public void setSad(int sad) {
		this.sad = sad;
	}
	public Date getReact_time() {
		return react_time;
	}
	public void setReact_time(Date react_time) {
		this.react_time = react_time;
	}
	@Override
	public String toString() {
		return "ReactVO [member_id=" + member_id + ", love=" + love + ", angry=" + angry + ", sad=" + sad
				+ ", react_time=" + react_time + "]";
	}	
}
