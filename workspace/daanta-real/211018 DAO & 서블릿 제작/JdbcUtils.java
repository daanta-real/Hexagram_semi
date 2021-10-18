import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JdbcUtils {

	// 변수
	private static String ID = system.Settings.DBMS_ID;
	private static String PW = system.Settings.DBMS_PW;

	// 접속
	public static Connection connect() throws ClassNotFoundException, SQLException {
		Class.forName("oracle.jdbc.OracleDriver");
		return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", ID, PW);
	}

}