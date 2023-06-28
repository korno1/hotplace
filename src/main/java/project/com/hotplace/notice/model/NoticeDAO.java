package project.com.hotplace.notice.model;

import java.util.List;

public interface NoticeDAO {
	
	public List<NoticeVO> selectAll();
	
	public NoticeVO selectOne(NoticeVO vo);
	
	public List<NoticeVO> selectList(String searchKey, String searchWord);
	
	public int insert(NoticeVO vo);
	
	public int update(NoticeVO vo);
	
	public int delete(NoticeVO vo);
	
	public void vCountUp(NoticeVO vo);
}
