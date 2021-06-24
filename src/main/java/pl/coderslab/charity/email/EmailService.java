package pl.coderslab.charity.email;

public interface EmailService {
    public void sendSimpleMessage(String to, String subject, String text);
}
