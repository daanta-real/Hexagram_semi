package beans;

import java.sql.Date;
import java.text.Format;
import java.text.SimpleDateFormat;

public class CourseReplyDto {
	
	private int courseReplyIdx;
	private int usersIdx;
	private int courseIdx;
	private String courseReplyDetail;
	private Date courseReplyDate;
	private int courseReplySuperno;
	private int courseReplyGroupno;
	private int courseReplyDepth;
	
	
	public int getCourseReplyIdx() {
		return courseReplyIdx;
	}


	public void setCourseReplyIdx(int courseReplyIdx) {
		this.courseReplyIdx = courseReplyIdx;
	}


	public int getUsersIdx() {
		return usersIdx;
	}


	public void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}


	public int getCourseIdx() {
		return courseIdx;
	}


	public void setCourseIdx(int courseIdx) {
		this.courseIdx = courseIdx;
	}


	public String getCourseReplyDetail() {
		return courseReplyDetail;
	}


	public void setCourseReplyDetail(String courseReplyDetail) {
		this.courseReplyDetail = courseReplyDetail;
	}


	public Date getCourseReplyDate() {
		return courseReplyDate;
	}


	public void setCourseReplyDate(Date courseReplyDate) {
		this.courseReplyDate = courseReplyDate;
	}


	public int getCourseReplySuperno() {
		return courseReplySuperno;
	}


	public void setCourseReplySuperno(int courseReplySuperno) {
		this.courseReplySuperno = courseReplySuperno;
	}


	public int getCourseReplyGroupno() {
		return courseReplyGroupno;
	}


	public void setCourseReplyGroupno(int courseReplyGroupno) {
		this.courseReplyGroupno = courseReplyGroupno;
	}


	public int getCourseReplyDepth() {
		return courseReplyDepth;
	}


	public void setCourseReplyDepth(int courseReplyDepth) {
		this.courseReplyDepth = courseReplyDepth;
	}
	
	public String getCourseReplyTotalDate() {
		Format f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return f.format(this.courseReplyDate);
	}


	public CourseReplyDto() {
		super();
	}
	
	
}
