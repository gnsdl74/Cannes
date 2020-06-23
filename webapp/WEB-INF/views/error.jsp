<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<jsp:include page="common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/error.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
	<jsp:include page="header.jsp"></jsp:include>

	<div>
		<div class="error-container">
			<img alt="Error_404" src="/resources/img/icon_error.png">
			<p class="error-page title">페이지를 찾을 수 없습니다.</p>
			<div class="error-content">
				<p class="error-page">방문하시려는 웹 페이지의 주소가 잘못 입력되었거나 변경 또는 삭제되어 요청하신 페이지를 찾을 수 없습니다.</p>
				<p class="error-page">입력하신 주소가 정확한지 다시 한 번 확인해 주시기 바랍니다.</p>
			</div>
			<div class="error-info">
				<img class="info-call" alt="Information_Call" src="/resources/img/call.jpg">
				<span>고객 센터</span>
				<em>1544-9999</em>
			</div>
			<div class="error-send">
				<a id="prev" href="javascript:history.back(-1);" title="이전 페이지 이동">이전 페이지 이동</a>
				<a id="main" href="/main" title="Cannes 메인으로 이동">Cannes 메인으로 이동</a>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
