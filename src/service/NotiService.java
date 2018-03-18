package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.NotiDao;
import repository.mapper.NotiMapper;
import vo.NotificationVO;

@Component
public class NotiService {
	private String TAG = this.getClass().getSimpleName();

	@Autowired
	NotiDao dao;
	
	public int addNoti(String id, int type, int article_num) {
		System.out.println(TAG);
		return dao.insertNotification(id, type, article_num);
	}
	public List<NotificationVO> getNotiAllList(String id) {
		System.out.println(TAG);
		return dao.selectNotiList(id);
	}
}
