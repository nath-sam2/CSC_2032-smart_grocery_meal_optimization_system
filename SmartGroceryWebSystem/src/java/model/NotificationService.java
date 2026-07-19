package model;

import java.util.Date;

public class NotificationService {

    private int notifId;
    private String message;
    private String type;
    private Date timestamp;

    public NotificationService(int notifId, String message,
                               String type, Date timestamp) {
        this.notifId   = notifId;
        this.message   = message;
        this.type      = type;
        this.timestamp = timestamp;
    }

    public int getNotifId()      
        { return notifId; }
    public String getMessage()   
        { return message; }
    public String getType()      
        { return type; }
    public Date getTimestamp()   
        { return timestamp; }

    public void sendLowStockAlert() {
        System.out.println("LOW STOCK ALERT: " + message);
    }

    public void sendExpiryAlert() {
        System.out.println("EXPIRY ALERT: " + message);
    }

    public void getAllNotifications() {
        System.out.println("Getting all notifications...");
    }
}