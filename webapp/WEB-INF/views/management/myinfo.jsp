<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/myInfo.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<c:if test="${empty memberId }">
		<script type='text/javascript'>
			alert('로그인 후 이용가능한 서비스입니다.');
			location.href="/main";
		</script>
	</c:if>
	
	<div class="container">
		<div class="sub-location">
			<div class="sub-location-inner">
				<i class="material-icons">&#xe88a;</i>
				<p>> 마이페이지 > 회원정보</p>
			</div>
		</div>
		<div class="content">
		<p id="title">회원정보</p>
		<div class="input-pswd">
			<form id="infoFrm" method="post" onsubmit="return false">
				<strong>회원님의 개인정보 보호를 위해 비밀번호를 입력하셔야 합니다.</strong>
				<span>Cannes 로그인 시 사용하시는 비밀번호를 입력해 주세요.</span>
				<input type="hidden" id="confirmId" name="memberId" value="${memberId }">
				<input type="password" id="confirmPw" name="memberPw" title="비밀번호 입력" required />
			</form>
		</div>
			<div class="btn-confirm">
				<a href="javascript:history.back();">취소</a>
				<a href="#" id="pswdSubmit">확인</a>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function() {
			// 비밀번호의 값을 확인 
			$("#confirmPw").on("keyup", function() {
				var pw = $("#confirmPw").val();
				var regempty = / /gi;
				
				if(pw != "") {
					// 입력된 내용이 공백이라면 제거
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#confirmPw").val(value);
					}
				}
			}); // end confirmPw keyup()
			
			// 확인버튼을 클릭했을때
			$("#pswdSubmit").click(function() {
				var id = $("#confirmId").val();
				var pw = $("#confirmPw").val();
				console.log(id);
				console.log(pw);
				var member = {
						"memberId" : id,
						"memberPw" : pw
				};
				
				if(pw == "" || pw == null) {
					alert("비밀번호를 입력해주세요.");
					
				} else {
					$.ajax({
						type : "POST",
						url : "/mypage/confirm",
						data : JSON.stringify(member),
						headers: {
					        "Content-Type": "application/json",
					        "X-HTTP-Method-Override" : "POST"
					    },
						success : function(result, status) {
							console.log(result);
							console.log(status);
							if(result != null && status == "success") {
								console.log("성공");
								let url = "/mypage/user";
								$("#infoFrm").attr("onsubmit", "return true");
								$("#infoFrm").attr("action", url);
								$("#infoFrm").submit();
							} else {
								alert("비밀번호가 일치하지 않습니다.");
							}
						},
						error : function(request, status, error) {
					    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					}); // end ajax()
				}
			}); // end pswdSubmit click()
			
		}); // end document
	</script>