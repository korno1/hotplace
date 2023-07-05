package project.com.hotplace.applicants.model;

import lombok.Data;

@Data
public class ApplicantsVO {
	private int applicantsNum;
	private int partyNum;
	private int userNum;
	private String userName;
	private String comments;
	private int status;
}
