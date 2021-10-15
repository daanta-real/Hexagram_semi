package Jdbc.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JdbcUtils {
	
	public static Connection connect(String name, String password) throws ClassNotFoundException, SQLException {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdeb:oracle:thie:@localhost:1521:xe", name, password);
		return con;
	}
}
