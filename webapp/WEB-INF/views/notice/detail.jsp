<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/noticeDetail.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<div class="notice-box">
		<p class="notice-title">공지사항</p>
		<!-- NoticeController에서 전송된 criteria에서 이전의 페이지 번호를 연결 -->
		<div class="notice-head">
			<input type="hidden" name="page" value="${criteria.page }" /> 
			<input type="hidden" name="perPage" value="${criteria.numsPerPage }" />
			<p id="head-name">${noticeVO.noticeTitle }</p>
			<fmt:formatDate value="${noticeVO.noticeDate }" pattern="yyyy.MM.dd" var="regdate" />
			<p>구분&nbsp;공지&nbsp;<span>｜</span>&nbsp;등록일&nbsp;${regdate }</p>
		</div>
		<div class="notice-body">
			<textarea rows="20" cols="100" readonly>${noticeVO.noticeContent }</textarea>
		</div>
		<a href="/notice?page=${criteria.page }&keyword=${keyword }">목록</a>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
