package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import repository.ArticleDao;
import vo.ArticleVO;
import vo.CommentVO;
import vo.FileVO;

@Component
public class ArticleService {
	@Autowired
	private ArticleDao dao;

	public ArticleVO writeArticle(ArticleVO article, HttpServletRequest req) {
		System.out.println("articleService 실행!");
		int result = dao.insertArticle(article);
		// System.out.println(result + " : "+article.getContent());
		if (result > 0) {
			if (article.getFileList() != null && article.getFileList().size() != 0) {
				//////////////////////////////////
				// 파일처리
				String uploadPath = req.getServletContext().getRealPath("userArticleImage");
				File dir = new File(uploadPath + "/" + article.getArticle_num());
				// 폴더가 없을 경우 생성
				if (!dir.exists()) {
					dir.mkdirs();
				}
				if (article.getFileList() != null && article.getFileList().size() != 0) {
					//사진 리스트
					article.setPhotoList(new ArrayList<FileVO>());
					for (MultipartFile m : article.getFileList()) {
						FileVO fileVO = new FileVO();
						String savedName = new Random().nextInt(1000000) + m.getOriginalFilename();
						File savedFile = new File(dir.getAbsolutePath() + "/" + savedName);
						try {
							m.transferTo(savedFile);
							fileVO.setArticle_num(article.getArticle_num());
							fileVO.setFile_name(savedName);
							fileVO.setFile_origiName("userArticleImage/" + article.getArticle_num() + "/" + savedName);
							fileVO.setFile_path(savedFile.getAbsolutePath());
							// DB에 업로드 내역 기록
							dao.insertArticlePhoto(fileVO);
							// 사진 정보 하나씩 넣기
							article.getPhotoList().add(fileVO);
							System.out.println("---------------");
							System.out.println("업로드 완료");
							System.out.println("원본이름:" + m.getOriginalFilename());
							System.out.println("fileVO origiName:" + fileVO.getFile_origiName());
							System.out.println("저장된 경로:" + savedFile.getAbsolutePath());
							System.out.println("---------------");
						} catch (IllegalStateException | IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					// article에 fileVo 넣기
				}
			}
		}
		return article;
	}

	public List<ArticleVO> getArticleList(String id) {
		List<ArticleVO> articleList = dao.selectAllArticle(id);
		for (ArticleVO article : articleList) {
			article.setCommentList(dao.selectAllComment(article.getArticle_num()));
			// System.out.println(article.getArticle_num()+"/"+article.getCommentList().size());
		}
		return articleList;
	}

	public List<CommentVO> getCommentList(long article_num) {
		return dao.selectAllComment(article_num);
	}

	public boolean deleteComment(long comment_num) {
		System.out.println("deleteComment서비스 실행" + comment_num);
		int result = dao.deleteComment(comment_num);
		System.out.println(result);
		if (result > 0)
			return true;
		else
			return false;
	}

	public boolean deleteNewComment(String id, String content) {
		System.out.println("deleteNewComment서비스 실행" + id + ":" + content);
		int result = dao.deleteNewComment(id, content);
		System.out.println(result);
		if (result > 0)
			return true;
		else
			return false;
	}

	public boolean writeComment(CommentVO comment) {
		System.out.println("writeComment 서비스 실행" + comment.getId() + ":" + comment.getContent());
		int result = dao.insertComment(comment);
		if (result > 0)
			return true;
		else
			return false;
	}

	public List<FileVO> getArticlePhoto(long article_num) {
		return dao.selectArticlePhoto(article_num);
	}
}
