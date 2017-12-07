package vo;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {
	private long article_num;
	private int article_photo_num;
	private String file_path;
	private String file_name;
	private String file_origiName;
	private MultipartFile memImg;
	
	///////////////////////////////
	public String getFile_path() {
		return file_path;
	}
	public long getArticle_num() {
		return article_num;
	}
	public void setArticle_num(long article_num) {
		this.article_num = article_num;
	}
	public int getArticle_photo_num() {
		return article_photo_num;
	}
	public void setArticle_photo_num(int article_photo_num) {
		this.article_photo_num = article_photo_num;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_origiName() {
		return file_origiName;
	}
	public void setFile_origiName(String file_origiName) {
		this.file_origiName = file_origiName;
	}
	public MultipartFile getMemImg() {
		return memImg;
	}
	public void setMemImg(MultipartFile memImg) {
		this.memImg = memImg;
	}
	
	
}
