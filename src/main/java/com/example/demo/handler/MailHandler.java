package com.example.demo.handler;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailHandler {
	private JavaMailSender sender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;
	
	public MailHandler(JavaMailSender sender) throws MessagingException {
		this.sender = sender;
		message = sender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, true, "UTF-8");		
	}
	
	public void setFrom(String from) throws MessagingException {
		messageHelper.setFrom(from);
	}
	
	public void setTo(String to) throws MessagingException {
		messageHelper.setTo(to);
		
	}
	
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}
	
	public void setText(String text) throws MessagingException {
		messageHelper.setText(text, true);
	}
	
	public void send() {
		sender.send(message);
	}
	
}
