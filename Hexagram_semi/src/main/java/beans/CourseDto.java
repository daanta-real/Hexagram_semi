package beans;

public class CourseDto {
	
	private int courseIdx; //코스번호
	private int usersIdx; //회원번호(작성자)
	private String course_subject; //코스제목
	private String course_list; //코스목록
	private String course_locations; //코스지역
	private String course_detail; //코스내용
	private String course_tags; //코스태그
	public int getcourseIdx() {
		return courseIdx;
	}
	public void setcourseIdx(int courseIdx) {
		this.courseIdx = courseIdx;
	}
	public int getusersIdx() {
		return usersIdx;
	}
	public void setusersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}
	public String getCourse_subject() {
		return course_subject;
	}
	public void setCourse_subject(String course_subject) {
		this.course_subject = course_subject;
	}
	public String getCourse_list() {
		return course_list;
	}
	public void setCourse_list(String course_list) {
		this.course_list = course_list;
	}
	public String getCourse_locations() {
		return course_locations;
	}
	public void setCourse_locations(String course_locations) {
		this.course_locations = course_locations;
	}
	public String getCourse_detail() {
		return course_detail;
	}
	public void setCourse_detail(String course_detail) {
		this.course_detail = course_detail;
	}
	public String getCourse_tags() {
		return course_tags;
	}
	public void setCourse_tags(String course_tags) {
		this.course_tags = course_tags;
	}

	

}