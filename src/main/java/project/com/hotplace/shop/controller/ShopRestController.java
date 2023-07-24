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
	    if(session.getAttribute("latitude") != null && session.getAttribute("longitude") != null)
	    {
	    	double latitude = Double.parseDouble(session.getAttribute("latitude").toString());
	    	double longitude = Double.parseDouble(session.getAttribute("longitude").toString());
	    	
	    	for(ShopVO shop:vos)
	    	{
	    		shop.setDistance(ShopUtil.calculateDistance(latitude, longitude, shop.getLoc_y(), shop.getLoc_x()));
	    	}
	    }
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
	                    int rateComparison = Integer.compare(vo2.getRate(), vo1.getRate());
	                    if (rateComparison == 0) {
	                        return Integer.compare(vo2.getReviewCount(), vo1.getReviewCount());
	                    }
	                    return rateComparison;
	                }
	            });
	            break;
	        case "reviewCount":
	            Collections.sort(vos, new Comparator<ShopVO>() {
	                @Override
	                public int compare(ShopVO vo1, ShopVO vo2) {
	                    int reviewCountComparison = Integer.compare(vo2.getReviewCount(), vo1.getReviewCount());
	                    if (reviewCountComparison == 0) {
	                        return Integer.compare(vo2.getRate(), vo1.getRate());
	                    }
	                    return reviewCountComparison;
	                }
	            });
	            break;
	    	case "distance":
	    		Collections.sort(vos, new Comparator<ShopVO>() {
	    	        @Override
	    	        public int compare(ShopVO vo1, ShopVO vo2) {
	    	            return Double.compare(vo1.getDistance(), vo2.getDistance());
	    	        }
	    	    });
	    	    break;
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
