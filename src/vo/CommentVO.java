package vo;

import java.util.Date;

public class CommentVO {
	private long comment_num;
	private long article_num;
	private String id;
	private String content;
	private Date write_time;
	public long getComment_num() {
		return comment_num;
	}
	public void setComment_num(long comment_num) {
		this.comment_num = comment_num;
	}
	public long getArticle_num() {
		return article_num;
	}
	public void setArticle_num(long article_num) {
		this.article_num = article_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWrite_time() {
		return write_time;
	}
	public void setWrite_time(Date write_time) {
		this.write_time = write_time;
	}
	@Override
	public String toString() {
		return "CommentVO [comment_num=" + comment_num + ", article_num=" + article_num + ", id=" + id + ", content="
				+ content + ", write_time=" + write_time + "]";
	}
}
