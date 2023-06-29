package project.com.hotplace.notice.model;

import java.util.List;

public interface NoticeDAO {
	
	public List<NoticeVO> selectAll(String searchKey, String searchWord);
	
	public NoticeVO selectOne(NoticeVO vo);
	
	public List<NoticeVO> searchList(String searchKey, String searchWord, int page);
	
	public int insert(NoticeVO vo);
	
	public int update(NoticeVO vo);
	
	public int delete(NoticeVO vo);
	
	public void vCountUp(NoticeVO vo);
	
//	public void deleteOverDate();
}
