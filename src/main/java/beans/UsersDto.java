package beans;

public class UsersDto {

	// 1. Declarations
	private Integer usersIdx; // 기본 0으로 처리되지 않도록 하기 위해서 일부러 Integer로 함.
	private String usersId;
	private String usersPw;
	private String usersNick;
	private String usersEmail;
	private String usersPhone;
	private String usersGrade;

	// 2. Constructors
	public UsersDto() { super(); }
	public UsersDto(Integer usersIdx, String usersId, String usersPw, String usersNick, String usersEmail,
			String usersPhone, String usersGrade) {
		super();
		setUsersIdx(usersIdx);
		setUsersId(usersId);
		setUsersPw(usersPw);
		setUsersNick(usersNick);
		setUsersEmail(usersEmail);
		setUsersPhone(usersPhone);
		setUsersGrade(usersGrade);
	}

	// 3. Getters
	public Integer getUsersIdx () { return usersIdx  ; }
	public String getUsersId   () { return usersId   ; }
	public String getUsersPw   () { return usersPw   ; }
	public String getUsersNick () { return usersNick ; }
	public String getUsersEmail() { return usersEmail; }
	public String getUsersPhone() { return usersPhone; }
	public String getUsersGrade() { return usersGrade; }

	// 4. Setters
	public void setUsersIdx   (Integer userIdx   ) { this.usersIdx   = userIdx   ; }
	public void setUsersId    (String  userId    ) { this.usersId    = userId    ; }
	public void setUsersPw    (String  userPw    ) { this.usersPw    = userPw    ; }
	public void setUsersNick  (String  userNick  ) { this.usersNick  = userNick  ; }
	public void setUsersEmail (String  userEmail ) { this.usersEmail = userEmail ; }
	public void setUsersPhone (String  usersPhone) { this.usersPhone = usersPhone; }
	public void setUsersGrade (String  userGrade ) { this.usersGrade = userGrade ; }

	// 5. Methods - Overrided
	@Override
	public String toString() {
		return "UsersDto [usersIdx=" + usersIdx + ", usersId=" + usersId + ", usersPw=" + usersPw + ", usersNick="
				+ usersNick + ", usersEmail=" + usersEmail + ", usersPhone=" + usersPhone + ", usersGrade=" + usersGrade
				+ "]";
	}

}
