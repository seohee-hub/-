package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	
	public int write(EvaluationDTO evaluationDTO) {
/*
 사용자는 게시글을 작성하고, 올리기 버튼을 누른다. 
 그 후에 다시 게시판에 돌아왔을때, 자신의 글이 업데이트된 게시판을 보게 된다.
 
이 상황을 데이터베이스 작업으로 옮기면, 사용자가 올리기 버튼을 눌렀을 때 
Insert문을 사용하여 사용자가 입력한 게시글의 데이터를 옮긴다. 
그리고 게시판을 구성할 데이터를 다시 Select문으로  최신 정보로 유지한다.
 */
		// 질의어(SQL)를 이용하여 데이터베이스를 접근 하는 것
		String SQL= "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID());
			pstmt.setString(2, evaluationDTO.getLectureName());
			pstmt.setString(3, evaluationDTO.getProfessorName());
			pstmt.setInt(4, evaluationDTO.getLectureYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide());
			pstmt.setString(6, evaluationDTO.getLectureDivide());
			pstmt.setString(7, evaluationDTO.getEvaluationTitle());
			pstmt.setString(8, evaluationDTO.getEvaluationContent());
			pstmt.setString(9, evaluationDTO.getLectureLevel());
			pstmt.setString(10, evaluationDTO.getMyScore());
			pstmt.setString(11, evaluationDTO.getTotalScore());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; //DB 오류
	}
	
	//등록된 강의 평가 글을 실질적으로 출력하고, 검색할 수 있는 기능을 구현
	public ArrayList<EvaluationDTO> getList (String lectureDivide, 
			String searchType, String search, int pageNumber) {
		if (lectureDivide.equals("전체")) {
			lectureDivide= "";
		}
		ArrayList<EvaluationDTO> evaluationList= null;
		String SQL= "";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			//사용자가 '최신순', '추천순'으로 검색하는 쿼리에 따라서 정렬을 다르게 합니다.
			if (searchType.equals("최신순")) { //한 페이지 당 5개씩 평가 글을 출력
				SQL= "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT (lectureName, professorName, evaluationTitle, evaluationContent) LIKE " +
					"? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + "," + pageNumber * 5 + 6;
			} else if (searchType.equals("추천순")) {
				SQL= "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT (lectureName, professorName, evaluationTitle, evaluationContent) LIKE " +
					"? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + "," + pageNumber * 5 + 6;
			}
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1,"%" + lectureDivide + "%");
			pstmt.setString(2,"%" + search + "%");
			rs= pstmt.executeQuery();
			evaluationList= new ArrayList<EvaluationDTO>();
			 
			while(rs.next()) {
				EvaluationDTO evaluation= new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getInt(13));
				evaluationList.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return evaluationList;
	}
	
	public int like (String evaluationID) {
		// 추천을 눌러서 특정한 글의 추천 갯수가 증가되는 함수
		String SQL= "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // DB오류
	}
	
	public int delete (String evaluationID) {
		//특정한 강의 평가 글을 지우는 함수
		String SQL= "DELETE FROM EVALUATION WHERE evaluationID = ?";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // DB오류
	}
	
	public String getUserID (String evaluationID) {
		//특정한 강의 평가 글을 작성한 사용자의 아이디를 구하는 함수
		String SQL= "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			rs= pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return null; // 존재하지 않는 강의 평가글
	}
}
