<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/goodbye.css">
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
	
	<!-- container -->
	<div class="container">
		<!-- goodbye-content -->
		<div class="goodbye-content">
			<p class="goodbye-title">회원탈퇴</p>
			<p>[주의] Cannes 회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</p>
			<!-- goodbye-warning -->
			<div class="goodbye-warning">
				<ol>
					<li>
						<p class="txt">1. 30일간 회원 재가입이 불가능합니다.</p>
						<ul class="ul-list">
							<li>￭&nbsp;회원 탈퇴 후, 30일 경과 후 재가입할 수 있습니다.</li>
						</ul>
					</li>
					<li>
						<p class="txt">2. 탈퇴 후 삭제 내역</p>
						<p class="sub-txt">(회원 탈퇴하시면 회원정보가 삭제되며 데이터는 복구되지 않습니다.)</p>
						<ul class="ul-list">
							<li>￭&nbsp;영화 관람권</li>
							<li>￭&nbsp;예매 및 결제 내역</li>
							<li>￭&nbsp;간편 로그인 연동 정보</li>
						</ul>
					</li>
					<li>
						<p class="txt">3. 회원님의 비밀번호를 입력하시고 [탈퇴] 버튼을 클릭해주세요.</p>
						<div class="table-wrap">
							<table class="pwd-form">
								<tbody>
									<tr>
										<th id="pwd-check">비밀번호</th>
										<td>
											<input type="password" id="pwd">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</li>
				</ol>
			</div>
			<!-- // goodbye-warning -->
			<div class="btn-group">
				<button type="button" id="cancel">취소</button>
				<button type="button" id="delete">탈퇴</button>
			</div>
		</div>
		<!-- // goodbye-content -->
	</div>
	<!-- // container -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	$(document).ready(function() {
			$("#cancel").click(function() {
				location.href="/mypage";
			}); //end cancel click()
			
			$("#delete").click(function() {
				var pw = $("#pwd").val();
				var regempty = / /gi;
				
				if(pw != "") {
					// 입력된 내용이 공백이라면 제거
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#pwd").val(value);
					} else {
						var pwd = { "memberPw" : pw };
						
						$.ajax({
							type : "DELETE",
							url : "/mypage/goodbye",
							data : JSON.stringify(pwd),
							headers : {
						        "Content-Type": "application/json",
						        "X-HTTP-Method-Override" : "DELETE"
						    },
							success : function(result, status) {
								console.log(result + " 상태 : " + status);
								if(result == 1 && status == "success") {
									alert("탈퇴 처리되었습니다.");
									location.href="/main";
								} else {
									alert("비밀번호 정보가 잘못되었습니다.");
								}
							},
							error : function(request, status, error) {
						    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
							}
						}); // end ajax()
					}
					
				} else {
					alert("비밀번호를 입력해주세요.");
				}
			}); // end delete click()
			
		}); //end document
	</script>