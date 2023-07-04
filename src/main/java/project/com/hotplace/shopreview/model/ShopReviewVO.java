package project.com.hotplace.shopreview.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ShopReviewVO {

	private int num;
	private String writer;
	private String content;
	private int shopNum;
	private int rated;
	private Timestamp wdate;
	private String writerName;
}
