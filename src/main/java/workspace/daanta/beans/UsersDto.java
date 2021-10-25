package workspace.daanta.beans;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class UsersDto {

	// 1. Declarations
	private Integer usersIdx; // 기본 0으로 처리되지 않도록 하기 위해서 일부러 Integer로 함.
	private String usersId;
	private String usersPw;
	private String usersNick;
	private String usersEmail;
	private String usersGrade;

	// 2. Constructors
	public UsersDto() {
		super();
	}

	public UsersDto(Integer usersIdx, String usersId, String usersPw, String usersNick, String usersEmail,
			String usersGrade) {
		super();
		setUsersIdx(usersIdx);
		setUsersId(usersId);
		setUsersPw(usersPw);
		setUsersNick(usersNick);
		setUsersEmail(usersEmail);
		setUsersGrade(usersGrade);
	}

	// 3. Getters/Setters
	public final Integer getUsersIdx() {
		return usersIdx;
	}

	public final void setUsersIdx(Integer userIdx) {
		this.usersIdx = userIdx;
	}

	public final String getUsersId() {
		return usersId;
	}

	public final void setUsersId(String userId) {
		this.usersId = userId;
	}

	public final String getUsersPw() {
		return usersPw;
	}

	public final void setUsersPw(String userPw) {
		this.usersPw = userPw;
	}

	public final String getUsersNick() {
		return usersNick;
	}

	public final void setUsersNick(String userNick) {
		this.usersNick = userNick;
	}

	public final String getUsersEmail() {
		return usersEmail;
	}

	public final void setUsersEmail(String userEmail) {
		this.usersEmail = userEmail;
	}

	public final String getUsersGrade() {
		return usersGrade;
	}

	public final void setUsersGrade(String userGrade) {
		this.usersGrade = userGrade;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "UsersDto [usersIdx=" + usersIdx + ", usersId=" + usersId + ", usersPw=" + usersPw + ", usersNick="
				+ usersNick + ", usersEmail=" + usersEmail + ", usersGrade=" + usersGrade + "]";
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
		String result = usersId + usersPw + ymdString;
		return result.hashCode();
	}

}