<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/user.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="container">
		<div class="sub-location">
			<div class="sub-location-inner">
				<i class="material-icons">&#xe88a;</i>
				<p>> 마이페이지 > 회원정보 > 개인정보 수정</p>
			</div>
		</div>
		<!-- user-infobox -->
		<div class="user-infobox">
			<p id="infobox-title">개인정보 수정</p>
			<p id="infobox-subtitle">
				<span>기본정보</span>&nbsp;·&nbsp;회원님의 정보를 정확히 입력해주세요.<span id="right"><em class="font-orange">*</em>&nbsp;필수</span>
			</p>
			<div style="display: none;">
				<input type="hidden" id="memberId" name="memberId" value="${userInfo.memberId }">
				<input type="hidden" id="existName" name="memberName" value="${userInfo.memberName }">
				<fmt:formatDate value="${userInfo.memberBirth }" pattern="yyyy년 MM월 dd일" var="regdate" />
				<input type="hidden" name="memberBirth" value="${regdate }">
				<input type="hidden" id="existPhone" name="memberPhone" value="${userInfo.memberPhone }">
				<input type="hidden" name="memberEmail" value="${userInfo.memberEmail }" >
			</div>
			<!-- user-info -->
			<div class="user-info">
				<table>
					<tbody>
						<tr>
							<th>아이디</th>
							<td>${userInfo.memberId }<a id="leave" href="/mypage/goodbye">회원 탈퇴</a></td>
						</tr>
						<tr>
							<th>이름 <em class="font-orange">*</em></th>
							<td>${userInfo.memberName }&nbsp;<a href="#" id="btnName">이름변경</a>&nbsp;<span id="nameInfo">※ 개명으로 이름이 변경된 경우, 회원정보의 이름을 변경하실 수 있습니다.</span>
							<div id="nameDiv">
								<input class="changebx" type="hidden" id="changeName">
								<p class="warning" id="warningName"></p>
							</div>
							</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td>${regdate }</td>
						</tr>
						<tr>
							<th>휴대폰 <em class="font-orange">*</em></th>
							<td>
								<div>
									<p id="formatPhone"></p>
									<a href="#" id="btnPhone">휴대폰번호 변경</a>
								</div>
								<div id="phoneDiv">
									<input class="changebx" type="hidden" id="changePhone">
									<p class="warning" id="warningPhone"></p>
								</div>
							</td>
						</tr>
						<tr>
							<th>이메일 <em class="font-orange">*</em></th>
							<td><input id="emailInfo" type="text" value="${userInfo.memberEmail }">
								<p class="warning" id="warningEmail"></p>
							</td>
						</tr>
						<tr>
							<th>비밀번호 <em class="font-orange">*</em></th>
							<td><a href="/mypage/userPwdChangePage">비밀번호 변경</a></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- // user-info -->
			
			<!-- info-submit -->
			<div class="info-submit">
				<!-- 취소하면 mypage로 -->
				<button type="button" id="cancel">취소</button>
				<!-- 등록하면 회원정보 수정 -->
				<button type="button" id="update">등록</button>
			</div>
			<!-- // info-submit -->
		</div>
		<!-- // user-infobox -->
	</div>
	<!-- // container -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript">
		$(document).ready(function() {
			var nameFlag = false;
			var phoneFlag = false;
			var emailFlag = true;
			
			var beforePhone = $("#existPhone").val();
			console.log(beforePhone);
			// 휴대폰 번호에 '-'을 붙여서 화면 출력
			phoneFormat(beforePhone);
			
			$("#cancel").click(function() {
				location.href="/mypage";
			}); //end cancel click()
			
			$("#btnName").click(function(e) {
				e.preventDefault();
				var btnText = $("#btnName").text();
				
				if(btnText == "이름변경") {
					$("#nameDiv").css("display", "block");
					$("#changeName").attr("type", "text");
					$("#btnName").text("변경취소");
				} else {
					$("#changeName").attr("type", "hidden");
					$("#nameDiv").css("display", "none");
					$("#changeName").val("");
					$("#warningName").text("");
					$("#btnName").text("이름변경");
				}
			}); // end btnName click()
			
			$("#btnPhone").click(function(e) {
				e.preventDefault();
				var btnText = $("#btnPhone").text();
				
				if(btnText == "휴대폰번호 변경") {
					$("#phoneDiv").css("display", "block");
					$("#changePhone").attr("type", "text");
					$("#btnPhone").text("변경취소");
				} else {
					$("#changePhone").attr("type", "hidden");
					$("#phoneDiv").css("display", "none");
					$("#warningPhone").attr("display", "none");
					$("#changePhone").val("");
					$("#warningPhone").text("");
					$("#btnPhone").text("휴대폰번호 변경");
				}
			}); // end btnName click()
			
			$("#changeName").on("keyup", function() {
				var name = $("#changeName").val();
				var regempty = / /gi;
				var regName = /[^ㄱ-힣a-zA-Z\s]/g;
				
				if (name != "") {
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#changeName").val(value);
					}
					if(regName.test($(this).val())) {
						// 문자이외의 입력일 때 공백으로 대체 
						var value = $(this).val().replace(/[^ㄱ-힣a-zA-Z\s]/g,"");
						$("#changeName").val(value);
						$("#warningName").text("한글 및 영문자만 입력가능합니다.");
						nameFlag = false;
					} else {
						$("#warningName").text("");
						nameFlag = true;
					}
				}
				
			}); // end changeName keyup()
			
			$("#changePhone").on("keyup", function() {
				var phone = $("#changePhone").val();
				var regPhone = /[^0-9]/g;
				
				if (phone != "") { // 공백이 아니면
					if(regPhone.test($(this).val())) { // 숫자가 아니면
						var value = $(this).val().replace(/[^0-9]/g, "");
						$("#changePhone").val(value);
						
					} else { // 공백이 아니고 숫자면
						if (!isCellPhone(phone)) { // 형식판단
							$("#warningPhone").text("형식에 맞지 않는 번호입니다.");
							phoneFlag = false;
						} else {
							$("#warningPhone").text("");
							phoneFlag = true;
						}
					}
				}
			}); // end changePhone keyup()
			
			$("#emailInfo").on("keyup", function() {
				emailFlag = false;
				var email = $("#emailInfo").val();
				var regempty = / /gi;
				
				if (email != "") { // 공백이 아니면
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#emailInfo").val(value);
					}
					
					if (!isEmail(email)) { // 형식검사
						$("#warningEmail").text("이메일 형식을 확인해주세요.");
						emailFlag = false;
					} else {
						$("#warningEmail").text("");
						emailFlag = true;
					}
				} else {
					$("#warningEmail").text("필수 사항입니다.");
					emailFlag = false;
				}
			}); // end emailInfo keyup()
			
			$("#update").click(function() {
				var id = $("#memberId").val();
				var name = $("#changeName").val();
				var phone = $("#changePhone").val();
				var email = $("#emailInfo").val();
	
				console.log(id);
				console.log(name);
				console.log(phone);
				console.log(email);
				
				// 변경하지 않을 경우, 기존의 데이터 사용
				if(name == "") {
					name = $("#existName").val();
					console.log("기존것? :" + name);
					nameFlag = true;
				}
				if(phone == "") {
					phone = $("#existPhone").val();
					console.log("기존것? :" + phone);
					phoneFlag = true;
				}
				
				console.log(nameFlag);
				console.log(phoneFlag);
				console.log(emailFlag);
				
				// flag가 모두 true면
				if(nameFlag == true && phoneFlag == true && emailFlag == true) {
					var member = {
							"memberId" : id,
							"memberName" : name,
							"memberPhone" : phone,
							"memberEmail" : email
					};
					
					$.ajax({
						type : "put",
						url : "/mypage/registUserInfo",
						contentType : "application/json",
						data : JSON.stringify(member),
						success : function(result) {
							if(result == 1) {
								alert("회원정보가 변경되었습니다.");
								location.href="/mypage";
							} else {
								alert("회원정보 변경에 실패하였습니다./n새로고침 후 다시 시도해주세요.");
							}
						}
					}); // end ajax()
				} else {
					alert("변경할 내용을 확인해주세요.");
				}
			}); // end update click()
			
			// '-'붙인 휴대폰 번호 출력
			function phoneFormat(num) {
				console.log(num);
				var regPhone = num.replace(/([0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
				$("#formatPhone").text(regPhone);
			} // end phoneFormat()
			
			function isCellPhone(phone) {
				// 01?-(3~4)자리-4자리 또는 010-4자리-4자리 형식
				var regPhone = /^((01[1|6|7|8|9])[1-9][0-9]{6,7})$|(010[1-9][0-9]{7})$/;
				return regPhone.test(phone);
			} // end isCellPhone()
			
			function isEmail(email) {
				// 영문숫자 조합(중간에 -_. 가능) @ 영문숫자(중간에 -_. 가능) . 영문(2~3자)
				var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				return regEmail.test(email);
			}
			
		}); //end document
	
	</script>