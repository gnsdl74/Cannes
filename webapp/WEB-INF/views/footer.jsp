<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!-- Footer -->
	<footer id="footer">
		<div class="footer-inner">
			<p class="copyright">
				&copy; KIHOON &amp; SEUNGHO'S FINAL PROJECT
			</p>
		</div>
	</footer>
	<!-- // Footer -->
	
	<div id="login-popup" class="popup-bx-wrap">
		<div class="popup-bx-inner">

			<div class="popup-table">
			
				<div class="popup-cell">
											
					<div class="popup-content">
						<div class="popup-title">
							<button class="popup-close" type="button"></button>
						</div>
						<form>
							<div class="popup-input">
								<input type="text" id="memberId" placeholder="아이디" required autofocus /> 
								<input type="password" id="memberPw" placeholder="비밀번호" required />
							</div>
							<div class="popup-label">
								<label for="idCheck"><input type="checkbox" id="idCheck" />&nbsp;아이디 저장</label>
							</div>
							<button class="btn-login">로그인</button>
							<div class="popup-link-group">
								<ul class="clearfix">
									<li><a href="/find">ID/PW 찾기</a></li>
									<li><a href="/tos">회원가입</a></li>
									<!--   <li><a href="">비회원 예매확인</a></li> -->
								</ul>
							</div>
						</form>
					</div>


				</div>
			</div>

		</div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			// Header의 로그인버튼 클릭시 팝업창 활성화
			$('#login').click(function(e) {
				e.preventDefault();
				document.getElementById("login-popup").className = "popup-bx-wrap on";
				// memberId의 쿠키 값이 있으면 해당 아이디를 출력하면서 아이디 저장 chkbx를 true로 변경
				var memberId = getCookie("Cookie_memberid");
				$("#memberId").val(memberId);
				    
				    if($("#memberId").val() != "") {
				    	$("#idCheck").attr("checked", true);
				    }
			}); // end #login.click() 팝업창 활성화
			
			// X버튼 클릭시 팝업창 비활성화
			$('.popup-close').click(function() {
				document.getElementById("login-popup").className = "popup-bx-wrap";
			}); // end .popup-close.click() 팝업창 비활성화
			
			// 팝업창 로그인 버튼 클릭시 회원 확인
			$('.btn-login').click(function() {
				var memberId = $('#memberId').val();
				var memberPw = $('#memberPw').val();
				console.log(memberId);
				console.log(memberPw);
				// 아이디 저장이 체크되어 있으면 해당 memberId로 쿠키를 생성하고 7일동안 지속
				if($("#idCheck").is(":checked")) {
			    	var memberId = $("#memberId").val();
			    	setCookie("Cookie_memberid", memberId, 7);
			    } else { // 아이디 저장을 체크안하면 쿠키 삭제(시간을 과거로 설정하면 삭제됨)
			    	setCookie("Cookie_memberid", "", -1);
			    }
				// 해당 회원의 id와 pw를 보내 확인 후 로그인 처리
				$.ajax({
					type : "post",
					url : "/login",
					data : {
						"memberId" : memberId,
						"memberPw" : memberPw
					},
					async : false,
					success : function(result) {
						console.log(result);
						if(result == "success") {
							alert("로그인 성공");
							location.reload();
						} else if(result == "fail") {
							alert("아이디 또는 비밀번호가 맞지 않습니다.\n로그인 정보를 다시 확인바랍니다.");
							$('#memberId').val("");
							$('#memberPw').val("");
						}
					}
				}); // end ajax
				return false; // 새로고침 방지
			}); // end 로그인.click()
			
			$('#logout').click(function(e) {
				e.preventDefault();
				$.ajax({
					type : "get",
					url : "/logout",
					success : function(result) {
						console.log(result);
						location.href="/main";
					}
				}); // end ajax
			}); // end 로그아웃.click()
			
			// c_name에 해당하는 쿠키를 가져오는 함수
			function getCookie(cname) {
				var name = cname + "=";
				var decodedCookie = decodeURIComponent(document.cookie);
				var ca = decodedCookie.split(';');
				
				for(var i = 0; i < ca.length; i++) {
					var c = ca[i];
					
					while (c.charAt(0) == ' ') {
						c = c.substring(1);
					}
					
    				if (c.indexOf(name) == 0) {
      					return c.substring(name.length, c.length);
					}
				}
				return "";
			} // end getCookie()
			
			// 쿠키를 설정하는 함수
			function setCookie(cname, cvalue, exdays) {
				var d = new Date();
				d.setTime(d.getTime() + (exdays*24*60*60*1000));
				var expires = "expires="+ d.toUTCString();
				document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
			} // end setCookie()

		}); // end document
	</script>
</body>
</html>