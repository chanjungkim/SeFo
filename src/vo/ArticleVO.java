package vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ArticleVO {
	private long article_num;
	private String id;
	private Date write_time;
	private String content;
	private int react_count;
	private List<ReactVO> reactList;
	private List<CommentVO> commentList;
	private List<MultipartFile> fileList;
	private List<FileVO> photoList;
	private int photo_count;
	private int commentCount;
	private String photo_path;
	private boolean react_like;
	private boolean react_love;
	private boolean react_angly;
	private boolean react_sad;
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public boolean isReact_like() {
		return react_like;
	}
	public void setReact_like(boolean react_like) {
		this.react_like = react_like;
	}
	public boolean isReact_love() {
		return react_love;
	}
	public void setReact_love(boolean react_love) {
		this.react_love = react_love;
	}
	public boolean isReact_angly() {
		return react_angly;
	}
	public void setReact_angly(boolean react_angly) {
		this.react_angly = react_angly;
	}
	public boolean isReact_sad() {
		return react_sad;
	}
	public void setReact_sad(boolean react_sad) {
		this.react_sad = react_sad;
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
	public int getReact_count() {
		return react_count;
	}
	public void setReact_count(int react_count) {
		this.react_count = react_count;
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
		this.commentCount = commentList.size();
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
	public String getPhoto_path() {
		return photo_path;
	}
	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}
	@Override
	public String toString() {
		return "ArticleVO [article_num=" + article_num + ", id=" + id + ", write_time=" + write_time + ", content="
				+ content + ", react_count=" + react_count + ", reactList=" + reactList + ", commentList=" + commentList
				+ ", fileList=" + fileList + ", photoList=" + photoList + ", photo_count=" + photo_count
				+ ", commentCount=" + commentCount + ", photo_path=" + photo_path + ", react_like=" + react_like
				+ ", react_love=" + react_love + ", react_angly=" + react_angly + ", react_sad=" + react_sad + "]";
	}

	
	
}