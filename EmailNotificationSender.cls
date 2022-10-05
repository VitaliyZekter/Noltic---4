public class EmailNotificationSender implements NotificationSender {

    public void sendNotification(String notificationMessage) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'zekter02@gmail.com'};

        mail.setToAddresses(toAddresses);

        mail.setReplyTo('zekter02@gmail.com');

        mail.setSenderDisplayName('Working!');

        mail.setSubject('Home Work 18');

        mail.setHtmlBody(notificationMessage);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});

    }
}