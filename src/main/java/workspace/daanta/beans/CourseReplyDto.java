package workspace.daanta.beans;

public class CourseReplyDto {

	// 1. Declarations
	private Integer courseReplyIdx;
	private Integer courseIdx;
	private Integer courseReplyUsersIdx;
	private Integer courseReplyTargetIdx;
	private String courseReplyDetail;

	// 2. Constructors
	public CourseReplyDto() {
		super();
	}

	public CourseReplyDto(Integer courseReplyIdx, Integer courseIdx, Integer courseReplyUsersIdx,
			Integer courseReplyTargetIdx, String courseReplyDetail) {
		super();
		this.setCourseReplyIdx(courseReplyIdx);
		this.setCourseIdx(courseIdx);
		this.setCourseReplyUsersIdx(courseReplyUsersIdx);
		this.setCourseReplyTargetIdx(courseReplyTargetIdx);
		this.setCourseReplyDetail(courseReplyDetail);
	}

	// 3. Getters/Setters
	public Integer getCourseReplyIdx() {
		return courseReplyIdx;
	}

	public void setCourseReplyIdx(Integer courseReplyIdx) {
		this.courseReplyIdx = courseReplyIdx;
	}

	public Integer getCourseIdx() {
		return courseIdx;
	}

	public void setCourseIdx(Integer courseIdx) {
		this.courseIdx = courseIdx;
	}

	public Integer getCourseReplyUsersIdx() {
		return courseReplyUsersIdx;
	}

	public void setCourseReplyUsersIdx(Integer courseReplyUsersIdx) {
		this.courseReplyUsersIdx = courseReplyUsersIdx;
	}

	public Integer getCourseReplyTargetIdx() {
		return courseReplyTargetIdx;
	}

	public void setCourseReplyTargetIdx(Integer courseReplyTargetIdx) {
		this.courseReplyTargetIdx = courseReplyTargetIdx;
	}

	public String getCourseReplyDetail() {
		return courseReplyDetail;
	}

	public void setCourseReplyDetail(String courseReplyDetail) {
		this.courseReplyDetail = courseReplyDetail;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "CourseReplyDto [courseReplyIdx=" + courseReplyIdx + ", courseIdx=" + courseIdx
				+ ", courseReplyUsersIdx=" + courseReplyUsersIdx + ", courseReplyTargetIdx=" + courseReplyTargetIdx
				+ ", courseReplyDetail=" + courseReplyDetail + "]";
	}

}
