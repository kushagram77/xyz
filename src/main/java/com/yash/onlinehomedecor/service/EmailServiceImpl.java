package com.yash.onlinehomedecor.service;



import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;



import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class EmailServiceImpl implements EmailService {

    private static final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

    @Autowired
    private Environment env;

    @Override
    public boolean sendRegistrationEmail(User user) {
        // Validate input
        if (user == null || user.getEmail() == null) {
            logger.error("Invalid user or email");
            return false;
        }

        try {
            // Configure mail properties
            Properties props = new Properties();
            props.put("mail.smtp.host", env.getProperty("mail.smtp.host", "smtp.gmail.com"));
            props.put("mail.smtp.port", env.getProperty("mail.smtp.port", "587"));
            props.put("mail.smtp.auth", env.getProperty("mail.smtp.auth", "true"));
            props.put("mail.smtp.starttls.enable", env.getProperty("mail.smtp.starttls.enable", "true"));

            // Retrieve credentials
            String username = env.getProperty("mail.smtp.username");
            String password = env.getProperty("mail.smtp.password");

            // Validate credentials
            if (username == null || password == null) {
                logger.error("Email credentials not configured");
                return false;
            }

            // Create authentication session
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            // Create and configure email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
            message.setSubject("Welcome to Online Home Decor - Registration Successful");

            // Compose email body
            String emailBody = String.format(
                    "Dear %s,\n\n" +
                            "Congratulations! You have successfully registered with Online Home Decor.\n\n" +
                            "Your Account Details:\n" +
                            "Name: %s\n" +
                            "Email: %s\n" +
                            "Role: %s\n\n" +
                            "We're excited to have you join our platform!\n\n" +
                            "Best regards,\n" +
                            "Online Home Decor Team",
                    user.getName(),
                    user.getName(),
                    user.getEmail(),
                    user.getRole()
            );

            // Set email content
            message.setText(emailBody);

            // Send email
            Transport.send(message);
            logger.info("Registration email sent successfully to {}", user.getEmail());
            return true;
        } catch (AuthenticationFailedException e) {
            logger.error("Authentication failed: Check your email credentials", e);
        } catch (MessagingException e) {
            logger.error("Error sending registration email", e);
        } catch (Exception e) {
            logger.error("Unexpected error in sending email", e);
        }

        return false;
    }
}