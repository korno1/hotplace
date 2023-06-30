package project.com.hotplace.event.model;

import java.util.List;

public interface EventDAO {
	public List<EventVO> selectAll(String searchKey, String searchWord);
	
	public EventVO selectOne(EventVO vo);
	
	public List<EventVO> searchList(String searchKey, String searchWord, int page);
	
	public int insert(EventVO vo);
	
	public int update(EventVO vo);
	
	public int delete(EventVO vo);
	
	public void vCountUp(EventVO vo);
}
