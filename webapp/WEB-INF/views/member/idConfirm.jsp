<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/idConfirm.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
</head>
<script type="text/javascript">
	window.history.forward();
	function noBack() {
		window.history.forward();
	}
</script>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="id-main">
		<p class="id-title">
			<span>■</span>아이디 찾기
		</p>
		
		<div class="id-content">
			<p class="id-result">${findMember.memberName }님의 아이디 조회결과, 입력하신 정보와 일치하는 아이디는 아래와 같습니다.</p>
			<div class="id-result-content">
				<div class="confirm-id">
					<p class="id-value">${findMember.memberId }</p>
				</div>
				<p class="warning">개인정보 도용에 따른 방지로 현재 페이지를 벗어나면 확인하실 수 없습니다.</p>
				<div class="guide-info">
					<p>더 많은 서비스를 이용하기 위해 <span>'메인으로'</span> 버튼을 누르시거나</p>
					<p>비밀번호를 찾으시려면 아래 <span>'비밀번호 찾기'</span> 버튼을 누르시면 됩니다.</p>
				</div>
				<div class="btn-idConfirm">
					<a class="btn-id id-home" href="/main">메인으로</a>
					<a class="btn-id id-pw" href="/find">비밀번호 찾기</a>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>