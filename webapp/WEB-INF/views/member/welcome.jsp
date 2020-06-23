<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/welcome.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="welcome-container">
		<div class="step-member"
			title="step1 약관동의, step2 정보입력, step3 가입완료 단계 중 step3 가입완료 단계">
			<ol>
				<li>
					<p class="step">
						<em>STEP1.</em> <span>약관동의</span>
					</p>
				</li>
				<li>
					<p class="step">
						<em>STEP2.</em> <span>정보입력</span>
					</p>
				</li>
				<li>
					<p class="step on">
						<em>STEP3.</em> <span>가입완료</span>
					</p>
				</li>
			</ol>
		</div>
		<div class="welcome-title">환영합니다 !</div>
		<div class="welcome-first">
			<p>
				<span>${name }</span>님, 회원가입을 축하합니다.
			</p>
			<p>
				Cannes의 새로운 아이디는 <span id="memberId">${id }</span>입니다.
			</p>
		</div>
		<div class="welcome-second">
			<p>일상 속 색다른 경험을 드리겠습니다.</p>
			<p>보다 즐거운 하루를 위해</p>
			<a href="/booking">영화보러가기</a>
		</div>
		<a id="welcome-start" href="/main">시작하기</a>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>