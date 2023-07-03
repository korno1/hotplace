package project.com.hotplace.shop.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ShopVO {
	private int num;
	private String name;
	private String cate;
	private String tel;
	private float locX;
	private float locY;
	private double avgRated;
	private String symbol;
	private MultipartFile multipartFile;
}
