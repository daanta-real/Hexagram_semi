import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class UsersDto {

	// 1. Declarations
	private Integer userIdx; // 기본 0으로 처리되지 않도록 하기 위해서 일부러 Integer로 함.
	private String userId;
	private String userPw;
	private String userNick;
	private String userEmail;
	private String userGrade;

	// 2. Constructors
	public UsersDto(Integer userIdx, String userId, String userPw, String userNick, String userEmail,
			String userGrade) {
		super();
		setUserIdx(userIdx);
		setUserId(userId);
		setUserPw(userPw);
		setUserNick(userNick);
		setUserEmail(userEmail);
		setUserGrade(userGrade);
	}

	// 3. Getters/Setters
	private final Integer getUserIdx() {
		return userIdx;
	}

	private final void setUserIdx(Integer userIdx) {
		this.userIdx = userIdx;
	}

	private final String getUserId() {
		return userId;
	}

	private final void setUserId(String userId) {
		this.userId = userId;
	}

	private final String getUserPw() {
		return userPw;
	}

	private final void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	private final String getUserNick() {
		return userNick;
	}

	private final void setUserNick(String userNick) {
		this.userNick = userNick;
	}

	private final String getUserEmail() {
		return userEmail;
	}

	private final void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	private final String getUserGrade() {
		return userGrade;
	}

	private final void setUserGrade(String userGrade) {
		this.userGrade = userGrade;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "UsersDto [userIdx=" + userIdx + ", userId=" + userId + ", userPw=" + userPw + ", userNick=" + userNick
				+ ", userEmail=" + userEmail + ", userGrade=" + userGrade + "]";
	}

	// 5. Methods - Common
	// 아이디와 비번 문자열을 이용해, 로그인 검증용 해쉬를 만들어 줌
	public int getHash() {
		// 오늘 날짜를 문자열로 얻기 (YYYY-MM-DD 형식)
		Calendar c = Calendar.getInstance();
		Date cTime = c.getTime();
		SimpleDateFormat ymdSDF = new SimpleDateFormat("YYYY-MM-DD");
		String ymdString = ymdSDF.format(cTime);
		// ID문자열 + PW문자열 + 오늘날짜문자열 조합을 hashCode로 만들어 리턴
		String result = userId + userPw + ymdString;
		return result.hashCode();
	}

}