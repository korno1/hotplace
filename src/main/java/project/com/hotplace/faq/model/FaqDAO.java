package project.com.hotplace.faq.model;

import java.util.List;

public interface FaqDAO {
	public List<FaqVO> selectAll(String searchKey, String searchWord);
	
	public FaqVO selectOne(FaqVO vo);
	
	public List<FaqVO> searchList(String searchKey, String searchWord, int page);
	
	public int insert(FaqVO vo);
	
	public int update(FaqVO vo);
	
	public int delete(FaqVO vo);
}
