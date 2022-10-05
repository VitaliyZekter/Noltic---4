/**
 * Created by zekte on 02.09.2022.
 */

public with sharing class NotificationSenderService {
    static NotificationSender getSender;
    static String getMessage;

    public void initNotificationSender(NotificationSender sender, String message) {
        getSender = sender;
        getMessage = message;
    }

    public void executeSend(){
        getSender.sendNotification(getMessage);
    }
}