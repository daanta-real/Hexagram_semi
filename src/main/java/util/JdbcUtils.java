
package util;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import system.Settings;

public class JdbcUtils {

	// 변수
	private static String ID = system.Settings.DBMS_ID;
	private static String PW = system.Settings.DBMS_PW;
	
	//connect()
	public static Connection connect() throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@" + Settings.DBMS_ADDR + ":xe", ID, PW);
		return con;
	}

	
	//connect2()
	//context.xml 에서 DB계정 아이디랑 비번 본인 쓰시는 계정으로 잘 맞춰서 쓰세요
	public static Connection connect2(String username, String password) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:xe", username, password);
		return con;
	}
	
	
	
	
	//context.xml에 있는 'jdbc/oracle'이라는 이름을 가진 자원의 참조 리모컨
	private static DataSource ds;
	
	static {
		try {
			Context ctx = new InitialContext(); //이름을 찾을때 initialContext사용(업캐스팅해서 사용)
			//ds = ctx.lookup("경로+이름"); context.xml파일의 Context까지를 알려주고 이름을 알려줌(탐색경로알려줌)
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle"); //다운캐스팅해서 꺼내야 함
		}
		catch(Exception e) {
			System.err.println("DataSource 생성오류");
			e.printStackTrace();
		}	
	}
	
	//connect3()
	public static Connection connect3() throws Exception{
		return ds.getConnection();
	}
}

