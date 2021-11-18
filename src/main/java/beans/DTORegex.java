package beans;

import util.users.Sessioner;

public class DTORegex {

	// 1. Common
	public final static String ISNUM = "^\\d.*$";

	// 2. Users
	public final static String USERSID    = "^(?=[a-z].*)[a-z_\\d]{4,20}$";
	public final static String USERSPW    = "^.*?[a-zA-Z0-9-]+$";
	public final static String USERSNICK  = "^[a-zA-Zㄱ-ㅎ가-힣0-9]{2,10}$";
	public final static String USERSEMAIL = "^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\\.([a-zA-Z])+$";
	public final static String USERSPHONE = "^(01[016-9])\\d{4}\\d{4}$";
	public final static String USERSGRADE = "^(" + Sessioner.GRADE_ADMIN + ")|(" + Sessioner.GRADE_REGULAR + ")|(" + Sessioner.GRADE_ASSOCIATE + ")$";

}
