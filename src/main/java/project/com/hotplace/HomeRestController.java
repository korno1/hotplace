package project.com.hotplace;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;

@Slf4j
@Controller
public class HomeRestController {
	
	@Autowired
	ShopService shoService;
	
	@RequestMapping(value = "/home/json/updateAddress.do", method = RequestMethod.POST)
	@ResponseBody
    public String updateCurrentAddress(@RequestParam("currentAddress") String currentAddress,
                                       @RequestParam("latitude") String latitude,
                                       @RequestParam("longitude") String longitude,
                                       HttpSession session) {
        // 주소와 좌표를 세션에 저장
        session.setAttribute("currentAddress", currentAddress);
        session.setAttribute("latitude", latitude);
        session.setAttribute("longitude", longitude);
        
        return "success";
    }
	
	@RequestMapping(value = "/home/json/getNearbyShops.do", method = RequestMethod.GET)
    @ResponseBody
    public List<ShopVO> getNearbyShops(HttpSession session) {
		double latitude = Double.parseDouble(session.getAttribute("latitude").toString());
		double longitude = Double.parseDouble(session.getAttribute("longitude").toString());
        
		List<ShopVO> vos = shoService.selectAllHome();
       
		List<ShopVO> nearShops = new ArrayList<>();
		
	    double degreeToKmRatio = 40075.16 / 360.0; // 1도에 해당하는 거리 (단위: km)
       
	    Map<String, Integer> categoryCountMap = new HashMap<>(); // 카테고리별 count를 저장할 맵
       
		for(ShopVO shop : vos) {
    	   double locX = shop.getLoc_x();
    	   double locY = shop.getLoc_y();
    	   
    	   double deltaX = locX - longitude;
           double deltaY = locY - latitude;
    	   
           double distance = Math.sqrt(Math.pow(deltaX * degreeToKmRatio, 2) + Math.pow(deltaY * degreeToKmRatio, 2));
           
           log.info("{}", shop);
    	   log.info("distance:{}", distance);
           
           shop.setDistance(distance);
           
           if (distance <= 20.0)
               nearShops.add(shop);
		}
		
		// 카테고리별 count 정보를 ShopVO에 추가
	    for (ShopVO shop : nearShops) {
	        String[] categories = shop.getCate().split(","); // 카테고리 목록을 쉼표로 분리하여 배열로 변환
	        
	        for (String category : categories) {
                int count = categoryCountMap.getOrDefault(category, 0);
                categoryCountMap.put(category, count + 1); // 해당 카테고리의 count 증가
            }
	    }
	    
	    for (Map.Entry<String, Integer> entry : categoryCountMap.entrySet()) {
	        String category = entry.getKey();
	        int count = entry.getValue();
	        log.info("Category: {} - Count: {}", category, count);
	    }
		
		
		return nearShops;
    }
}
