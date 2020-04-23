package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	
	public int write(EvaluationDTO evaluationDTO) {
/*
 ����ڴ� �Խñ��� �ۼ��ϰ�, �ø��� ��ư�� ������. 
 �� �Ŀ� �ٽ� �Խ��ǿ� ���ƿ�����, �ڽ��� ���� ������Ʈ�� �Խ����� ���� �ȴ�.
 
�� ��Ȳ�� �����ͺ��̽� �۾����� �ű��, ����ڰ� �ø��� ��ư�� ������ �� 
Insert���� ����Ͽ� ����ڰ� �Է��� �Խñ��� �����͸� �ű��. 
�׸��� �Խ����� ������ �����͸� �ٽ� Select������  �ֽ� ������ �����Ѵ�.
 */
		// ���Ǿ�(SQL)�� �̿��Ͽ� �����ͺ��̽��� ���� �ϴ� ��
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
		return -1; //DB ����
	}
	
	//��ϵ� ���� �� ���� ���������� ����ϰ�, �˻��� �� �ִ� ����� ����
	public ArrayList<EvaluationDTO> getList (String lectureDivide, 
			String searchType, String search, int pageNumber) {
		if (lectureDivide.equals("��ü")) {
			lectureDivide= "";
		}
		ArrayList<EvaluationDTO> evaluationList= null;
		String SQL= "";
		Connection conn= null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		try {
			//����ڰ� '�ֽż�', '��õ��'���� �˻��ϴ� ������ ���� ������ �ٸ��� �մϴ�.
			if (searchType.equals("�ֽż�")) { //�� ������ �� 5���� �� ���� ���
				SQL= "SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND CONCAT (lectureName, professorName, evaluationTitle, evaluationContent) LIKE " +
					"? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + "," + pageNumber * 5 + 6;
			} else if (searchType.equals("��õ��")) {
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
		// ��õ�� ������ Ư���� ���� ��õ ������ �����Ǵ� �Լ�
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
		return -1; // DB����
	}
	
	public int delete (String evaluationID) {
		//Ư���� ���� �� ���� ����� �Լ�
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
		return -1; // DB����
	}
	
	public String getUserID (String evaluationID) {
		//Ư���� ���� �� ���� �ۼ��� ������� ���̵� ���ϴ� �Լ�
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
		return null; // �������� �ʴ� ���� �򰡱�
	}
}
