
public class CourseReplyDto {

	// 1. Declarations
	public Integer courseReplyIdx;
	public Integer courseIdx;
	public Integer courseReplyUsersIdx;
	public Integer courseReplyTargetIdx;
	public String courseReplyDetail;

	// 2. Constructors
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
	private final Integer getCourseReplyIdx() {
		return courseReplyIdx;
	}

	private final void setCourseReplyIdx(Integer courseReplyIdx) {
		this.courseReplyIdx = courseReplyIdx;
	}

	private final Integer getCourseIdx() {
		return courseIdx;
	}

	private final void setCourseIdx(Integer courseIdx) {
		this.courseIdx = courseIdx;
	}

	private final Integer getCourseReplyUsersIdx() {
		return courseReplyUsersIdx;
	}

	private final void setCourseReplyUsersIdx(Integer courseReplyUsersIdx) {
		this.courseReplyUsersIdx = courseReplyUsersIdx;
	}

	private final Integer getCourseReplyTargetIdx() {
		return courseReplyTargetIdx;
	}

	private final void setCourseReplyTargetIdx(Integer courseReplyTargetIdx) {
		this.courseReplyTargetIdx = courseReplyTargetIdx;
	}

	private final String getCourseReplyDetail() {
		return courseReplyDetail;
	}

	private final void setCourseReplyDetail(String courseReplyDetail) {
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
