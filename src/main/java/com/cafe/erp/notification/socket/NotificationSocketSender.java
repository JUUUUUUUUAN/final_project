package com.cafe.erp.notification.socket;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

@Component
public class NotificationSocketSender {
	
	private final SimpMessagingTemplate messagingTemplate;
	
	public NotificationSocketSender(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    public void send(Long memberId, Object message) {
        messagingTemplate.convertAndSend(
            "/sub/notifications/" + memberId,
            message
        );
    }
	
	
	
}
