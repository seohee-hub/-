<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="util.Gmail" %>
<%@ page import="java.io.PrintWriter" %> 

<%
	UserDAO userDAO= new UserDAO();
	String userID= null;
	if (session.getAttribute("userID") != null) {
		userID= (String) session.getAttribute("userID");
	}
	if (userID == null) {
	  PrintWriter script= response.getWriter();
      script.println("<script>");
      script.println("alert('로그인은 필수입니다!');");
      script.println("location.href='userLogin.jsp';");
      script.println("</script>");
      script.close();
      return;
	}
	boolean emailChecked= userDAO.getUserEmailChecked(userID);
	if (emailChecked==true) {
      PrintWriter script= response.getWriter();
      script.println("<script>");
      script.println("alert('이미 인증된 회원 입니다!');");
      script.println("location.href= 'index.jsp';");
      script.println("</script>");
      script.close();
      return;
   } 
	String host= "http://localhost:8080/Lecture_Evaluation/";
	String from= "vhsxm104@gmail.com";
	String to= userDAO.getUserEmail(userID);
	String subject= "강의평가 이메일 인증 메일입니다";
	String content= "다음 링크에 접속하여 이메일 인증을 진행하세요!" +
	"<br><a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이 링크를 누르시면 인증이 완료됩니다!</a>";
	
	Properties p= new Properties();
	p.put("mail.smtp.user",from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.user", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	try {
		Authenticator auth= new Gmail();
		Session ses= Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg= new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr= new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr= new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
		
	} catch (Exception e) {
		e.printStackTrace();
	    PrintWriter script= response.getWriter();
	    script.println("<script>");
	    script.println("alert('오류가 발생했습니다!');");
	    script.println("history.back();");
	    script.println("</script>");
	    script.close();
	    return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>강의평가</title>
	<!-- 부트스트랩 CSS 추가 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
    <nav class="navbar navbar-expand-md bg-light navbar-dark">
      <br><a class="navbar-brand" href="index.jsp" style="color:black;">지금까지 수강하신 강의를 평가해주세요!</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
      </button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp" style="color:black;">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown" style="color:black;">회원관리</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					<%
						if(userID==null) {
					%>
							<a class="dropdown-item" href="userLogin.jsp">로그인</a>
							<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
					<%
						} else {
					%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
					<%
						}
					%>
					</div>
				<li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0 mt-2">
       			 <input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
       			 <button class="btn btn-outline-success my-2 my-sm-0" type="submit" >검색</button>
      		</form>
		</div>
	</nav>
	<section class="container mt-3" style="max-width:560px;">
		<div class="alert alert-success mt-4" role="alert">
		이메일 인증 주소가 귀하의 메일로 전송되었습니다. 입력한 메일을 확인해주세요!
		</div>
	</section>
	<footer class="bg-dark mt-4 p-5 text-center" style="color:lightgrey;" >
		학기 말이나 시험이 끝난 직후, 대부분의 대학교에서는 학생들을 대상으로 강의평가를 실시하고 있습니다.
		<br>강의평가의 목적은 강의에 대한 질적 향상을 도모하여 학생들의 수업 만족도를 개선하고,
		<br>다음 학기에 새로 들을 학생들을 위해 자신의 의견을 공유해주세요!
		<br>
		<br>Copyright &copy; 2020 한서희 All Right Reserved.
	</footer>
	<!-- 제이쿼리 js 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 js 추가 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 js 추가 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>