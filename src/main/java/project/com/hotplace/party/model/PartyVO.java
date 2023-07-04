package project.com.hotplace.party.model;

import java.security.Timestamp;

import lombok.Data;

@Data
public class PartyVO {
	private int partyNum;
	private int writerNum;
	private String writerName;
	private String title;
	private int views;
	private String content;
	private int applicants;
	private int max;
	private String place;
	private String timeLimit;
	private Timestamp wdate;
}
