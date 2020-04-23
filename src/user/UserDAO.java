package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;

public class UserDAO {

	public int login(String userID, String userPassword) {
		//login(): 아이디와 비밀번호를 받아서 로그인을 시도하는 함수. 결과는 정수형
		// 질의어(SQL)를 이용하여 데이터베이스를 접근 하는 것
		String SQL= "SELECT userPassword FROM USER WHERE userID= ?";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				} 
				else {
					return 0; //비번 틀림
				}
			}
			return -1; //아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -2; //DB 오류
	}


	public int join (UserDTO user) {
		//join(): 사용자의 정보를 입력 받아서 회원가입을 수행하는 함수. 결과는 정수형
		String SQL= "INSERT INTO USER VALUES (?, ?, ?, ?, false)";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1,user.getUserID());
			pstmt.setString(2,user.getUserPassword());
			pstmt.setString(3,user.getUserEmail());
			pstmt.setString(4,user.getUserEmailHash());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 회원가입 실패
	}
	
	// getUserEmail(): 사용자의 아이디를 이용해 이메일 주소를 알아냅니다
	public String getUserEmail (String userID) {
		
		// Select문으로  최신 정보로 유지
		String SQL= "SELECT userEmail FROM USER WHERE userID= ?";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); // 이메일 주소 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return null; // DB오류
	}
	
	//getUserEmailChecked(): 사용자가 현재 이메일 인증이 되었는지 확인하는 함수
	public boolean getUserEmailChecked (String userID) {
		
		// Select문으로  최신 정보로 유지
		String SQL= "SELECT userEmailChecked FROM USER WHERE userID= ?";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try { //에러가 발생할 수 있는 코드
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getBoolean(1); // 이메일 등록 여부 반환
			}
		} catch (Exception e) { //에러시 수행
			e.printStackTrace(); //오류 출력(방법은 여러가지)
		} finally { //데이터베이스와의 연결을 끊어주는 코드
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return false; // DB오류
}

	public boolean setUserEmailChecked (String userID) {
		//setUserEmailChecked(): 사용자의 이메일 인증
		String SQL= "UPDATE USER SET userEmailChecked= true WHERE userID= ?";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			pstmt.executeUpdate();
			return true; // 이메일 등록 설정 성공
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return false; // 이메일 등록 설정 실패
	}
}

