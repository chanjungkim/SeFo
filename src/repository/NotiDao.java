package repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import repository.mapper.NotiMapper;
import vo.NotificationVO;

@Component
public class NotiDao {
	@Autowired
	SqlSessionTemplate session;
	
	public int insertNotification(String id, int type, int article_num) {
		NotiMapper mapper = session.getMapper(NotiMapper.class);
		return mapper.insertNotification(id, type, article_num);
	}
	public List<NotificationVO>selectNotiList(String id) {
		NotiMapper mapper = session.getMapper(NotiMapper.class);
		return mapper.selectNotification(id);
	}
}
