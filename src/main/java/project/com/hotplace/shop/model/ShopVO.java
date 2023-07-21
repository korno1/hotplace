package project.com.hotplace.shop.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ShopVO {
	private int num;
	private String name;
	private String cate;
	private String tel;
	private float loc_x;
	private float loc_y;
	private String address;
	private int rate;
	private double distance;
	private int reviewCount;
	private MultipartFile multipartFile;
}
