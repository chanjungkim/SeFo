package vo;

import java.util.Date;

public class ReactVO {
	private String id;
	private long article_num;
	private long likeit;
	private long love;
	private long angry;
	private long sad;
	private Date react_time;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public long getArticle_num() {
		return article_num;
	}
	public void setArticle_num(long article_num) {
		this.article_num = article_num;
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
		return "ReactVO [id=" + id + ", article_num=" + article_num + ", likeit=" + likeit + ", love=" + love
				+ ", angry=" + angry + ", sad=" + sad + ", react_time=" + react_time + "]";
	}
}
