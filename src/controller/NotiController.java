package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.NotiService;
import vo.NotificationVO;

@Component
public class NotiController {
	@Autowired
	NotiService service;
	
	@RequestMapping
	@ResponseBody
	public NotificationVO addNotification(HttpSession session, String recieve_id, int article_num,int notification_type) {
		String id = (String) session.getAttribute("loginId");
		NotificationVO noti = new NotificationVO();
		noti.setMy_id(id);
		noti.setArticle_num(article_num);
		noti.setNotification_type(notification_type);
		noti.setRecieve_id(recieve_id);
		int result = service.addNoti(id, notification_type, article_num);
		if (result > 0 )
			return noti;
		else
			return null; 
	}
}
