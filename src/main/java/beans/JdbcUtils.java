
package beans;

import java.sql.Connection;
import java.sql.DriverManager;

import system.Settings;

public class JdbcUtils {

	// 변수
	private static String ID = system.Settings.DBMS_ID;
	private static String PW = system.Settings.DBMS_PW;

	public static Connection connect() throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@" + Settings.DBMS_ADDR + ":xe", ID, PW);
		return con;
	}
}

