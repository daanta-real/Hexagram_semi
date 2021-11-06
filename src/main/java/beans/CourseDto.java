package beans;

import java.sql.Date;

public class CourseDto {

	private int courseIdx; //코스번호
	private int usersIdx; //회원번호(작성자)
	private String courseName; //코스제목
	private String courseDetail; //코스내용
	private Date courseDate; //코스목록
	private int courseCountView; //코스지역
	private int courseCountReply; //코스태그
	public int getCourseIdx() {
		return courseIdx;
	}
	public void setCourseIdx(int courseIdx) {
		this.courseIdx = courseIdx;
	}
	public int getUsersIdx() {
		return usersIdx;
	}
	public void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getCourseDetail() {
		return courseDetail;
	}
	public void setCourseDetail(String courseDetail) {
		this.courseDetail = courseDetail;
	}
	public Date getCourseDate() {
		return courseDate;
	}
	public void setCourseDate(Date courseDate) {
		this.courseDate = courseDate;
	}
	public int getCourseCountView() {
		return courseCountView;
	}
	public void setCourseCountView(int courseCountView) {
		this.courseCountView = courseCountView;
	}
	public int getCourseCountReply() {
		return courseCountReply;
	}
	public void setCourseCountReply(int courseCountReply) {
		this.courseCountReply = courseCountReply;
	}
	public CourseDto() {
		super();
	}

	
}