
public class itemDto {

	// 1. 선언
	private int    idx     ;
	private int    usersIdx;
	private String type    ;
	private String name    ;
	private String detail  ;
	private String tags    ;
	private String date    ; // String으로만 저장함. DATE 자료형 관련된 핸들링은 DAO에서 할 것
	private String periods ;

	// 2. 생성자
	public itemDto() { super(); } 
	public itemDto( int idx ,         int usersIdx ,  String type ,  String name ,    String detail ,  String tags ,  String date ,     String periods) {
		super(); setIdx(idx); setUsersIdx(usersIdx); setType(type); setName(name); setDetail(detail); setTags(tags); setDate(date); setPeriods(periods);
	}

	// 3. Getters/Setters
	public int    getIdx     () { return idx     ; }
	public int    getUsersIdx() { return usersIdx; }
	public String getType    () { return type    ; }
	public String getName    () { return name    ; }
	public String getDetail  () { return detail  ; }
	public String getTags    () { return tags    ; }
	public String getDate    () { return date    ; }
	public String getPeriods () { return periods ; }
	public void   setIdx     (int    idx     ) { this.idx      = idx     ; }
	public void   setUsersIdx(int    usersIdx) { this.usersIdx = usersIdx; }
	public void   setType    (String type    ) { this.type     = type    ; }
	public void   setName    (String name    ) { this.name     = name    ; }
	public void   setDetail  (String detail  ) { this.detail   = detail  ; }
	public void   setTags    (String tags    ) { this.tags     = tags    ; }
	public void   setDate    (String date    ) { this.date     = date    ; }
	public void   setPeriods (String periods ) { this.periods  = periods ; }

	// 4. 메소드 - 오버라이드
	@Override
	public String toString() {
		return "itemDto [idx=" + idx + ", usersIdx=" + usersIdx + ", type=" + type + ", name=" + name + ", detail="
				+ detail + ", tags=" + tags + ", date=" + date + ", periods=" + periods + "]";
	}

}
