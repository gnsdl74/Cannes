<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
<link rel="stylesheet" type="text/css" href="/resources/css/find.css">
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="main">
		<p id="findTitle">아이디/비밀번호 찾기</p>
		<!-- 아이디, 비밀번호 Tab -->
		<!--디폴트 메뉴 : tab menu1-->
		<input id="findId" class="findInfo" name="tabs" type="radio" checked>
		<label for="findId" class="titleNm">아이디 찾기</label>
		<input id="findPw" class="findInfo" name="tabs" type="radio">
		<label for="findPw" class="titleNm">비밀번호 찾기</label>
		<!-- // 아이디, 비밀번호 Tab -->

		<!-- 아이디 찾기 영역 -->
		<section id="idContent">
			<div class="container">
				<p class="content-title">간편찾기</p>
				<div class="content">
					<table>
						<tr>
							<th>이름</th>
							<td>
								<input id="idName" type="text" placeholder="이름" required autofocus>
								<label id="nameError"></label>
							</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td><input id="idBirth" type="text" placeholder="생년월일 앞8자리" required>
								<label id="birthError"></label></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input id="idEmail" type="text" placeholder="이메일" required>
								<label id="emailError"></label></td>
						</tr>
					</table>
				</div>
				<div class="info">
					<p>※ 아이디 찾기가 불가능한 경우에는 고객센터(☎1577-9999)로 문의바랍니다.</p>
				</div>
				<button id="btnSubmitId" class="btnSubmit" type="button" disabled>아이디
					찾기</button>
			</div>
		</section>
		<!-- // 아이디 찾기 영역 -->

		<!-- 비밀번호 찾기 영역 -->
		<section id="pwContent">
			<div class="container">
				<p class="content-title">간편찾기</p>
				<div class="content">
					<table>
						<tr>
							<th>아이디</th>
							<td><input id="pwId" type="text" placeholder="아이디" required autofocus></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input id="pwName" type="text" placeholder="이름" required></td>
						</tr>
						<tr>
							<th>휴대폰 번호</th>
							<td><input id="pwPhone" type="text" placeholder="'-'없이 입력" required>
								<button id="authSend" class="btn-auth" disabled>인증요청</button></td>
						</tr>
						<tr id="confirmTr">
							<th>인증번호</th>
							<td><input id="phoneCheck" type="text" disabled required>
								<div>
									<p id="timer">3:00</p>
								</div>
								<button id="authConfirm" class="btn-auth" disabled>인증확인</button>
								<label id="phoneError"></label>
							</td>
						</tr>
					</table>
				</div>
				<div class="info">
					<p>※ 비밀번호 찾기가 불가능한 경우에는 고객센터(☎1577-9999)로 문의바랍니다.</p>
				</div>
				<button id="btnSubmitPw" class="btnSubmit" type="button" disabled>비밀번호
					찾기</button>
			</div>
		</section>
		<!-- // 비밀번호 찾기 영역 -->

	</div>
	<jsp:include page="../footer.jsp"></jsp:include>

	<script type="text/javascript">
		var validNm = "N";
		var validBirth = "N";
		var validEmail = "N";

		$(document).ready(function() {
			/* 아이디 찾기 부분 */
			// 이름 항목에 입력이 발생
			$("#idName").on("keyup", function(e) {
				var idName = $("#idName").val();
				var regName = /[^ㄱ-힣a-zA-Z\s]/g;
				var regempty = / /gi;
				
				if(idName != "") {
					$("#nameError").text("");
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#idName").val(value);
					}
					if(regName.test($(this).val())) {
						// 문자이외의 입력일 때 공백으로 대체 
						var value = $(this).val().replace(/[^ㄱ-힣a-zA-Z\s]/g,"");
						$("#idName").val(value);
					}
				} else {
					$("#nameError").text("필수 입력사항입니다.");
				}
				
				if(fn_btnSubmitIdVal()) {
					if(e.keyCode == 13) {
						$("#btnSubmitId").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#idBirth").focus();
					}
				}
			}); // end ID찾기 name keyup()
			
			// 생년월일 항목에 입력이 발생
			$("#idBirth").on("keyup", function(e){
				var idBirth = $("#idBirth").val();
				
				if(idBirth != "") {
					// 숫자가 아니면 공백으로 대체
					$(this).val($(this).val().replace(/[^0-9]/g,""));
				} else {
					$("#birthError").text("필수 입력사항입니다.");
				}
				
				if(fn_btnSubmitIdVal()) {
					if(e.keyCode == 13) {
						$("#btnSubmitId").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#idEmail").focus();
					}
				}
			}); // end ID찾기 birth keyup()
			
			// 이메일 항목에 입력이 발생
			$("#idEmail").on("keyup", function(e){
				var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				var regempty = / /gi;
				
				if(regempty.test($(this).val())) {
					var value = $(this).val().replace(/ /gi,"");
					$("#idEmail").val(value);
				}
				
				if(regEmail.test($(this).val())) {
					$("#emailError").text("");
				} else {
					$("#emailError").text("이메일을 정확히 입력해주세요.");
				}
				
				if(fn_btnSubmitIdVal()) {
					if(e.keyCode == 13) {
						$("#btnSubmitId").click();
					}
				}
			}); // end ID찾기 email keyup()
			
			// 활성화된 아이디 찾기를 클릭했을 때
			$("#btnSubmitId").click(function() {
				var name = $("#idName").val();
				var birth = $("#idBirth").val();
				birth = to_date(birth);
				console.log(birth);
				var email = $("#idEmail").val();
				var user = {
						"memberName" : name,
						"memberBirth" : birth,
						"memberEmail" : email
					};
				
				// 입력 정보에 해당하는 회원이 있는지 확인
				$.ajax({
					type : "POST",
					url : "/find/idMember",
					data : JSON.stringify(user),
					contentType : "application/json; charset=utf-8;",
					success : function(result) {
						console.log(result);
						// 존재하는 회원이면
						if(result == "success") {
							// 인증메일 발송
							$.ajax({
								type : "POST",
								url : "/emailAuth",
								data : JSON.stringify(user),
								contentType : "application/json; charset=utf-8;",
								success : function(result) {
									if(result == "success") {
										alert("이메일 인증이 발송되었습니다.\n입력하신 이메일을 확인해주시기 바랍니다.")
										valueClean();
									} else if(result == "fail") {
										alert("이메일 발송에 실패하였습니다. 다시 시도해주세요.")
									}
								}
							}); // end ajax()
						} else if(result == "fail") {
							alert("해당 정보로 가입된 사용자를 찾을 수 없습니다.");
						}
					}
				}); // end ajax()
			}); // end btnSubmitId()
			
			// 상단 탭 클릭시 다른 탭의 내용 지우기
			$("#findId").click(function() {
				$("#pwId").val("");
				$("#pwName").val("");
				$("#pwPhone").val("");
			}); // end findId click()
			 $("#findPw").click(function() {
				$("#idName").val("");
				$("#idBirth").val("");
				$("#idEmail").val("");
			 }); // end findPw click()
			 // end 탭 클릭시 다른 탭 내용 지우기
			
			// 아이디 찾기버튼 활성화 유,무 판단 메소드
			function fn_btnSubmitIdVal() {
				console.log(validNm);
				console.log(validBirth);
				console.log(validEmail);
				
				// 이름에 공백이 아니면
				if($("#idName").val() != "") {
					validNm = "Y";
				} else {
					validNm = "N";
				}
				
				// 생년월일이 공백이 아니면
				if($("#idBirth").val() != "") {
					console.log($("#idBirth").val());
					
					// 생년월일이 8자리가 맞는지, 현재연도보다 큰지, 윤년인지를 판단
					if(fn_birthCheck($("#idBirth").val(), 8)) {
						validBirth = "Y";
						$("#birthError").text("");
					} else {
						validBirth = "N";
						$("#birthError").text("생년월일을 정확히 입력해주세요.");
					}
				} else {
					validBirth = "N";
				}
				
				// 이메일이 형식에 맞는지 체크
				if($("#idEmail").val() != "") {
					if($("#emailError").text() == "") {
						validEmail = "Y";
					} else {
						validEmail = "N";
					}
				} else {
					validEmail = "N";
				}
				
				if(validNm == "Y" && validBirth == "Y" && validEmail == "Y") {
					$("#btnSubmitId").attr("disabled", false);
					return true;
				} else {
					$("#btnSubmitId").attr("disabled", true);
					return false;
				}
			} // end fn_btnSubmitIdVal()
			
			// 생년월일 판단 메소드
			function fn_birthCheck(birth, length) {
				console.log(birth);
				console.log(length);
				
				try	{
					var year  = 0;
					var month = 0;
					var day   = 0;

					birth = birth.replace(/-/g,"");

					// 생년월일이 8자리가 아닐 경우
					if( isNaN(birth) || birth.length < 8 || birth.length > 8) {
						return false;
					}
					
					// 생년월일이 8자리일 경우
					if(birth.length == 8){
						year  = Number(birth.substring(0, 4));
						month = Number(birth.substring(4, 6));
						day   = Number(birth.substring(6, 8));
						
						console.log(year);
						console.log(month);
						console.log(day);
						
						// 현재 연도를 저장
						var currentYear = Number(new Date().getFullYear());
						//입력연도가 현재연도보다 클 경우
						if(currentYear < year){
							return false;
						}
					} else {
						return false;
					}

					if( month<1 || month>12 ) {
						return false;
					}

					var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
					var maxDay = maxDaysInMonth[month-1];

					// 윤년 체크
					if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
						maxDay = 29;
					}

					if( day <= 0 || day > maxDay ) {
						return false;
					}
					return true;

				} catch (err) {
					return false;
				}
			} // end fn_birthCheck()
			
			// String을 Date로 변환
			function to_date(birth)	{
			    var yyyyMMdd = String(birth);
			    var sYear = yyyyMMdd.substring(0,4);
			    var sMonth = yyyyMMdd.substring(4,6);
			    var sDay = yyyyMMdd.substring(6,8);

			    return new Date(Number(sYear), Number(sMonth)-1, Number(sDay));
			}
			
			// 이름, 생년월일, 이메일 비우기 메소드
			function valueClean() {
				$("#idName").val("");
				$("#idBirth").val("");
				$("#idEmail").val("");
			}
		}); // end document
			/* end 아이디 찾기 부분 */
			</script>


	<script type="text/javascript">
			/* 비밀번호 찾기 부분 */
			$(document).ready(function() {
			var validPwId = "N";
			var validPwName = "N";
			var validPwPhone = "N";
			
			// 아이디 항목에 입력이 발생
			$("#pwId").on("keyup", function(e) {				
				var regId = /[ㄱ-힣\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
				var regempty = / /gi;
				
				if(regempty.test($(this).val())) {
					var value = $(this).val().replace(/ /gi,"");
					$("#pwId").val(value);
				}
				// 해당 형식에 맞으면
				if(regId.test($(this).val())) {
					var value = $(this).val().replace(/[ㄱ-힣\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi,"");
					$("#pwId").val(value);
				}
				if(fn_btnAuthSend()) {
					if(e.keyCode == 13) {
						$("#btnSubmitPw").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#pwName").focus();
					}
				}
			}); // end PW찾기 id keyup()
			
			// 이름 항목에 입력이 발생
			$("#pwName").on("keyup", function(e) {
				var regName = /[^ㄱ-힣a-zA-Z\s]/g;
				var regempty = / /gi;
				
				if(regempty.test($(this).val())) {
					var value = $(this).val().replace(/ /gi,"");
					$("#pwName").val(value);
				}
				
				if(regName.test($(this).val())) {
					// 문자이외의 입력일 때 공백으로 대체 
					var value = $(this).val().replace(/[^ㄱ-힣a-zA-Z\s]/g,"");
					$("#pwName").val(value);
				}
				if(fn_btnAuthSend()) {
					if(e.keyCode == 13) {
						$("#btnSubmitPw").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#pwPhone").focus();
					}
				}
			}); // end PW찾기 name keyup()
			
			// 휴대폰 번호에 입력이 발생
			$("#pwPhone").on("keyup", function(e) {
				var regPhone = /[^0-9]/g;
				if(regPhone.test($(this).val())) {
					var value = $(this).val().replace(/[^0-9]/g, "");
					$("#pwPhone").val(value);
				}
				if(fn_btnAuthSend()) {
					if(e.keyCode == 13) {
						$("#btnSubmitPw").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("phoneCheck").focus();
					}
				}
			}); // end PW찾기 phone keyup()
			
			// 인증요청 버튼 활성화 후 클릭 (회원인지 확인)
			$("#authSend").click(function() {
				var id = $("#pwId").val();
				var name = $("#pwName").val();
				var phone = $("#pwPhone").val();
				var user = {
					"memberId" : id,
					"memberName" : name,
					"memberPhone" : phone
				};
				
				$.ajax({
					type : "POST",
					url : "/find/pwMember",
					data : JSON.stringify(user),
					contentType : "application/json; charset=utf-8;",
					success : function(result) {
						if(result == "success") {
							fn_authNumSend();
						} else if(result == "fail") {
							alert("해당 정보로 가입된 사용자를 찾을 수 없습니다.");
						}
					}
				}); // end ajax
			}); // end authSend click()
			
			$("#phoneCheck").on("keyup", function(e) {
				var inputNum = $("#phoneCheck").val();
				if(fn_NumCheck(inputNum)) {
					$("#authConfirm").attr("disabled", false);
				} else {
					$("#authConfirm").attr("disabled", true);
				}
			}); // end phoneCheck keyup()
			
			$("#authConfirm").click(function() {
				var standardNum = "7915"; // 무작위로 지정되는 4자리 인증번호
				var inputNum = $("#phoneCheck").val();

				if(standardNum == inputNum) {
					alert("휴대폰 인증이 완료되었습니다.");
					clearInterval(count);
					$("#authSend").attr("disabled", true);
					$("#btnSubmitPw").attr("disabled", false);
					$("#confirmTr").css("display", "none");
				} else {
					alert("인증번호가 올바르지 않습니다.");
					$("#btnSubmitPw").attr("disabled", true);
				}
			}); // end authConfirm click()
			
			// 휴대폰 인증하고 새로운 비밀번호 설정 페이지로 넘기기
			$("#btnSubmitPw").click(function() {
				var id = $("#pwId").val();
				setCookie("Cookie_idByNewPw", id, 1);
				location.href = "/setNewPw";
			}); // end btnSubmitPw()
			
			// 인증요청 버튼 활성화 메소드
			function fn_btnAuthSend() {
				console.log(validPwId);
				console.log(validPwName);
				console.log(validPwPhone);
				
				// 아이디가 공백이 아니면
				if($("#pwId").val() != "") {
					validPwId = "Y";
				} else {
					validPwId = "N";
				}
				
				// 이름이 공백이 아니면
				if($("#pwName").val() != "") {
					validPwName = "Y";
				} else {
					validPwName = "N";
				}
				
				// 휴대폰 번호가 공백이 아니면
				if($("#pwPhone").val() != "") {
					// 휴대폰 번호가 10~11자리가 맞는지
					if(fn_phoneLengthCheck($("#pwPhone").val())) {
						validPwPhone = "Y";
						$("#phoneError").text("");
					} else {
						validPwPhone = "N";
						$("#phoneError").text("휴대폰 번호를 정확히 입력해주세요.");
					}
				} else {
					validPwPhone = "N";
				}
				
				if(validPwId == "Y" && validPwName == "Y" && validPwPhone == "Y") {
					$("#authSend").attr("disabled", false);
					return true;
				} else {
					$("#authSend").attr("disabled", true);
					return false;
				}
			}// end fn_btnAuthSend()
			
			// 휴대폰 번호 길이 확인 메소드
			function fn_phoneLengthCheck(phone) {
				if(phone.length >= 10 && phone.length <= 11) {
					return true;
				} else {
					return false;
				}
			} // end fn_phoneLengthCheck() 
			
			// 회원일 경우 인증번호 전송 메소드
			function fn_authNumSend() {
				alert("인증번호를 전송했습니다.\n인증번호가 도착하지 않았을 경우 재전송을 눌러 주세요.");
				fn_timer();
				$("#authSend").text("재전송");
				$("#phoneCheck").attr("disabled", false);
			} // end fn_authNumSend()
			
			var count = ""; // setInterval을 받을 변수
			// 인증요청 타이머 메소드
			function fn_timer() {
				var time = 179; // 기준 시간
				var min = ""; // 분
				var sec = ""; // 초
				
				// setInterval(함수, 시간) : 시간에 따라 주기적으로 실행
				// (아래 메소드는 1초마다 실행)
				count = setInterval(function() {
					min = parseInt(time/60);
					sec = time%60;
					sec = pad(sec, 2);
					
					$("#timer").text(min + ":" + sec);
					time--;
					
					// 시간 종료시
					if(time < 0) {
						clearInterval(count); // 실행 종료
						alert("휴대폰 인증을 다시하세요.");
						location.reload();
					}
					
				}, 1000);
			} // end fn_timer()
			
			// 자릿수를 맞추기 위한 메소드
			function pad(n, width) {

				  n = n + '';

				  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;

			} // end pad()
			
			// 인증번호가 숫자이며 4자리인지 확인하는 메소드
			function fn_NumCheck(inputNum) {
				var regNum = /[^0-9]/g;
				// 숫자가 아니라면
				if(regNum.test($("#phoneCheck").val())) {
					var value = $("#phoneCheck").val().replace(/[^0-9]/g, "");
					$("#phoneCheck").val(value);
					return false;
				} else { // 숫자면 길이확인
					if(inputNum.length == 4) {
						return true;
					} else {
						return false;
					}			
				}
			} // end fn_NumCheck()
			
			// 쿠키를 설정하는 함수
			function setCookie(cname, cvalue, exdays) {
				var d = new Date();
				d.setTime(d.getTime() + (exdays*24*60*60*1000));
				var expires = "expires="+ d.toUTCString();
				document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
			} // end setCookie()
			/* end 비밀번호 찾기 부분 */
			
		}); // end document
	</script>