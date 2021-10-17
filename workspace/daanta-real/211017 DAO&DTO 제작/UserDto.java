public class UserDto {

	// 1. 선언
	private String idx     ;
	private String subject ;
	private String detail  ;
	private String ables   ;
	private String usersIdx;

	// 2. 생성자
	public UserDto(String idx,      String subject,     String detail,    String ables,       String usersIdx) {
		super();   setIdx(idx); setSubject(subject); setDetail(detail); setAbles(ables); setUsersIdx(usersIdx);
	}

	// 3. Getters/Setters
	public String getIdx     () { return idx     ; }
	public String getSubject () { return subject ; }
	public String getDetail  () { return detail  ; }
	public String getAbles   () { return ables   ; }
	public String getUsersIdx() { return usersIdx; }
	public void   setIdx     (String idx     ) { this.idx      = idx     ; }
	public void   setSubject (String subject ) { this.subject  = subject ; }
	public void   setDetail  (String detail  ) { this.detail   = detail  ; }
	public void   setAbles   (String ables   ) { this.ables    = ables   ; }
	public void   setUsersIdx(String usersIdx) { this.usersIdx = usersIdx; }

	// 4. 메소드 - 오버라이드
	@Override
	public String toString() {
		return "UserDto [idx=" + idx + ", subject=" + subject + ", detail=" + detail + ", ables=" + ables + ", usersIdx=" + usersIdx + "]";
	}

}