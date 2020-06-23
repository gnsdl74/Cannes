<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/userPwdChangePage.css">
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
	
	<!-- container -->
	<div class="container">
		<p class="title">비밀번호 변경</p>
		<p class="sub-title">￭&nbsp;현재 비밀번호를 입력한 후 새로 사용할 비밀번호를 입력하세요.</p>
		<!-- pwd-input-bx -->
		<div class="pwd-input-bx">
			<table class="pwd-form">
				<tbody>
					<tr>
						<th>새 비밀번호</th>
						<td><input type="password" id="newPwd">&nbsp; ※ 영문, 숫자, 특수문자를 조합하여 8~16자리로 입력 해 주세요.</td>
					</tr>
					<tr>
						<th>새 비밀번호 재입력</th>
						<td><input type="password" id="newPwdCheck">&nbsp; ※ 비밀번호 확인을 위해 한 번 더 입력해 주시기 바랍니다.</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- // pwd-input-bx -->
		<ul class="warning">
			<li>￭&nbsp;생년월일, 전화번호 등 개인 정보와 관련된 숫자, 연속된 숫자와 같이 쉬운 비밀번호는 다른 사람이 쉽게 알아낼 수 있으니 사용을 자제해 주세요.</li>
			<li>￭&nbsp;비밀번호는 3-6개월마다 꼭 바꿔 주세요.</li>
			<li>￭&nbsp;비밀번호 변경시 홈페이지에서 모두 로그아웃됩니다. 변경한 비밀번호로 다시 로그인해주세요.</li>
		</ul>
		<div class="btn-group">
			<button id="cancel" type="button">취소</button>
			<button id="pwdUpdate" type="button">수정</button>
		</div>
	</div>
	<!-- // container -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			// 새 비밀번호에 입력
			$("#newPwd").on("keyup", function(e) {
				var newPwd = $("#newPwd").val();
				var regempty = / /gi;
				
				if(newPwd != "") {
					// 입력된 내용이 공백이라면 제거
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#newPwd").val(value);
					} else {
						if(e.keyCode == 13) {
							$("#newPwdCheck").focus();
						}
					}
				}
			}); // end newPwd keyup()
			
			$("#cancel").click(function() {
				location.href="/mypage";
			}); //end cancel click()
			
			// 새 비밀번호 재입력에 입력
			$("#newPwdCheck").on("keyup", function(e) {
				var pwdCheck = $("#newPwdCheck").val();
				var regempty = / /gi;
				
				if(pwdCheck != "") {
					// 입력된 내용이 공백이라면 제거
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#newPwdCheck").val(value);
					}
				}
			}); // end newPwdCheck keyup()
			
			$("#pwdUpdate").click(function() {
				var newPwd = $("#newPwd").val();
				var pwdCheck = $("#newPwdCheck").val();
				
					// 새 비밀번호와 확인의 형식 체크
					if(pwRegCheck(newPwd) && pwRegCheck(pwdCheck)) {
						// 새 비밀번호와 확인이 같은지 체크
						if(newPwd == pwdCheck) {
								var data = {
										"memberPw" : newPwd
								};
								
								$.ajax({
									type : "PUT",
									url : "/mypage/newPwdSettingPage",
									data : JSON.stringify(data),
									headers : {
										 "Content-Type": "application/json",
									     "X-HTTP-Method-Override" : "PUT"
									},
									success : function(result, status) {
										if(result == 1 && status == "success") {
											alert("비밀번호가 변경되었습니다.");
											location.href="/main";
										} else {
											alert("새로고침 후 다시 시도해주세요.");
										}
									},
									error : function(request, status, error) {
								    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
									}
								}); // end ajax()
						} else {
							alert("새 비밀번호가 일치하지 않습니다.");
						}
					} else {
						alert("비밀번호 형식이 아닙니다.");
					}
			}); // end pwdUpdate click()
			
			// 비밀번호 형식 체크
			function pwRegCheck(pw) {
				var regPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
				return regPw.test(pw);
			} // end pwRegCheck()
			
		}); // end document
	</script>
