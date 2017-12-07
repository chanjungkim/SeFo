package vo;

import org.springframework.web.multipart.MultipartFile;

public class SingleFileVO {
	private MultipartFile file;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	
}
