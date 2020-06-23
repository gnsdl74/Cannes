<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
	<div align="center">
		<h1>이곳은 영화 메인 페이지입니다.</h1>
		<ol>
			<c:forEach var="movieList" items="${movieAll }">
				<li>${movieList.movieTitle }</li>
			</c:forEach>
		</ol>
	</div>
	
	<jsp:include page="footer.jsp"></jsp:include>
