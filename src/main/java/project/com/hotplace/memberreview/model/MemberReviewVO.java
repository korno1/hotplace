package project.com.hotplace.memberreview.model;

import lombok.Data;

@Data
public class MemberReviewVO {
	private int memberreviewNum;
	private int partyNum;
	private String userName;
	private int userNum;
	private String writerName;
	private int writerNum;
	private String content;
	private String wdate;
	private int rated;
	private int wlike;
}
