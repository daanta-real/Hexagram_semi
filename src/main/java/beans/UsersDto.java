
package beans;

import java.sql.Date;
import java.util.regex.Pattern;

public class UsersDto {

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
	public UsersDto() throws Exception { super(); }
	public UsersDto(Integer usersIdx, String usersId, String usersPw, String usersNick, String usersEmail,
			String usersPhone, String usersGrade, Date usersJoin, int usersPoint) throws Exception {
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
	public String  getUsersEmail () { return usersEmail; }
	public String  getUsersPhone () { return usersPhone; }
	public String  getUsersGrade () { return usersGrade; }
	public Date    getUsersJoin  () { return usersJoin ; }
	public Integer getUsersPoint () { return usersPoint; }

	// 4. Setters
	public void setUsersIdx   (Integer usersIdx   ) throws Exception { if(!isValidUsersIdx  (usersIdx  )) throw new Exception(); else this.usersIdx   = usersIdx  ; }
	public void setUsersId    (String  usersId    ) throws Exception { if(!isValidUsersId   (usersId   )) throw new Exception(); else this.usersId    = usersId   ; }
	public void setUsersPw    (String  usersPw    ) throws Exception { if(!isValidUsersPw   (usersPw   )) throw new Exception(); else this.usersPw    = usersPw   ; }
	public void setUsersNick  (String  usersNick  ) throws Exception { if(!isValidUsersNick (usersNick )) throw new Exception(); else this.usersNick  = usersNick ; }
	public void setUsersEmail (String  usersEmail ) throws Exception { if(!isValidUsersEmail(usersEmail)) throw new Exception(); else this.usersEmail = usersEmail; }
	public void setUsersPhone (String  usersPhone ) throws Exception { if(!isValidUsersPhone(usersPhone)) throw new Exception(); else this.usersPhone = usersPhone; }
	public void setUsersGrade (String  usersGrade ) throws Exception { if(!isValidUsersGrade(usersGrade)) throw new Exception(); else this.usersGrade = usersGrade; }
	public void setUsersJoin  (Date    usersJoin  ) throws Exception { this.usersJoin  = usersJoin; }
	public void setUsersPoint (Integer usersPoint ) throws Exception { if(!isValidUsersPoint(usersPoint)) throw new Exception(); else this.usersPoint = usersPoint; }

	// 5. Methods - Overrided
	@Override
	public String toString() {
		return "UsersDto [usersIdx=" + usersIdx + ", usersId=" + usersId + ", usersPw=" + usersPw + ", usersNick="
			+ usersNick + ", usersEmail=" + usersEmail + ", usersPhone=" + usersPhone + ", usersGrade=" + usersGrade
			+ ", usersJoin=" + usersJoin + ", usersPoint=" + usersPoint +"]";
	}

	// 6. Methods - Valid value tester
	public static boolean isValidUsersIdx  (Integer num) { return num != null; }
	public static boolean isValidUsersId   (String  str) { return str != null && str != "" && Pattern.matches(DTORegex.USERSID   , str); }
	public static boolean isValidUsersPw   (String  str) { return str != null && str != "" && Pattern.matches(DTORegex.USERSPW   , str); }
	public static boolean isValidUsersNick (String  str) { return str != null && str != "" && Pattern.matches(DTORegex.USERSNICK , str); }
	public static boolean isValidUsersEmail(String  str) { return str != null && str != "" && Pattern.matches(DTORegex.USERSEMAIL, str); }
	public static boolean isValidUsersPhone(String  str) { return str == null || str == "" || Pattern.matches(DTORegex.USERSPHONE, str); }
	public static boolean isValidUsersGrade(String  str) { return str != null && str != "" && Pattern.matches(DTORegex.USERSGRADE, str); }
	public static boolean isValidUsersPoint(Integer num) { return num != null; }

}
