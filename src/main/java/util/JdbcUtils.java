
package util;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JdbcUtils {

	// 1. 멤버 변수 정의

	// 1-1. JDBC용 변수
	// src/main/java/system/Settings.java 참조
	private static String ADDR = system.Settings.DBMS_ADDR;
	private static String ID   = system.Settings.DBMS_ID;
	private static String PW   = system.Settings.DBMS_PW;

	// 1-2. DBCP용 변수
	// src/main/webapp/META-INF/context.xml 참조 ('jdbc/oracle')
	private static DataSource ds;
	static {
		try {
			Context ctx = new InitialContext(); // 이름을 찾을 때 initialContext 사용(업캐스팅해서 사용)
			// ds = ctx.lookup("경로+이름"); context.xml파일의 Context까지를 알려주고 이름을 알려줌(탐색경로알려줌)
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle"); // 다운캐스팅해서 꺼내야 함
		}
		catch(Exception e) {
			System.err.println("DataSource 생성오류");
			e.printStackTrace();
		}
	}



	// 2. 메소드 정의

	// 2-1. JDBC 자동 접속
	// 이름: connect()
	// 용도: ID/비번 등을 입력할 거 없이 자동으로 접속하고 싶을 때 사용
	public static Connection connect() throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@" + ADDR, ID, PW);
		return con;
	}

	// 2-2. JDBC 수동 접속
	// 이름: connect2()
	// 용도: ID, PW, 주소를 직접 입력해서 접속하고 싶은 경우 사용
	public static Connection connect2(String address, String username, String password) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@" + address, username, password);
		return con;
	}

	// 2-3. DBCP 접속
	// 이름: connect3()
	// 용도: 커넥션 풀을 적용하여 접속할 경우 사용
	//      ※ ID/PW 등은 META-INF/context.xml 를 직접 수정 입력할 것 (비공유)
	public static Connection connect3() throws Exception {
		return ds.getConnection();
	}

}

