<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %> 

<%
	//회원가입-> 사용자 정보를 데이터베이스에 등록-> 사용자의 이메일로 이메일을 전송하고 인증
	
	request.setCharacterEncoding("UTF-8");
	
	//로그인을 했을 때와 로그인을 하지 않았을 때를 세션으로 구분
	String userID= null;
	if (session.getAttribute("userID") != null) {
		userID= (String) session.getAttribute("userID");
	}
	if (userID != null) {
	   PrintWriter script= response.getWriter();
	   script.println("<script>");
	   script.println("alert('로그인이 이미 되어있습니다!');");
	   script.println("location.href='index.jsp';");
	   script.println("</script>");
	   script.close();
	   return;
	}
	String userPassword= null;
	String userEmail= null;
	if (request.getParameter("userID") != null) {
		userID= request.getParameter("userID");
	}
	if (request.getParameter("userPassword") != null) {
		userPassword= request.getParameter("userPassword");
	}
	if (request.getParameter("userEmail") != null) {
		userEmail= request.getParameter("userEmail");
	}
	if(userID==null || userPassword==null || userEmail==null) {
	      PrintWriter script= response.getWriter();
	      script.println("<script>");
	      script.println("alert('입력이 안 된 사항이 있습니다!');");
	      script.println("history.back();");
	      script.println("</script>");
	      script.close();
	      return;
	   }
	   UserDAO userDAO= new UserDAO();
	   int result= userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
	   if (result == -1) {
	      PrintWriter script= response.getWriter();
	      script.println("<script>");
	      script.println("alert('이미 존재하는 아이디 입니다!');");
	      script.println("history.back();");
	      script.println("</script>");
	      script.close();
	      return;
	   } else {
	      session.setAttribute("userID", userID);
	      PrintWriter script= response.getWriter();
	      script.println("<script>");
	      script.println("location.href= 'emailSendAction.jsp';");
	      script.println("</script>");
	      script.close();
	      return;
	   }
%>
