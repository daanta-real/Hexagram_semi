package beans;

public class CourseItemDto {
	
	private int courseIdx; //코스번호
	private int usersIdx; //회원번호(작성자)
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
	public CourseItemDto() {
		super();
	}
}
