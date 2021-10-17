
public class CourseDto {

	// 1. 선언
	public int    idx      ;
	public int    usersIdx ;
	public String subject  ;
	public String list     ;
	public String locations;
	public String detail   ;
	public String tags     ;

	// 2. 생성자
	public CourseDto(int    idx,          int usersIdx,      String subject,   String list,        String locations,     String detail,   String tags) {
		super();     setIdx(idx); setUsersIdx(usersIdx); setSubject(subject); setList(list); setLocations(locations); setDetail(detail); setTags(tags);
	}

	// 3. Getters/Setters
	public int    getIdx      () { return idx      ; }
	public int    getUsersIdx () { return usersIdx ; }
	public String getSubject  () { return subject  ; }
	public String getList     () { return list     ; }
	public String getLocations() { return locations; }
	public String getDetail   () { return detail   ; }
	public String getTags     () { return tags     ; }
	public void   setIdx      (int    idx      ) { this.idx       = idx      ; }
	public void   setUsersIdx (int    usersIdx ) { this.usersIdx  = usersIdx ; }
	public void   setSubject  (String subject  ) { this.subject   = subject  ; }
	public void   setList     (String list     ) { this.list      = list     ; }
	public void   setLocations(String locations) { this.locations = locations; }
	public void   setDetail   (String detail   ) { this.detail    = detail   ; }
	public void   setTags     (String tags     ) { this.tags      = tags     ; }

	// 4. 메소드 - 오버라이드
	@Override
	public String toString() {
		return "CourseDto [idx=" + idx + ", usersIdx=" + usersIdx + ", subject=" + subject + ", list=" + list
				+ ", locations=" + locations + ", detail=" + detail + ", tags=" + tags + "]";
	}

}
