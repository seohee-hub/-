<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE HTML>
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
	request.setCharacterEncoding("UTF-8");
	String lectureDivide= "전체";
	String searchType= "최신순";
	String search= "";
	int pageNumber= 0;
	
	if (request.getParameter("lectureDivide") != null) {
		lectureDivide= request.getParameter("lectureDivide");
	}
	if (request.getParameter("searchType") != null) {
		searchType= request.getParameter("searchType");
	}
	if (request.getParameter("searchType") != null) {
		searchType= request.getParameter("searchType");
	}
	if (request.getParameter("search") != null) {
		search= request.getParameter("search");
	}
	if (request.getParameter("pageNumber") != null) {
		try {
			pageNumber= Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
	}
	String userID= null;
	if (session.getAttribute("userID") != null) {
		userID= (String) session.getAttribute("userID");
	}
	if (userID == null) {
	   PrintWriter script= response.getWriter();
	   script.println("<script>");
	   script.println("alert('로그인이 필요합니다!');");
	   script.println("location.href='userLogin.jsp';");
	   script.println("</script>");
	   script.close();
	   return;
	}
	boolean emailChecked= new UserDAO().getUserEmailChecked(userID);
	if (emailChecked == false) {
		PrintWriter script= response.getWriter();
		script.println("<script>");
		script.println("location.href='emailSendConfirm.jsp';");
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
	
	<img src="study.jpg" style="max-width:100%; height: auto !important; ">
	
	<div class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3" >
			<div>
				<select name="lectureDivide" class="form-control mx-1 mt-2">
					<option value="전체">전체</option>
					<option value="전공" <% if(lectureDivide.equals("전공")) out.println("selected"); %>>전공</option>
					<option value="교양" <% if(lectureDivide.equals("교양")) out.println("selected"); %>>교양</option>
					<option value="기타 " <% if(lectureDivide.equals("기타")) out.println("selected"); %>>기타</option>
				</select>
				<select name="searchType" class="form-control mx-1 mt-2">
					<option value="최신순">최신순</option>
					<option value="추천순" <% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
				</select>
				<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
				<button type="submit" class="btn btn-secondary mx-1 mt-2">검색</button>
			</div>
			<div>
				<a class="btn btn-primary mx-1 mt-2 "  data-toggle="modal" href="#registerModal">강의 평가하기</a>
				<a class="btn btn-danger mx-1 mt-2 "  data-toggle="modal" href="#reportModal">강의 신고하기</a>		
			</div>
		</form>

	<% 
	ArrayList<EvaluationDTO> evaluationList= new ArrayList<EvaluationDTO>();
	evaluationList= new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if (evaluationList != null)
		for (int i=0; i<evaluationList.size(); i++) {
			if (i==5) break;
			EvaluationDTO evaluation= evaluationList.get(i);
	%>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= evaluation.getLectureName() %>&nbsp;<small><%= evaluation.getProfessorName() %></small>
					</div>
					<div class="col-4 text-right">강의 평점: <span style="color:ForestGreen;"><%= evaluation.getTotalScore() %></span>
					</div>
				</div>
			</div>
			
		<div class="card-body">
			<h6 class="card-title"><%= evaluation.getEvaluationTitle() %>&nbsp;<small>(<%= evaluation.getLectureYear() %>년도 <%= evaluation.getSemesterDivide() %>)</small>
			</h6>
			<p class="card-text-left"><%= evaluation.getEvaluationContent() %></p>
				<div class="box" style="float:left; margin:10px;">
					난이도: <span style="color:red;"><%= evaluation.getLectureLevel() %></span>
					<br>내 성적: <span style="color:red;"><%= evaluation.getMyScore() %></span>
					<br>종합: <span style="color:red;"><%= evaluation.getTotalScore() %></span>
				</div>
				<div class="box" style="float:right; margin:10px;">
					<span style="color:green;">(추천수: <%= evaluation.getLikeCount() %>)</span>
					<br><a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">평가추천</a>
					<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>"><br>글삭제</a>
				</div>
			</div>
		</div>
	
	<%
		}
	%>
	</div>
		<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
	<%
		if (pageNumber <=0) {
	%>
		<a class= "page-link disabled">이전</a>
	<% 
		} else {
	%>
		<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8") %>
		&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>
		&pageNumber=<%= pageNumber -1 %>">이전</a>
	<%
		}
	%>
		</li>
		<li>
	<%
		if (evaluationList.size() < 6) {
	%>
		<a class= "page-link disabled">다음</a>
	<% 
		} else {
	%>
		<a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8") %>
		&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>
		&pageNumber=<%= pageNumber + 1 %>">다음</a>
	<%
		}
	%>
		</li>
	</ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label>
								<input type="text" name="lectureName" class="form=control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label>
								<input type="text" name="professorName" class="form=control" maxlength="20">
							</div>
							</div>
							<div class="form-row">
								<div class="form-group col-sm-4">
									<label>수강 연도</label>
									<select name="lectureYear" class="form-control">
										<option value="2015">2015</option>
										<option value="2016">2016</option>
										<option value="2017">2017</option>
										<option value="2018">2018</option>
										<option value="2019">2019</option>
										<option value="2020" selected>2020</option>
									</select>
								</div>
								<div class="form-group col-sm-4">
									<label>수강 학기</label>
									<select name="semesterDivide" class="form-control">
										<option value="1학기" selected>1학기</option>
										<option value="여름학기" >여름학기</option>
										<option value="2학기" >2학기</option>
										<option value="겨울학기" >겨울학기</option>
									</select>
								</div>
								<div class="form-group col-sm-4">
									<label>강의 구분</label>
									<select name="lectureDivide" class="form-control">
										<option value="전공" selected>전공</option>
										<option value="교양" >교양</option>
										<option value="기타" >기타</option>
									</select>
								</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수업 난이도</label>
								<select name="lectureLevel" class="form-control">
									<option value="매우 쉬움" selected>매우 쉬움</option>
									<option value="쉬움">쉬움</option>
									<option value="어려움">어려움</option>
									<option value="매우 어려움">매우 어려움</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>내 성적</label>
								<select name="myScore" class="form-control">
									<option value="A+ / A-" selected>A+ / A-</option>
									<option value="B+ / B-" >B+ / B-</option>
									<option value="C+ / C-" >C+ / C-</option>
									<option value="D+ / D-" >D+ / D-</option>
									<option value="F" >F</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>종합 점수</label>
								<select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondarty" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">교수님을 신고합니다! (익명 보장)</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height:180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">접수</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
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