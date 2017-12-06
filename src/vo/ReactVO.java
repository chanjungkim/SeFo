package vo;

import java.util.Date;

public class ReactVO {
	private String id;
	private long article_num;
	private int type_num;
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
	public Date getReact_time() {
		return react_time;
	}
	public void setReact_time(Date react_time) {
		this.react_time = react_time;
	}
	public int getType_num() {
		return type_num;
	}
	public void setType_num(int type_num) {
		this.type_num = type_num;
	}
	
	

}
