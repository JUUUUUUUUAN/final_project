package com.cafe.erp.notification.controller;

import com.cafe.erp.notification.socket.NotificationSocketSender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class NotificationTestController {

	@Autowired
    private NotificationSocketSender socketSender;


    @GetMapping("/test/notification")
    public void testNotification() {
        socketSender.send(1L, "알람 테스트 성공!");
    }
    
}
