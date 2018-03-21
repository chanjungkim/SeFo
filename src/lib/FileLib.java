package lib;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import repository.ArticleDao;
import repository.MemberDao;
import repository.ProfileDao;
import vo.ArticleVO;
import vo.FileVO;
import vo.MemberVO;

public class FileLib {
	private static String TAG = FileLib.class.getSimpleName();

	private volatile static FileLib instance;

	public static FileLib getInstane() {
		if (instance == null) {
			synchronized (FileLib.class) {
				if (instance == null) {
					instance = new FileLib();
				}
			}
		}

		return instance;
	}

	public void uploadArticleImageFiles(ArticleDao dao, MemberDao memberDao, ArticleVO article,
			HttpServletRequest req) {
		MyLog.d(TAG, "getImageFile() = name + " + ".png");

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
					// 사진 리스트
					article.setPhotoList(new ArrayList<FileVO>());
					article.setPhoto_count(article.getFileList().size());
					for (MultipartFile m : article.getFileList()) {
						FileVO fileVO = new FileVO();

						String savedName = null;
						try {
							savedName = URLDecoder.decode(m.getOriginalFilename(), "UTF-8");
						} catch (UnsupportedEncodingException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
						long time = System.currentTimeMillis();
						File savedFile = new File(dir.getAbsolutePath() + "/" + time + savedName);
						try {
							m.transferTo(savedFile);
							fileVO.setArticle_num(article.getArticle_num());
							fileVO.setFile_name(savedName);
							fileVO.setFile_origiName(
									"userArticleImage/" + article.getArticle_num() + "/" + time + savedName);
							fileVO.setFile_path(savedFile.getAbsolutePath());
							// DB에 업로드 내역 기록
							dao.insertArticlePhoto(fileVO);
							// 사진 정보 하나씩 넣기
							article.getPhotoList().add(fileVO);
							MyLog.d(TAG, "---------------");
							MyLog.d(TAG, "업로드 완료");
							MyLog.d(TAG, "원본이름:" + m.getOriginalFilename());
							MyLog.d(TAG, "fileVO origiName:" + fileVO.getFile_origiName());
							MyLog.d(TAG, "저장된 경로:" + savedFile.getAbsolutePath());
							MyLog.d(TAG, "---------------");
						} catch (IllegalStateException | IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					// article에 fileVo 넣기
				}
			}
		}
	}

	public int uploadProfileImageFile(ProfileDao dao, MemberVO member, HttpServletRequest req) {
		if (member.getFile() != null) {
			//////////////////////////////////
			// 파일처리
			String uploadPath = req.getServletContext().getRealPath("profileImage");
			
			File dir = new File(uploadPath + "/" + member.getId());
			// 폴더가 없을 경우 생성
			if (!dir.exists()) {
				dir.mkdirs();
			}
			if (member.getFile() != null) {
				// 사진 리스트
				member.setPhoto(new FileVO());

				MultipartFile m = member.getFile();
				FileVO fileVO = new FileVO();

				String savedFileName = null;
				
				try {
					savedFileName = URLDecoder.decode(m.getOriginalFilename(), "UTF-8");
				} catch (UnsupportedEncodingException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				long time = System.currentTimeMillis();
				File uploadedFile = new File(dir.getAbsolutePath() + "/" + savedFileName);
				try {
					m.transferTo(uploadedFile);
					fileVO.setFile_name(savedFileName);
//					fileVO.setFile_origiName("assets/profileImages/" + member.getMember_num() + "/" + time + savedName);
					fileVO.setFile_origiName("profileImage/" + member.getId());
					fileVO.setFile_path(uploadedFile.getAbsolutePath());
					
					// DB에 업로드 내역 기록
					member.setPhoto_path(fileVO.getFile_origiName() + "/" +fileVO.getFile_name());
					
					MyLog.d(TAG, member.toString());
					dao.updateProfile(member);

					MyLog.d(TAG, member.toString());
					MyLog.d(TAG, "업로드 완료");
					MyLog.d(TAG, "원본이름:" + m.getOriginalFilename());
					MyLog.d(TAG, "불러올 경로:" + member.getPhoto_path());
					MyLog.d(TAG, "fileVO origiName:" + fileVO.getFile_origiName());
					MyLog.d(TAG, "저장된 경로:" + uploadedFile.getAbsolutePath());
					
					return 1;
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				// article에 fileVo 넣기
			}
		} else MyLog.d(TAG, "File이 없음.");
		return 0;
	}
}