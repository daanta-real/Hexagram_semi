
public class CourseDto {

	// 1. Declarations
	public Integer courseIdx;
	public Integer usersIdx;
	public String courseSubject;
	public String courseList;
	public String courseLocations;
	public String courseDetail;
	public String courseTags;

	// 2. Constructors
	public CourseDto(Integer courseIdx, Integer usersIdx, String courseSubject, String courseList,
			String courseLocations, String courseDetail, String courseTags) {
		super();
		setCourseIdx(courseIdx);
		setUsersIdx(usersIdx);
		setCourseSubject(courseSubject);
		setCourseList(courseList);
		setCourseLocations(courseLocations);
		setCourseDetail(courseDetail);
		setCourseTags(courseTags);
	}

	// 3. Getters/Setters
	private final Integer getCourseIdx() {
		return courseIdx;
	}

	private final void setCourseIdx(Integer courseIdx) {
		this.courseIdx = courseIdx;
	}

	private final Integer getUsersIdx() {
		return usersIdx;
	}

	private final void setUsersIdx(Integer usersIdx) {
		this.usersIdx = usersIdx;
	}

	private final String getCourseSubject() {
		return courseSubject;
	}

	private final void setCourseSubject(String courseSubject) {
		this.courseSubject = courseSubject;
	}

	private final String getCourseList() {
		return courseList;
	}

	private final void setCourseList(String courseList) {
		this.courseList = courseList;
	}

	private final String getCourseLocations() {
		return courseLocations;
	}

	private final void setCourseLocations(String courseLocations) {
		this.courseLocations = courseLocations;
	}

	private final String getCourseDetail() {
		return courseDetail;
	}

	private final void setCourseDetail(String courseDetail) {
		this.courseDetail = courseDetail;
	}

	private final String getCourseTags() {
		return courseTags;
	}

	private final void setCourseTags(String courseTags) {
		this.courseTags = courseTags;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "CourseDto [courseIdx=" + courseIdx + ", usersIdx=" + usersIdx + ", courseSubject=" + courseSubject
				+ ", courseList=" + courseList + ", courseLocations=" + courseLocations + ", courseDetail="
				+ courseDetail + ", courseTags=" + courseTags + "]";
	}

}
