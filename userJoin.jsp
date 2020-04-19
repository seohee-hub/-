<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
<%
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
%>
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
		<form method="post" action="./userRegisterAction.jsp">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" name="userID" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="userPassword" class="form-control">
			</div>
			<div class="form-group">
				<label>이메일</label>
				<input type="email" name="userEmail" class="form-control">
			</div>
			<button type="submit" class="btn btn-primary">가입하기</button>
		</form>
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