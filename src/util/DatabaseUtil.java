package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	//Connection 데이터베이스와 연결하는 객체
	public static Connection getConnection() {
		try { //데이터베이스를 거쳐올때는 변수가 많이 생기기 때문에 try catch문은 필수
			// 데이터베이스에 연결하기 위한 정보
			String dbURL= "jdbc:mysql://localhost:3306/LectureEvaluation?useSSL=false&serverTimezone=UTC";
			String dbID= "root";
			String dbPassword= "eldkfdl12";
			
			// Driver Class를 로딩하면 객체가 생성되고, DriverManager에 등록
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// JDBC 드라이버를 통하여 Connection을 만드는 역할
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) { //에러시 수행
			e.printStackTrace(); //오류 출력(방법은 여러가지)
		}
		return null;
	}
}