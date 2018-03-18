package controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebSocketHandler extends TextWebSocketHandler{
	private String TAG = this.getClass().getSimpleName();

	private static Map<String, WebSocketSession> sessionMap =new HashMap<>();
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(TAG);

		System.out.printf("%s ¿¬°áµÊ\n", session.getId());
		sessionMap.put(session.getId(), session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println(TAG);

		System.out.printf("%s·Î ºÎÅÍ [%s]¹ÞÀ½\n", session.getId(), message.getPayload());
		for (String key : sessionMap.keySet()) {
			System.out.println(key);
			sessionMap.get(key).sendMessage(new TextMessage("echo: "+message.getPayload()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println(TAG);

		System.out.printf("%s ¿¬°á²÷±è\n", session.getId());
		sessionMap.remove(session.getId());
	}
}
