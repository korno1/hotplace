package project.com.hotplace.shopreview.model;

import java.util.List;

public interface ShopReviewDAO {
	
	List<ShopReviewVO> selectAll(ShopReviewVO vo, int page);
	
	List<ShopReviewVO> selectAllReview(int shopNum);
	
	ShopReviewVO selectOne(ShopReviewVO vo);
	
	int insert(ShopReviewVO vo);

	int update(ShopReviewVO vo);
	
	int countNum();
	
	int count(ShopReviewVO vo);

	int delete(int num);
}
