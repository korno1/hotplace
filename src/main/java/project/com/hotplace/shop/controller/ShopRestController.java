package project.com.hotplace.shop.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;
import project.com.hotplace.shop.util.ShopUtil;
import project.com.hotplace.shopreview.model.ShopReviewVO;
import project.com.hotplace.shopreview.service.ShopReviewService;

@Slf4j
@Controller
public class ShopRestController {
	
	@Autowired
	ShopService service;
	
	@Autowired
	ShopReviewService sreService;
	
	@Autowired
	ServletContext sContext;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping(value = "shop/json/selectAll.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> selectAll(Model model, String searchWord, String sortOption, int pageNum) {
		log.info("/selectAll.do");
	    log.info("searchWord:{}", searchWord);
	    
	    List<ShopVO> vos = service.searchList(searchWord);
	    
	    log.info("sort...{}", sortOption);
	    
	    switch (sortOption) {
	    	case "title":
	    		Collections.sort(vos, new Comparator<ShopVO>() {
	    		    @Override
	    		    public int compare(ShopVO vo1, ShopVO vo2) {
	    		        return vo1.getName().compareTo(vo2.getName());
	    		    }
	    		});
	    		break;
	    	case "address":
	    		Collections.sort(vos, new Comparator<ShopVO>() {
	    		    @Override
	    		    public int compare(ShopVO vo1, ShopVO vo2) {
	    		        return vo1.getAddress().compareTo(vo2.getAddress());
	    		    }
	    		});
	    		break;
	    	case "review":
	    		Collections.sort(vos, new Comparator<ShopVO>() {
	    		    @Override
	    		    public int compare(ShopVO vo1, ShopVO vo2) {
	    		    	return Integer.compare(vo2.getReviewCount(), vo1.getReviewCount());
	    		    }
	    		});
	    		break;
	    	case "distance":
	    		double latitude = Double.parseDouble(session.getAttribute("latitude").toString());
				double longitude = Double.parseDouble(session.getAttribute("longitude").toString());
			
				vos.sort(new Comparator<ShopVO>() {
			    	@Override
			    	public int compare(ShopVO vo1, ShopVO vo2) {
			        	if (vo1 == null || vo2 == null) {
			           		return 0; // 두 요소 모두 null이라면 순서 변경 없음
			        	}
			        	// 좌표 계산
			        	double distance1 = ShopUtil.calculateDistance(latitude, longitude, vo1.getLoc_y(), vo1.getLoc_x());
			        	double distance2 = ShopUtil.calculateDistance(latitude, longitude, vo2.getLoc_y(), vo2.getLoc_x());

			        	// 거리를 기준으로 오름차순 정렬
			        	return Double.compare(distance1, distance2);
			    	}
				});
            default:
            	break;
	    }
	    
	    log.info("{}", vos);

	    int itemsPerPage = 10;
	    int startIndex = (pageNum - 1) * itemsPerPage;
	    int endIndex = Math.min(startIndex + itemsPerPage, vos.size());
	    List<ShopVO> paginatedVos = vos.subList(startIndex, endIndex);
	    
	    boolean isLast = false;
	    
	    if (endIndex >= vos.size())
	    	isLast = true;

	    Map<String, Object> response = new HashMap<String, Object>();
	    
	    response.put("vos", paginatedVos);
	    response.put("isLast", isLast);

	    return response;
	}
	
	@RequestMapping(value = "/shop/json/updateRate.do", method = RequestMethod.POST)
    @ResponseBody
    public String updateReviewRate(int shopNum, int rate) {
    	List<ShopReviewVO> vos = sreService.selectAllReview(shopNum);
    	
    	int avg = 0, count = 0;
    	for(ShopReviewVO reviews : vos) {
    		avg += reviews.getRated();
    		count++;
    	}
    	avg = avg / count;
    	
    	
    	return "success";
    }
	
	@RequestMapping(value = "shop/json/insertOK.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> insertOK(ShopVO vo) throws IllegalStateException, IOException {
		vo.setNum(service.countNum() + 1);
		
		log.info("/insertOK.do...{}", vo);
		
		MultipartFile file = vo.getMultipartFile();
				
		if(file != null) {
			String realPath = sContext.getRealPath("/resources/ShopSymbol");
			log.info("realPath : {}",realPath);
			
			File f = new File(realPath+"\\"+ vo.getNum() + ".png");
			
			vo.getMultipartFile().transferTo(f);
			
			BufferedImage originalBufferedImage = ImageIO.read(f);
			BufferedImage thumbnailBufferedImage = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphics = thumbnailBufferedImage.createGraphics();
			graphics.drawImage(originalBufferedImage, 0, 0, 200, 200, null);

			String thumbnailFilePath = realPath+"\\"+vo. getNum() + ".png";
			File thumbnailFile = new File(thumbnailFilePath);
			ImageIO.write(thumbnailBufferedImage, ".png", thumbnailFile);
		}
		
		log.info("VO:{}", vo);
		
		int result = service.insert(vo);
		log.info("result...{}", result);
		
	    Map<String, String> response = new HashMap<>();
	    
	    response.put("result", "success");
	    return response;
	}
}
