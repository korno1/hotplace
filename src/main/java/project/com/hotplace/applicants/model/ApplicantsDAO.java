package project.com.hotplace.applicants.model;

import java.util.List;

public interface ApplicantsDAO {
	public List<ApplicantsVO> selectAll(ApplicantsVO vo);
	
	public int insert(ApplicantsVO vo);
	public int approve(ApplicantsVO vo);
	public int reject(ApplicantsVO vo);
}
