package project.com.hotplace.memberreview.model;

import lombok.Data;

@Data
public class MemberReviewVO {
	private int memberreview_num;
	private int party_num;
	private int user_num;
	private int writer_num;
	private String content;
	private String wdate;
	private int rated;
	private int wlike;
}
