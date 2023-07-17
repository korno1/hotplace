package project.com.hotplace.shopreview.model;

import java.util.List;

public interface ShopReviewDAO {
	
	List<ShopReviewVO> selectAll(ShopReviewVO vo, int page);
	
	ShopReviewVO selectOne(ShopReviewVO vo);
	
	int insert(ShopReviewVO vo);

	int update(ShopReviewVO vo);
	
	public int countNum();
	
	public int count(ShopReviewVO vo);

	int delete(int num);
}
