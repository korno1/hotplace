package project.com.hotplace.memberreview.model;

import java.util.List;

public interface MemberReviewDAO {

	public List<MemberReviewVO> selectAll(MemberReviewVO vo);

	public int insert(MemberReviewVO vo);

	public int update(MemberReviewVO vo);

	public int delete(MemberReviewVO vo);

}
