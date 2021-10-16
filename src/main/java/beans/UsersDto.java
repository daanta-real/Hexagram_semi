package beans;

public class UsersDto {

	private int users_idx;			//회원번호
	private String users_id;			//회원아이디
	private String users_pw;		//회원비번
	private String users_nick;		//회원닉네임
	private String users_email;		//회원이메일
	private String users_phone;	//회원폰번
	private String users_grade;	//회원등급

	//기본생성자
	public UsersDto(int users_idx, String users_id, String users_pw, String users_nick, String users_email, String users_phone, String users_grade) {
		this.users_idx = users_idx;
		this.users_id = users_id;
		this.users_pw = users_pw;
		this.users_nick = users_nick;
		this.users_email = users_email;
		this.users_phone = users_phone;
		this.users_grade = users_grade;
	}	
	
	//getter
	public int getUsers_idx() {		return users_idx;		}
	public String getUsers_id() {	  return users_id;    	}
	public String getUsers_pw() { 	return users_pw;  	}
	public String getUsers_nick() {   	return users_nick;		}
	public String getUsers_email() {		return users_email;		}
	public String getUsers_phone() {		return users_phone;		}
	public String getUsers_grade() {		return users_grade;		}

	//setter
	public void setUsers_idx(int users_idx) {	this.users_idx = users_idx;	}
	public void setUsers_id(String users_id) {	this.users_id = users_id;	}	
	public void setUsers_pw(String users_pw) {	this.users_pw = users_pw;	}	
	public void setUsers_nick(String users_nick) { 	this.users_nick = users_nick;	}
	public void setUsers_email(String users_email) {		this.users_email = users_email;		}
	public void setUsers_phone(String users_phone) {	this.users_phone = users_phone;		}
	public void setUsers_grade(String users_grade) {	this.users_grade = users_grade;	}
	
	
}
