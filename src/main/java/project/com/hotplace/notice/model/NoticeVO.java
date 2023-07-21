package project.com.hotplace.notice.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;


@Data
public class NoticeVO {
	private int rn;
	private int num;
	private String title;
	private String content;
	private int writerNum;
	private String writer;
	private int viewCount;
	private String wdate;
	private String saveName;
	private MultipartFile file;
	
}
