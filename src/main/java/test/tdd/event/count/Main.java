package test.tdd.event.count;

import java.sql.Connection;

import beans.EventDao;

public class Main { @SuppressWarnings("unused")
public static void main(String[] args) {
	try {
		Connection conn = util.JdbcUtils.connect3();
	} catch (Exception e1) {
		System.out.println("에러");
		e1.printStackTrace();
	}

	try {
		EventDao dao = new EventDao();
		Integer count = dao.count();
		System.out.println(count);
	} catch(Exception e) {
		System.out.println("오류 발생");
		e.printStackTrace();
	}
} }