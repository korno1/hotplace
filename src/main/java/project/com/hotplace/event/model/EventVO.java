package project.com.hotplace.event.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EventVO {
	private int num;
	private String title;
	private String content;
	private String writer;
	private int writerNum;
	private String wdate;
	private String deadline;
	private int viewCount;
	private String saveName;
	private MultipartFile file;
}
