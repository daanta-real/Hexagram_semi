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

	//setter
	public void setUsersIdx(int usersIdx) {		this.usersIdx = usersIdx;		}
	public void setUsersId(String usersId) {	  this.usersId = usersId;		}
	public void setUsersPw(String usersPw) {		this.usersPw = usersPw;	 }
	public void setUsersNick(String usersNick) { 		this.usersNick = usersNick;		}
	public void setUsersEmail(String usersEmail) {	   this.usersEmail = usersEmail;		}
	public void setUsersPhone(String usersPhone) {	  this.usersPhone = usersPhone;		}
	public void setUsersGrade(String usersGrade) {		this.usersGrade = usersGrade;		}


}
