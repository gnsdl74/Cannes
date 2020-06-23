<%@ page language="java" contentType="text/html; charset=UTf-8"
	pageEncoding="UTf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/joinInfo.css">
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

	<!-- joinInfo-wrap -->
	<div class="joinInfo-wrap">
		<!-- step-member -->
		<div class="step-member"
			title="step1 약관동의, step2 정보입력, step3 가입완료 단계 중 step2 정보입력 단계">
			<ol>
				<li>
					<p class="step">
						<em>STEP1.</em> <span>약관동의</span>
					</p>
				</li>
				<li>
					<p class="step on">
						<em>STEP2.</em> <span>정보입력</span>
					</p>
				</li>
				<li>
					<p class="step">
						<em>STEP3.</em> <span>가입완료</span>
					</p>
				</li>
			</ol>
		</div>
		<!--// step-member -->

		<!-- info-wrap -->
		<div class="info-wrap">
			<p id="joinInfo-title">회원정보 입력</p>
				<table class="input-info">
					<tr>
						<th>이름</th>
						<td>
							<input id="name" type="text" placeholder="이름" required autofocus />
							<label id="nameResult"></label>
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>
							<input id="birth" type="text" placeholder="생년월일 앞 8자리" required />
							<label id="birthResult"></label>
						</td>
					</tr>
					<tr>
						<th>휴대폰 번호</th>
						<td>
							<input id="phone" type="text" placeholder="'-' 없이 입력" required />
							<label id="phoneResult"></label>							
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<input id="id" type="text" placeholder="아이디" required />
							<label id="idResult"></label>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input id="pswd1" type="password" placeholder="비밀번호" required />
							<label id="pswd1Result"></label>
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input id="pswd2" type="password" placeholder="비밀번호 확인" required />
							<label id="pswd2Result"></label> 
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input id="email" type="text" placeholder="이메일" />
							<label id="emailResult"></label>
						</td>
					</tr>
				</table>
		</div>
		<!-- // info-wrap -->
		
		<!-- welcome.jsp로 보낼 데이터 폼 -->
		<form id="step-form" action="/welcome" method="post">
			<input id="welcome-name" type="hidden" name="welcomeName" />
			<input id="welcome-id" type="hidden" name="welcomeId" />
			<input id="step2" type="hidden" name="step2" />
		</form>
		<div class="btn-join-member">
			<button id="btn-join" type="button" disabled >회원가입</button>
		</div>
	</div>
	<!--// joinInfo-wrap -->
	<jsp:include page="../footer.jsp"></jsp:include>

	<script type="text/javascript">
		// 각 항목을 입력받았을 때, 기준에 맞는지 체크
		// 기준 모두 체크되어 true값을 반환하면 버튼 활성화
		// 버튼 활성화되면 클릭시 submit
		// 에러 메시지 박스를 하나로 만들어야함.
		
		$(document).ready(function() {
			var flags = {
				nameflag : false,
				birthflag : false,
				idflag : false,
				pswd1flag : false,
				pswd2flag : false,
				emailflag : false
			};
							
			// 이름에 입력이 발생
			$("#name").on("keyup", function(e) {
				var name = $("#name").val();
				var regName = /[^ㄱ-힣a-zA-Z\s]/g;
				var regempty = / /gi;
				
				if (name == "") {
					$("#nameResult").text("필수 사항입니다.");
					flags.nameflag = false;
				} else {
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#name").val(value);
					}
					if(regName.test($(this).val())) {
						// 문자이외의 입력일 때 공백으로 대체 
						var value = $(this).val().replace(/[^ㄱ-힣a-zA-Z\s]/g,"");
						$("#name").val(value);
						$("#nameResult").text("한글 및 영문자만 입력가능합니다.");
						flags.nameflag = false;
					} else {
						$("#nameResult").text("");
						flags.nameflag = true;
					}
				}
				
				//user.memberName = name;
				if(btnJoinCheck(flags)) {
					if(e.keyCode == 13) {
						$("#btn-join").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#birth").focus();
					}
				}
			}); // end #name.keyup()

			// 생일에 입력이 발생 (일단 보류)
			$("#birth").on("keyup", function(e) {
				var birth = $("#birth").val();
				
				if (birth == "") {
					$("#birthResult").text("필수 사항입니다.");
					flags.birthflag = false;
				} else {
					
					if(fn_birthCheck(birth, 8)) {
						$("#birthResult").text("");
						flags.birthflag = true;
					} else {
						$("#birthResult").text("생년월일을 정확히 입력해주세요.");
						flags.birthflag = false;
					}
				}
				//user.memberBirth = birth;
				if(btnJoinCheck(flags)) {
					if(e.keyCode == 13) {
						$("#btn-join").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#phone").focus();
					}
				}
			}); // end #birth.keyup()

			// 휴대폰번호에 입력이 발생
			$("#phone").on("keyup", function(e) {
				var phone = $("#phone").val();
				var regPhone = /[^0-9]/g;
				
				if (phone == "") { // 공백이면
					$("#phoneResult").text("필수 사항입니다.");
					flags.phoneflag = false;
					
				} else { // 공백이 아니면
					if(regPhone.test($(this).val())) { // 숫자가 아니면
						var value = $(this).val().replace(/[^0-9]/g, "");
						$("#phone").val(value);
						flags.phoneflag = false;
						
					} else { // 공백이 아니고 숫자면
						if (!isCellPhone(phone)) { // 형식판단
							$("#phoneResult").text("형식에 맞지 않는 번호입니다.");
							flags.phoneflag = false;
						} else {
							$("#phoneResult").text("");
							flags.phoneflag = true;
						}
					}
				}
				
				//user.memberPhone = phone;
				if(btnJoinCheck(flags)) {
					if(e.keyCode == 13) {
						$("#btn-join").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#id").focus();
					}
				}
			}); // end #phone.keyup()

			// id에 입력이 발생
			$("#id").on("keyup", function(e) {
				var id = $("#id").val();
				var regId = /[ㄱ-힣\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
				var regempty = / /gi;
				
				if (id == "") { // 공백이면
					$("#idResult").text("필수 사항입니다.");
					flags.idflag = false;
					
				} else { // 공백이 아니면
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#id").val(value);
					}
					
					if(regId.test($(this).val())) { // 특수문자가 있으면
						var value = $(this).val().replace(/[ㄱ-힣\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi,"");
						$("#id").val(value);
						
					} else { // 특수문자 없으면
						if (!isId(id)) {
							$("#idResult").text("영문, 숫자 조합(6~12자)");
							flags.idflag = false;
						} else {
							$("#idResult").text("");
							checkId(id); // 중복확인 함수
						}
					}
				}
				//user.memberId = id;
				if(btnJoinCheck(flags)) {
					if(e.keyCode == 13) {
						$("#btn-join").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#pswd1").focus();
					}
				}
			}); // end #id.keyup()
			
			// pswd1에 입력이 발생
			$("#pswd1").on("keyup", function(e) {
				var pw = $("#pswd1").val();
				var regempty = / /gi;
				
				if (pw == "") { // 공백이면
					$("#pswd1Result").text("필수 사항입니다.");
					flags.pswd1flag = false;
					
				} else { // 공백이 아니면
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#pswd1").val(value);
					}
					
					if (!isPw(pw)) { // 형식에 맞지않으면
						$("#pswd1Result").text("영문, 숫자, 특수문자 조합(8~16자)");
						flags.pswd1flag = false;
						
					} else {
						$("#pswd1Result").text("");
						flags.pswd1flag = true;
					}
				}
				
				if(btnJoinCheck(flags)) {
					if(e.keyCode == 13) {
						$("#btn-join").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#pswd2").focus();
					}
				}
			}); // end #pwsd1.keyup()

			// pswd2에 입력이 발생
			$("#pswd2").on("keyup", function(e) {
				var pswd1 = $("#pswd1").val();
				var pswd2 = $("#pswd2").val();
				var regempty = / /gi;
				
				if (pswd2 == "") { // 공백이면
					$("#pswd2Result").text("필수 사항입니다.");
					flags.pswd2flag = false;
					
				} else { // 공백이 아니면
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#pswd2").val(value);
					}
					if (pswd1 != pswd2) { // pswd1과 pswd2가 일치하지 않으면
						$("#pswd2Result").text("비밀번호가 일치하지 않습니다.");
						flags.pswd2flag = false;
						
					} else { // 일치하면
						$("#pswd2Result").text("");
						flags.pswd2flag = true;
					}
				}
				//user.memberPw = pswd2;
				if(btnJoinCheck(flags)) {
					if(e.keyCode == 13) {
						$("#btn-join").click();
					}
				} else {
					if(e.keyCode == 13) {
						$("#email").focus();
					}
				}
			}); // end #pswd2.keyup()

			// 이메일에 입력이 발생
			$("#email").on("keyup", function(e) {
				var email = $("#email").val();
				var regempty = / /gi;
				
				if (email != "") { // 공백이 아니면
					if(regempty.test($(this).val())) {
						var value = $(this).val().replace(/ /gi,"");
						$("#email").val(value);
					}
					
					if (!isEmail(email)) { // 형식검사
						$("#emailResult").text("이메일 형식을 확인해주세요.");
						flags.emailflag = false;
					} else {
						$("#emailResult").text("");
						flags.emailflag = true;
					}
				} else {
					$("#emailResult").text("필수 사항입니다.");
					flags.emailflag = false;
				}
				//user.memberEmail = email;
				if(btnJoinCheck(flags)) {
					if(e.keyCode == 13) {
						$("#btn-join").click();
					}
				}
			}); // end #email.keyup()

			// 회원가입 버튼 클릭했을때
			$("#btn-join").click(function() {
				var name = $("#name").val();
				var birth = $("#birth").val();
				var phone = $("#phone").val();
				var id = $("#id").val();
				var pw = $("#pswd1").val();
				var email = $("#email").val();
				var formData = {
						memberName : name,
						memberBirth : birth,
						memberPhone : phone,
						memberId : id,
						memberPw : pw,
						memberEmail : email
						};
				
				$("#step2").attr("value", "Y");
				var step2 = $("#step2").val();
				// 해당 JSON데이터로 회원 가입
				$.ajax({
					type : "POST",
					url : "/join",
					contentType : "application/json",
					data : JSON.stringify(formData),
					success : function(result) {
						console.log(result);
						if (result == "success") { // 회원 가입 성공
							$("#welcome-name").attr("value", name);
							$("#welcome-id").attr("value", id);
							$("#step-form").submit();
						} else if (result == "fail") { // 회원 가입 실패
							location.href = "error.jsp";
						}
					}
				}); // end ajax
			}); // end #btn-join.click()

			
			function isCellPhone(phone) {
				// 01?-(3~4)자리-4자리 또는 010-4자리-4자리 형식
				var regPhone = /^((01[1|6|7|8|9])[1-9][0-9]{6,7})$|(010[1-9][0-9]{7})$/;
				return regPhone.test(phone);
			} // end isCellPhone()

			function isId(id) {
				// 영문과 숫자 조합 6~12자리
				var regId = /^[a-zA-Z0-9][a-zA-Z0-9]{5,11}$/;
				return regId.test(id);
			} // end isId()

			function checkId(id) {
				$.ajax({
					type : "GET",
					url : "/checkId",
					data : {
						"id" : id
					},
					success : function(result) {
						if (result == "success") {
							$("#idResult").css("color", "blue");
							$("#idResult").text("사용 가능한 아이디입니다.");
							flags.idflag = true;
						} else if (result == "fail") {
							$("#idResult").text("이미 사용 중인 아이디입니다.");
							flags.idflag = false;
							}
						}
				}); // end ajax
			} // end checkId()

			function isPw(pw) {
				// 영문, 숫자, 특수문자 조합 8~16자리
				var regPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
				return regPw.test(pw);
			}

			function isEmail(email) {
				// 영문숫자 조합(중간에 -_. 가능) @ 영문숫자(중간에 -_. 가능) . 영문(2~3자)
				var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				return regEmail.test(email);
			}
			
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
			
			function btnJoinCheck(flags) {
				// flag가 모두 true면 버튼 활성화
				if (flags.nameflag == true
						&& flags.birthflag == true
						&& flags.idflag == true
						&& flags.pswd1flag == true
						&& flags.pswd2flag == true
						&& flags.emailflag == true) {
					$("#btn-join").attr("disabled", false);
					return true;
				} else {
					$("#btn-join").attr("disabled", true);
					return false;
				}
			} // end btnJoinCheck()

		}); // end document
	</script>