package project.com.hotplace.party.model;

import java.security.Timestamp;

import lombok.Data;

@Data
public class PartyVO {
	private int party_num;
	private int writer_num;
	private String title;
	private int views;
	private String content;
	private int applicants;
	private int max;
	private String place;
	private String time_limit;
	private Timestamp wdate;
}
