public class EventDto {

	// 1. 선언
	public int    idx     ;
	public int    usersIdx;
	public String subject ;
	public String detail  ;
	public String periods ;

	// 2. 생성자
	public EventDto( int idx ,         int usersIdx ,      String subject ,     String detail ,      String periods) {
		super(); setIdx (idx); setUsersIdx(usersIdx); setSubject (subject); setDetail (detail); setperiods (periods);
	}

	// 3. Getters/Setters
	public int    getIdx     () { return idx     ; }
	public int    getUsersIdx() { return usersIdx; }
	public String getSubject () { return subject ; }
	public String getDetail  () { return detail  ; }
	public String getperiods () { return periods ; }
	public void   setIdx     (int idx       ) { this.idx      = idx     ; }
	public void   setUsersIdx(int usersIdx  ) { this.usersIdx = usersIdx; }
	public void   setSubject (String subject) { this.subject  = subject ; }
	public void   setDetail  (String detail ) { this.detail   = detail  ; }
	public void   setperiods (String periods) { this.periods  = periods ; }

	// 4. 메소드 - 오버라이드
	@Override
	public String toString() {
		return "EventDto [idx=" + idx + ", usersIdx=" + usersIdx + ", subject=" + subject + ", detail=" + detail + ", periods=" + periods + "]";
	}

}