import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class UsersDto {

	// 1. 선언
	private Integer idx  ; // 기본 0으로 처리되지 않도록 하기 위해서 일부러 Integer로 함.
	private String  id   ;
	private String  pw   ;
	private String  nick ;
	private String  email;
	private String  grade;

	// 2. 생성자
	public UsersDto() { super(); }

	// 3. Getters/Setters
	public int    getIdx  ()             { return idx  ; }
	public String getId   ()             { return id   ; }
	public String getPw   ()             { return pw   ; }
	public String getNick ()             { return nick ; }
	public String getEmail()             { return email; }
	public String getGrade()             { return grade; }
	public void   setIdx  (int    idx  ) { this.idx   = idx  ; }
	public void   setId   (String id   ) { this.id    = id   ; }
	public void   setPw   (String pw   ) { this.pw    = pw   ; }
	public void   setNick (String nick ) { this.nick  = nick ; }
	public void   setEmail(String email) { this.email = email; }
	public void   setGrade(String grade) { this.grade = grade; }

	// 4. 메소드 - 오버라이드
	@Override
	public String toString() {
		return "UserDto [idx=" + idx + ", id=" + id + ", pw=" + pw + ", nick=" + nick + ", email=" + email + ", grade=" + grade + "]";
	}

	// 5. 메소드 - 기타
	// 아이디와 비번 문자열을 이용해, 로그인 검증용 해쉬를 만들어 줌
	public int getHash() {
		// 오늘 날짜를 문자열로 얻기 (YYYY-MM-DD 형식)
		Calendar         c         = Calendar.getInstance();
		Date             cTime     = c.getTime();
		SimpleDateFormat ymdSDF    = new SimpleDateFormat("YYYY-MM-DD");
		String           ymdString = ymdSDF.format(cTime);
		// ID문자열 + PW문자열 + 오늘날짜문자열 조합을 hashCode로 만들어 리턴
		String result = id + pw + ymdString;
		return result.hashCode();
	}

}