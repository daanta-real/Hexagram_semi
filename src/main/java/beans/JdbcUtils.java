
package beans;

import java.sql.Connection;
import java.sql.DriverManager;

import system.Settings;

public class JdbcUtils {

	public static Connection connect(String username, String password) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@" + Settings.DBMS_ADDR + ":xe", username, password);
		return con;
	}
}

