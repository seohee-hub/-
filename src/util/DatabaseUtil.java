package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	//Connection �����ͺ��̽��� �����ϴ� ��ü
	public static Connection getConnection() {
		try { //�����ͺ��̽��� ���Ŀö��� ������ ���� ����� ������ try catch���� �ʼ�
			// �����ͺ��̽��� �����ϱ� ���� ����
			String dbURL= "jdbc:mysql://localhost:3306/LectureEvaluation?useSSL=false&serverTimezone=UTC";
			String dbID= "root";
			String dbPassword= "eldkfdl12";
			
			// Driver Class�� �ε��ϸ� ��ü�� �����ǰ�, DriverManager�� ���
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			// JDBC ����̹��� ���Ͽ� Connection�� ����� ����
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) { //������ ����
			e.printStackTrace(); //���� ���(����� ��������)
		}
		return null;
	}
}