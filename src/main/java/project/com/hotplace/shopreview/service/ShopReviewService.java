package project.com.hotplace.shopreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.com.hotplace.shopreview.model.ShopReviewDAO;
import project.com.hotplace.shopreview.model.ShopReviewVO;

@Slf4j
@Service
public class ShopReviewService {
	
	@Autowired
	ShopReviewDAO dao;
	
	public ShopReviewService() {
		log.info("ShopReviewService...");
	}
		
	public int insert(ShopReviewVO vo)
	{
		return dao.insert(vo);
	}

	public int update(ShopReviewVO vo)
	{
		return dao.update(vo);
	}

	public int delete(int num)
	{
		return dao.delete(num);
	}
	
	public List<ShopReviewVO> selectAll(ShopReviewVO vo)
	{
		return dao.selectAll(vo);
	}
	
	public ShopReviewVO selectOne(ShopReviewVO vo)
	{
		return dao.selectOne(vo);
	}
}
