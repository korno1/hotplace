package project.com.hotplace.shopreview.model;

import java.util.List;

public interface ShopReviewDAO {
	
	List<ShopReviewVO> selectAll(ShopReviewVO vo);
	
	
	int insert(ShopReviewVO vo);

	int update(ShopReviewVO vo);

	int delete(ShopReviewVO vo);
}
