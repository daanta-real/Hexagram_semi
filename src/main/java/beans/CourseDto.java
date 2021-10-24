package beans;

public class CourseDto {

	private int courseIdx; //코스번호
	private int usersIdx; //회원번호(작성자)
	private String courseSubject; //코스제목
	private String courseList; //코스목록
	private String courseLocations; //코스지역
	private String courseDetail; //코스내용
	private String courseTags; //코스태그
	public int getCourseIdx() {
		return courseIdx;
	}
	public void setCourseIdx(int courseIdx) {
		this.courseIdx = courseIdx;
	}
	public int getusersIdx() {
		return usersIdx;
	}
	public void setusersIdx(int usersIdx) {
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



}