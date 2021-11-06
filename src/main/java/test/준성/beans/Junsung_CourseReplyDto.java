package test.준성.beans;

public class Junsung_CourseReplyDto {

	// 1. Declarations
	private Integer courseReplyIdx;
	private Integer courseReplyTargetIdx;
	private Integer courseIdx;
	private Integer usersIdx;
	private String courseReplyDetail;

	// 2. Constructors
	public Junsung_CourseReplyDto() {
		super();
	}

	public Junsung_CourseReplyDto(Integer courseReplyIdx, Integer courseIdx, Integer usersIdx,
			Integer courseReplyTargetIdx, String courseReplyDetail) {
		super();
		this.setCourseReplyIdx(courseReplyIdx);
		this.setCourseIdx(courseIdx);
		this.setUsersIdx(usersIdx);
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

	public Integer getCourseReplyTargetIdx() {
		return courseReplyTargetIdx;
	}

	public void setCourseReplyTargetIdx(Integer courseReplyTargetIdx) {
		this.courseReplyTargetIdx = courseReplyTargetIdx;
	}

	public Integer getCourseIdx() {
		return courseIdx;
	}

	public void setCourseIdx(Integer courseIdx) {
		this.courseIdx = courseIdx;
	}

	public Integer getUsersIdx() {
		return usersIdx;
	}

	public void setUsersIdx(Integer usersIdx) {
		this.usersIdx = usersIdx;
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
				+ ", usersIdx=" + usersIdx + ", courseReplyTargetIdx=" + courseReplyTargetIdx
				+ ", courseReplyDetail=" + courseReplyDetail + "]";
	}

}
