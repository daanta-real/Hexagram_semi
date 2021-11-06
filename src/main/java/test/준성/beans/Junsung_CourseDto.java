package test.준성.beans;

public class Junsung_CourseDto {

	// 1. Declarations
	private Integer courseIdx;
	private Integer usersIdx;
	private String courseSubject;
	private String courseList;
	private String courseLocations;
	private String courseDetail;
	private String courseTags;

	// 2. Constructors
	public Junsung_CourseDto() {
		super();
	}
	public Junsung_CourseDto(Integer courseIdx, Integer usersIdx, String courseSubject, String courseList,
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

	public String getCourseSubject() {
		return courseSubject;
	}

	public void setCourseSubject(String courseSubject) {
		this.courseSubject = courseSubject;
	}

	public String getCourseList() {
		return courseList;
	}

	public void setCourseList(String courseList) {
		this.courseList = courseList;
	}

	public String getCourseLocations() {
		return courseLocations;
	}

	public void setCourseLocations(String courseLocations) {
		this.courseLocations = courseLocations;
	}

	public String getCourseDetail() {
		return courseDetail;
	}

	public void setCourseDetail(String courseDetail) {
		this.courseDetail = courseDetail;
	}

	public String getCourseTags() {
		return courseTags;
	}

	public void setCourseTags(String courseTags) {
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
