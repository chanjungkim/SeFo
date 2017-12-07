package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.NotiDao;
import repository.mapper.NotiMapper;
import vo.NotificationVO;

@Component
public class NotiService {
	@Autowired
	NotiDao dao;
	
	public int addNoti(String id, int type, int article_num) {
		return dao.insertNotification(id, type, article_num);
	}
	public List<NotificationVO> getNotiAllList(String id) {
		return dao.selectNotiList(id);
	}
}
