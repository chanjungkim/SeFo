package vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ArticleVO {
	private long article_num;
	private String id;
	private Date write_time;
	private String content;
	private long likeit_count;
	private long love_count;
	private long angry_count;
	private long sad_count;
	private List<ReactVO> reactList;
	private List<CommentVO> commentList;
	private List<MultipartFile> fileList;
	private List<FileVO> photoList;
	private int photo_count;
	private int commentCount;
	private String photo_path;
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
	public long getLikeit_count() {
		return likeit_count;
	}
	public void setLikeit_count(long likeit_count) {
		this.likeit_count = likeit_count;
	}
	public long getLove_count() {
		return love_count;
	}
	public void setLove_count(long love_count) {
		this.love_count = love_count;
	}
	public long getAngry_count() {
		return angry_count;
	}
	public void setAngry_count(long angry_count) {
		this.angry_count = angry_count;
	}
	public long getSad_count() {
		return sad_count;
	}
	public void setSad_count(long sad_count) {
		this.sad_count = sad_count;
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
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public String getPhoto_path() {
		return photo_path;
	}
	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}
	@Override
	public String toString() {
		return "ArticleVO [article_num=" + article_num + ", id=" + id + ", write_time=" + write_time + ", content="
				+ content + ", likeit_count=" + likeit_count + ", love_count=" + love_count + ", angry_count="
				+ angry_count + ", sad_count=" + sad_count + ", reactList=" + reactList + ", commentList=" + commentList
				+ ", fileList=" + fileList + ", photoList=" + photoList + ", photo_count=" + photo_count
				+ ", commentCount=" + commentCount + ", photo_path=" + photo_path + "]";
	}
	
	
}