package project.com.hotplace.mail.model;

import lombok.Data;

@Data
public class MailVO {
	private int mail_num;
	private String title;
	private String content;
	private int sender_num;
	private String sender_name;
	private int recipient_num;
	private String recipient_name;
	private String send_date;
	private int read_flag;
}
