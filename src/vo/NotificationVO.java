package vo;

public class NotificationVO {
	private int notification_num;
	private String recieve_id;
	private int notification_type; //1´ñ±Û , 2ÆÈ·Î¿ì
	private int article_num;
	private String my_id;
	
	////////////////////////////////////////////
	public int getNotification_num() {
		return notification_num;
	}
	public void setNotification_num(int notification_num) {
		this.notification_num = notification_num;
	}
	public String getRecieve_id() {
		return recieve_id;
	}
	public void setRecieve_id(String recieve_id) {
		this.recieve_id = recieve_id;
	}
	public int getNotification_type() {
		return notification_type;
	}
	public void setNotification_type(int notification_type) {
		this.notification_type = notification_type;
	}
	public int getArticle_num() {
		return article_num;
	}
	public void setArticle_num(int article_num) {
		this.article_num = article_num;
	}
	
	public String getMy_id() {
		return my_id;
	}
	public void setMy_id(String my_id) {
		this.my_id = my_id;
	}
	@Override
	public String toString() {
		return "NotificationVO [notification_num=" + notification_num + ", recieve_id=" + recieve_id
				+ ", notification_type=" + notification_type + ", article_num=" + article_num + "]";
	}
}
