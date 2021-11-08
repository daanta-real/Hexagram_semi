package beans;

import java.sql.Date;

public class CourseDto {

	private int courseIdx; 
	private int usersIdx; 
	private String courseName; 
	private String courseDetail; 
	private Date courseDate; 
	private int courseCountView; 
	private int courseCountReply; 
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