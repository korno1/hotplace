package project.com.hotplace.memberreview.model;

import lombok.Data;

@Data
public class MemberReviewVO {
	private int memberreview_num;
	private int party_num;
	private String user_name;
	private int user_num;
	private String writer_name;
	private int writer_num;
	private String content;
	private String wdate;
	private int rated;
	private int wlike;
	private String save_name;
}
