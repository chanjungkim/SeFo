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
import vo.ArticleVO;
import vo.FileVO;

public class FileLib {
	private static String TAG = FileLib.class.getClass().getSimpleName();
	
	private volatile static FileLib instance;
	
	public static FileLib getInstane(){
		if( instance == null ){
			synchronized(FileLib.class){
				if( instance == null ){
					instance = new FileLib();
				}
			}
		}
		
		return instance;
	}
	
//    private File getFileDir(Context context) {
//        String state = Environment.getExternalStorageState();
//        File filesDir;
//
//        if (Environment.MEDIA_MOUNTED.equals(state)) {
//            filesDir = context.getExternalFilesDir(null);
//        } else {
//            filesDir = context.getFilesDir();
//        }
//
//        MyLog.d(TAG + "getFileDir() = " + filesDir);
//        return filesDir;
//    }

//    public File getProfileIconFile(Context context, String name) {
//        MyLog.d(TAG, "getProfileIconFile() = name + "+".png");
//        return new File(FileLib.getInstance().getFileDir(context), name + ".png");
//    }

    public void uploadArticleImageFiles( ArticleDao dao, MemberDao memberDao, ArticleVO article, HttpServletRequest req){
        MyLog.d(TAG, "getImageFile() = name + "+".png");
        
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
					article.setPhoto_count(article.getFileList().size());
					for (MultipartFile m : article.getFileList()) {
						FileVO fileVO = new FileVO();
						
						String savedName = null;
						try {
							savedName = URLDecoder.decode(m.getOriginalFilename(),"UTF-8");
						} catch (UnsupportedEncodingException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
						long time = System.currentTimeMillis();
						File savedFile = new File(dir.getAbsolutePath() + "/"+time + savedName);
						try {
							m.transferTo(savedFile);
							fileVO.setArticle_num(article.getArticle_num());
							fileVO.setFile_name(savedName);
							fileVO.setFile_origiName("userArticleImage/" + article.getArticle_num() + "/" +time+ savedName);
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
    }
}
