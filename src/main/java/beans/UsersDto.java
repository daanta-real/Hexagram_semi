<<<<<<< HEAD
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
=======
package beans;

public class UsersDto {

	private int usersIdx;			//회원번호
	private String usersId;		//회원아이디
	private String usersPw;		//회원비번
	private String usersNick;		//회원닉네임
	private String usersEmail;	//회원이메일
	private String usersPhone;	//회원폰번
	private String usersGrade;	//회원등급

	//기본생성자
	public UsersDto() {
		super();
	}

	//getter
	public int getUsersIdx() {		return usersIdx;		}
	public String getUsersId() {		  return usersId;    	}
	public String getUsersPw() { 		return usersPw;  	}
	public String getUsersNick() {   	  return usersNick;		}
	public String getUsersEmail() {		   return usersEmail;		}
	public String getUsersPhone() {		return usersPhone;		}
	public String getUsersGrade() {		return usersGrade;		}
	public String getUsersEmailNull() {
		if(usersEmail == null) return "미입력";
		else return usersEmail;
	}
	public String getUsersPhoneNull() {
		if(usersPhone == null) return "미입력";
		else return usersPhone;
	}

	//setter
	public void setUsersIdx(int usersIdx) {		this.usersIdx = usersIdx;		}
	public void setUsersId(String usersId) {	  this.usersId = usersId;		}
	public void setUsersPw(String usersPw) {		this.usersPw = usersPw;	 }
	public void setUsersNick(String usersNick) { 		this.usersNick = usersNick;		}
	public void setUsersEmail(String usersEmail) {	   this.usersEmail = usersEmail;		}
	public void setUsersPhone(String usersPhone) {	  this.usersPhone = usersPhone;		}
	public void setUsersGrade(String usersGrade) {		this.usersGrade = usersGrade;		}


}
>>>>>>> branch 'main' of https://github.com/daanta-real/Hexagram_semi
