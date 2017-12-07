package repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.NotificationVO;

public interface NotiMapper {
	public int insertNotification(@Param("id")String id, @Param("type")int type, @Param("article_num")int article_num);
	public List<NotificationVO> selectNotification(String id); 
}
