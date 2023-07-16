package project.com.hotplace.shopreview.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ShopReviewVO {

	private int num;
	private int writer;
	private String content;
	private int shopNum;
	private int rated;
	private Timestamp wdate;
	private String writerName;
	private int anonymous;
	private MultipartFile multipartFile;
}
