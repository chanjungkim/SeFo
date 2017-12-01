package vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ArticleVO {
	private long article_num;
	private String id;
	private Date write_time;
	private String content;
	private int like_count;
	private int love_count;
	private int angry_count;
	private List<ReactVO> reactList;
	private List<CommentVO> commentList;
	private List<MultipartFile> fileList;
	private List<FileVO> photoList;
	private int photo_count;
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
	public Date getWrite_time() {
		return write_time;
	}
	public void setWrite_time(Date write_time) {
		this.write_time = write_time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getLove_count() {
		return love_count;
	}
	public void setLove_count(int love_count) {
		this.love_count = love_count;
	}
	public int getAngry_count() {
		return angry_count;
	}
	public void setAngry_count(int angry_count) {
		this.angry_count = angry_count;
	}
	public List<ReactVO> getReactList() {
		return reactList;
	}
	public void setReactList(List<ReactVO> reactList) {
		this.reactList = reactList;
	}
	public List<CommentVO> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<CommentVO> commentList) {
		this.commentList = commentList;
	}
	public List<MultipartFile> getFileList() {
		return fileList;
	}
	public void setFileList(List<MultipartFile> fileList) {
		this.fileList = fileList;
	}
	public List<FileVO> getPhotoList() {
		return photoList;
	}
	public void setPhotoList(List<FileVO> photoList) {
		this.photoList = photoList;
	}
	public int getPhoto_count() {
		return photo_count;
	}
	public void setPhoto_count(int photo_count) {
		this.photo_count = photo_count;
	}
	@Override
	public String toString() {
		return "ArticleVO [article_num=" + article_num + ", id=" + id + ", write_time=" + write_time + ", content="
				+ content + ", like_count=" + like_count + ", love_count=" + love_count + ", angry_count=" + angry_count
				+ ", reactList=" + reactList + ", commentList=" + commentList + ", fileList=" + fileList
				+ ", photoList=" + photoList + ", photo_count=" + photo_count + "]";
	}
	
}
