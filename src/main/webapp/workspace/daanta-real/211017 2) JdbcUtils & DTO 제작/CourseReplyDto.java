
public class CourseReplyDto {

	// 1. 선언
	public int    idx      ;
	public int    courseIdx;
	public int    usersIdx ;
	public int    targetIdx;
	public String detail   ;

	// 2. 생성자
	public CourseReplyDto() { super(); }
	public CourseReplyDto(int idx ,          int courseIdx ,         int usersIdx ,          int targetIdx ,    String detail) {
		super();       setIdx(idx); setCourseIdx(courseIdx); setUsersIdx(usersIdx); setTargetIdx(targetIdx); setDetail(detail);
	}

	// 3. Getters/Setters
	public int    getIdx      () { return idx      ; }
	public int    getCourseIdx() { return courseIdx; }
	public int    getUsersIdx () { return usersIdx ; }
	public int    getTargetIdx() { return targetIdx; }
	public String getDetail   () { return detail   ; }
	public void   setIdx      (int    idx      ) { this.idx       = idx      ; }
	public void   setCourseIdx(int    courseIdx) { this.courseIdx = courseIdx; }
	public void   setUsersIdx (int    usersIdx ) { this.usersIdx  = usersIdx ; }
	public void   setTargetIdx(int    targetIdx) { this.targetIdx = targetIdx; }
	public void   setDetail   (String detail   ) { this.detail    = detail   ; }

	// 4. 메소드 - 오버라이드
	@Override
	public String toString() { return "CourseReplyDto [idx=" + idx + ", courseIdx="
			+ courseIdx + ", usersIdx=" + usersIdx + ", targetIdx=" + targetIdx + ", detail=" + detail + "]";
	}

}
