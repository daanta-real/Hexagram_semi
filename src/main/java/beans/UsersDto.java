
package beans;

import java.sql.Date;
import java.util.regex.Pattern;

public class UsersDto {

	// 0. Final Fields
	public final static String REGEX_USERSID    = "^(?=[a-z].*)[a-z_\\d]{4,20}$";
	public final static String REGEX_USERSPW    = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[-_`~!?@#$%^&*=+/,.<>;:’”(){}[\\]])[a-zA-Z-_`~!?@#$%^&*=+/,.<>;:’”(){}[\\]]{4,20}$";
	public final static String REGEX_USERSEMAIL = "^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\\.([a-zA-Z])+$";
	public final static String REGEX_USERSNICK  = "^[a-zA-Zㄱ-ㅎ가-힣0-9]{2,10}$";
	public final static String REGEX_USERSPHONE = "^(01[016-9])\\d{4}\\d{4}$";

	// 1. Declarations
	private Integer usersIdx  ; // 기본 0으로 처리되지 않도록 하기 위해서 일부러 Integer로 함.
	private String  usersId   ;
	private String  usersPw   ;
	private String  usersNick ;
	private String  usersEmail;
	private String  usersPhone;
	private String  usersGrade;
	private Date    usersJoin ;
	private Integer usersPoint;

	// 2. Constructors
	public UsersDto() { super(); }
	public UsersDto(Integer usersIdx, String usersId, String usersPw, String usersNick, String usersEmail,
			String usersPhone, String usersGrade, Date usersJoin, int usersPoint) {
		super();
		setUsersIdx  (usersIdx  );
		setUsersId   (usersId   );
		setUsersPw   (usersPw   );
		setUsersNick (usersNick );
		setUsersEmail(usersEmail);
		setUsersPhone(usersPhone);
		setUsersGrade(usersGrade);
		setUsersJoin (usersJoin );
		setUsersPoint(usersPoint);
	}

	// 3. Getters
	public Integer getUsersIdx	 () { return usersIdx  ; }
	public String  getUsersId    () { return usersId   ; }
	public String  getUsersPw    () { return usersPw   ; }
	public String  getUsersNick	 () { return usersNick ; }
	public String  getUsersEmail () { return usersEmail == null ? "" : usersEmail; }
	public String  getUsersPhone () { return usersPhone == null ? "" : usersPhone; }
	public String  getUsersGrade () { return usersGrade; }
	public Date    getUsersJoin  () { return usersJoin ; }
	public Integer getUsersPoint () { return usersPoint; }

	// 4. Setters
	public void setUsersIdx   (Integer usersIdx   ) { this.usersIdx   = usersIdx   ; }
	public void setUsersId    (String  usersId    ) { this.usersId    = usersId    ; }
	public void setUsersPw    (String  usersPw    ) { this.usersPw    = usersPw    ; }
	public void setUsersNick  (String  usersNick  ) { this.usersNick  = usersNick  ; }
	public void setUsersEmail (String  usersEmail ) { this.usersEmail = usersEmail ; }
	public void setUsersPhone (String  usersPhone ) { this.usersPhone = usersPhone ; }
	public void setUsersGrade (String  usersGrade ) { this.usersGrade = usersGrade ; }
	public void setUsersJoin  (Date    usersJoin  ) { this.usersJoin  = usersJoin  ; }
	public void setUsersPoint (Integer usersPoint ) { this.usersPoint = usersPoint ; }

	// 5. Methods - Overrided
	@Override
	public String toString() {
		return "UsersDto [usersIdx=" + usersIdx + ", usersId=" + usersId + ", usersPw=" + usersPw + ", usersNick="
			+ usersNick + ", usersEmail=" + usersEmail + ", usersPhone=" + usersPhone + ", usersGrade=" + usersGrade
			+ ", usersJoin=" + usersJoin + ", usersPoint=" + usersPoint +"]";
	}

	// 6. Methods - Matches
	public static boolean matchUsersId   (String str) { return Pattern.matches(REGEX_USERSID   , str); }
	public static boolean matchUsersPw   (String str) { return Pattern.matches(REGEX_USERSPW   , str); }
	public static boolean matchUsersEmail(String str) { return Pattern.matches(REGEX_USERSEMAIL, str); }
	public static boolean matchUsersNick (String str) { return Pattern.matches(REGEX_USERSNICK , str); }
	public static boolean matchUsersPhone(String str) { return Pattern.matches(REGEX_USERSPHONE, str); }

}
