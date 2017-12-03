package vo;

import java.util.Date;

public class ReactVO {
	private String member_id;
	private long likeit;
	private long love;
	private long angry;
	private long sad;
	private Date react_time;
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public long getLikeit() {
		return likeit;
	}
	public void setLikeit(long likeit) {
		this.likeit = likeit;
	}
	public long getLove() {
		return love;
	}
	public void setLove(long love) {
		this.love = love;
	}
	public long getAngry() {
		return angry;
	}
	public void setAngry(long angry) {
		this.angry = angry;
	}
	public long getSad() {
		return sad;
	}
	public void setSad(long sad) {
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
		return "ReactVO [member_id=" + member_id + ", likeit=" + likeit + ", love=" + love + ", angry=" + angry
				+ ", sad=" + sad + ", react_time=" + react_time + "]";
	}
}
