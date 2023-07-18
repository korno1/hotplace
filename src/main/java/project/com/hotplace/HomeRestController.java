package project.com.hotplace;

import java.util.ArrayList;
import java.util.Arrays;
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
import project.com.hotplace.member.model.MemberVO;
import project.com.hotplace.member.service.MemberService;
import project.com.hotplace.shop.model.ShopVO;
import project.com.hotplace.shop.service.ShopService;

@Slf4j
@Controller
public class HomeRestController {
	
	@Autowired
	ShopService shoService;
	
	@Autowired
	MemberService memService;
	
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
	
	@RequestMapping(value = "/home/json/getRecommendedShops.do", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, List<ShopVO>> getRecommendedShops(HttpSession session) {
		double latitude = Double.parseDouble(session.getAttribute("latitude").toString());
		double longitude = Double.parseDouble(session.getAttribute("longitude").toString());
		
		Object nickName = session.getAttribute("nick_name");
		
		String[] recommendCate = new String[5];
		int recommendIndex = 0;
		
		log.info("{}", nickName);
		
		// 1순위 처리로 사용자 선호 음식 카테고리로 설정(로그인 되었을 경우 가져옴)
		if(nickName != null) {
			MemberVO memVO = new MemberVO();
			memVO.setNick_name(nickName.toString());
			
			memVO = memService.idAuth(memVO);
			
			log.info("{}", memVO);
			
			String foodLike = memVO.getFood_like();
			
			if(foodLike != null) {
				String[] foodLikes = foodLike.split(",");
				for (String food : foodLikes) {
					if (recommendIndex >= 5) break;
					recommendCate[recommendIndex++] = food.trim();
				}
			}
		}
		
		log.info("recommendCate:{}", Arrays.toString(recommendCate));
		
		List<ShopVO> vos = shoService.selectAllHome();
       
		List<ShopVO> nearShops = new ArrayList<>();
		
	    double degreeToKmRatio = 40075.16 / 360.0; // 1도에 해당하는 거리 (단위: km)
       
	   
       
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
		
		 Map<String, Integer> categoryCountMap = new HashMap<>(); // 카테고리별 count를 저장할 맵
		
		// 카테고리별 count 정보가 구성된 Map 생성
	    for (ShopVO shop : nearShops) {
	        String[] categories = shop.getCate().split(","); // 카테고리 목록을 쉼표로 분리하여 배열로 변환
	        
	        for (String category : categories) {
	        	if(category.contains("음식점")) {}
	        	else {
	        		int count = categoryCountMap.getOrDefault(category, 0);
                	categoryCountMap.put(category, count + 1); // 해당 카테고리의 count 증가
	        	}
            }
	    }
	    
	    // 카테고리 count 내림차순으로 정렬
	    List<Map.Entry<String, Integer>> sortedCategoryCounts = new ArrayList<>(categoryCountMap.entrySet());
	    sortedCategoryCounts.sort(Map.Entry.<String, Integer>comparingByValue().reversed());
	    
	    log.info("sortedCategory:{}", sortedCategoryCounts);
	    
	    for (Map.Entry<String, Integer> entry : sortedCategoryCounts) {
	        String category = entry.getKey();
	        if (!Arrays.asList(recommendCate).contains(category)) {
	            recommendCate[recommendIndex++] = category;
	            if (recommendIndex >= 5) {
	                break; // 추천 카테고리 배열에 5개가 모두 채워지면 순회 종료
	            }
	        }
	    }
	    
	    log.info("recommendCate:{}", Arrays.toString(recommendCate));
	    
	    List<List<ShopVO>> filteredShopLists = new ArrayList<>();
	    for (String category : recommendCate) {
	        List<ShopVO> filteredShops = new ArrayList<>();
	        for (ShopVO shop : nearShops) {
	            String[] categories = shop.getCate().split(",");
	            if (Arrays.asList(categories).contains(category)) {
	                filteredShops.add(shop);
	                if (filteredShops.size() >= 5) {
	                    break; // 각 카테고리별로 5개 이상의 가게를 추천하고자 한다면 순회 종료
	                }
	            }
	        }
	        filteredShopLists.add(filteredShops);
	    }

	    // 추천 카테고리별 가게 리스트를 Map에 담아서 반환
        Map<String, List<ShopVO>> resultMap = new HashMap<>();
        for (int i = 0; i < recommendCate.length; i++) {
            resultMap.put(recommendCate[i], filteredShopLists.get(i));
        }

        return resultMap;
    }
}
