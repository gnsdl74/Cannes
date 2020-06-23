<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/setNewPw.css">
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
	
	<c:if test="${empty memberId }">
		<script type='text/javascript'>
			alert('로그인 후 이용가능한 서비스입니다.');
			location.href="/main";
		</script>
	</c:if>
	
	<div class="pw-main">
		<p class="pw-title">
			<span>■</span>비밀번호 변경
		</p>
		<!-- pw-content -->
		<div class="pw-content">
			<p class="info-pw">${idByNewPw }님의 새로운 비밀번호를 입력해주세요 !</p>
			<div class="input-pw">
				<input type="hidden" id="memberId" value="${idByNewPw }">
				<table class="pw-table">
					<tr>
						<th>비밀번호</th>
						<td>
							<input id="newPw" type="password" placeholder="비밀번호 입력">
							<label id="pwError"></label>
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input id="newPwCheck" type="password" placeholder="비밀번호 확인">
							<label id="pwCheckError"></label>
						</td>
					</tr>
				</table>
				<div class="guide-info">
					<p>비밀번호 설정 중 개인정보 유출에 주의하세요.</p>
					<p>본인의 부주의로 인한 개인정보 유출의 피해는 책임지지 않습니다.</p>
				</div>
				<button id="btnPwSend" type="button" disabled>비밀번호 변경</button>
			</div>
		</div>
		<!-- // pw-content -->
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var validPw = "N";
							var validPwCheck = "N";

							// 비밀번호 입력시
							$("#newPw").on(
									"keyup",
									function(e) {
										var inputPw = $("#newPw").val();
										// 비밀번호 형식에 맞는지 판단
										if (fn_pwCheck(inputPw)) {
											validPw = "Y";
											$("#pwError").text("");
										} else {
											validPw = "N";
											$("#pwError").text(
													"영문, 숫자, 특수문자 조합(8~16자)");
										}

										if (fn_btnPwSend()) {
											if (e.keyCode == 13) {
												$("#btnPwSend").click();
											}
										} else {
											if (e.keyCode == 13) {
												$("#newPwCheck").focus();
											}
										}
									}); // end newPw keyup()

							// 비밀번호와 비밀번호 확인
							$("#newPwCheck").on(
									"keyup",
									function(e) {
										// 입력한 비밀번호와 비밀번호 확인이 같은지
										var inputPw = $("#newPw").val();
										var inputPwCheck = $("#newPwCheck")
												.val();

										if (inputPw == inputPwCheck) {
											validPwCheck = "Y";
											$("#pwCheckError").text("");
										} else {
											validPwCheck = "N";
											$("#pwCheckError").text(
													"비밀번호가 일치하지 않습니다.");
										}

										if (fn_btnPwSend()) {
											if (e.keyCode == 13) {
												$("#btnPwSend").click();
											}
										}
									}); // end newPwCheck keyup()

							// 비밀번호 변경 클릭시 데이터 제출
							$("#btnPwSend").click(function() {
								var id = $("#memberId").val();
								var newPw = $("#newPw").val();
								console.log(id);
								
								$.ajax({
									type : "POST",
									url : "/newPwUpdate",
									data : {
										memberId : id,
										memberPw : newPw 
									},
									success : function(result) {
										if(result == "success") {
											alert("비밀번호 변경에 성공하였습니다.");
											location.href="/main";
										} else if(result == "fail") {
											alert("비밀번호 변경에 실패했습니다.\n다시 시도해주세요.");
										}
									}
								}); // end ajax()
							}); // end btnPwSend click()

							// 비밀번호 형식이 맞는지 확인
							function fn_pwCheck(inputPw) {
								var regPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
								return regPw.test(inputPw);
							} // end fn_pWCheck()

							// 비밀번호와 비밀번호 확인의 값이 같으면 비밀번호 변경 활성화
							function fn_btnPwSend() {
								if (validPw == "Y" && validPwCheck == "Y") {
									$("#btnPwSend").attr("disabled", false);
								} else {
									$("#btnPwSend").attr("disabled", true);
								}
							} // end fn_btnPwSend()
						}); // end document()
	</script>