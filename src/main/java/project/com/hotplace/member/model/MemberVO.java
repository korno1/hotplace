package project.com.hotplace.member.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private int num;
	private String nick_name;
	private String email;
	private String address;
	private String pw;
	private int grade;
	private int gender;
	private String food_like;
	private MultipartFile multipartFile;
}
