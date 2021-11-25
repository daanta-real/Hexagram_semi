package beans;

public class CourseLikeDto {
	private int usersIdx; 
	private int courseIdx;
	
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
	public CourseLikeDto() {
		super();
	} 
	
}
