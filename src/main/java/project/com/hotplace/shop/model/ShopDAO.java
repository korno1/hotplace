package project.com.hotplace.shop.model;

import java.util.List;


public interface ShopDAO {
	public int insert(ShopVO vo);

	public int update(ShopVO vo);
	
	public int updateRate(int num, int rate, int reviewCount);

	public int delete(ShopVO vo);
	
	public List<ShopVO> selectAllHome();
	
	public int countNum();

	public ShopVO selectOne(ShopVO vo);
	
	public List<ShopVO> searchList(String searchWord);

	public int decreaseReview(int shopNum);
}