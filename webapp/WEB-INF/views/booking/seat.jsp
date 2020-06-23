<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/booking_form.css">
<link rel="stylesheet" href="/resources/css/booking_seat.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<script type="text/javascript">
	window.history.forward();
	function noBack() {
		window.history.forward();
	}
</script>
<body>

	<!-- Header -->
	<jsp:include page="../header.jsp"></jsp:include>
	
	<!-- // Header -->
	<!-- frame(여백포함) div -->
	<div>
			
		<!-- 예매 > 빠른예매 div  -->
		<div class="sub-location">
			<div class="sub-location-inner">
				<i class="material-icons">&#xe88a;</i>
				<p>> 예매 > 빠른예매</p>
			</div>
		</div>
		<!-- // 예매 > 빠른예매 div  -->

		<!-- frame -->
		<div class="frame" align="center">

			<div class="area">

				<!-- 빠른예매 div -->
				<div class="sub-reservation-tit">

					<p>빠른예매</p>
				</div>
				<!-- // 빠른예매 div -->

				<!-- frame-main -->
				<div class="frame-main">
					<div class="frame-main-body clearfix">

						<!-- 좌석 프래임 -->
						<div class="seat-frame">

							<div class="seat-title">
								<p>관람인원선택 <span class="sub">(최대 4매 선택가능)</span> <button>
								<i class="iconset"></i>초기화</button></p>
								
							</div>

							<!-- 좌석인원-->
							<div class="seat-count">

								<div class="count-cell" id="adult">
									<p class="txt">성인</p>
									<button class="down"  id="adult-down">-</button>
									<button class="now" id="adult-now" disabled>0</button>
									<button class="up" id="adult-up">+</button>
								</div>

								<div class="count-cell" id="teen">
									<p class="txt">청소년</p>
									<button class="down" id="teen-down">-</button>
									<button class="now " id="teen-now" disabled>0</button>
									<button class="up" id="teen-up">+</button>
								</div>								
								
							</div>
							<!-- // 좌석인원-->

							<!-- 좌석 선택 frame -->
							<div class="seat-choice-frame" >
								<div class="screen-img">
									<img alt="screen" src="/resources/img/screen.png">
								</div>
								<div class="seat-choice" style="position: relative;">
									<div>
										<!-- 좌석 position: top  값-->
										<c:set var="top" value="20" />
										<!-- 좌석리스트 -->
										<c:forEach var="seat" items="${seatList }">
											<!-- 좌석 position: left  값-->
											<c:set var="left" value="${seat.seatColumn*25 }" />											

											<c:if test="${seat.seatColumn == '1' }">
												<!-- 좌석 position: top  값-->
												<c:set var="top" value="${top + 22 }" />
												<c:set var="row" value="${seat.seatRow }"/>
												<!-- 좌석 Row정렬  -->												
											<button class="seatBtn row" style="left: ${left + 20}px; top:${top}px; " disabled>${row }</button>																						
											</c:if>

											<!-- 좌석 위치 조정 -->
											<c:choose>
												<c:when test="${seat.seatColumn == '1' }">
													<c:set var="adjust" value="70" />
												</c:when>
												<c:when test="${seat.seatColumn == '5' }">
													<c:set var="adjust" value="90" />
												</c:when>
												<c:when test="${seat.seatColumn == '12' }">
													<c:set var="adjust" value="110" />
												</c:when>
											</c:choose>

											<!-- 좌석 출력 -->
											<c:choose>
												<c:when test="${seat.seatActive == 'Y' }">
													<!-- 좌석이용가능 -->
													<button class="seatBtn" id="active"  row=${seat.seatRow }
														column="${seat.seatColumn }" value="${seat.seatNo }" 
														style="left: ${left + adjust}px; top:${top}px;">${seat.seatColumn }</button>
												</c:when>
												<c:when test="${seat.seatActive == 'N' }">
													<!-- 좌석이용불가능 -->
													<button class="seatBtn"  id="inactive"  row=${seat.seatRow }
														column="${seat.seatColumn }" value="${seat.seatNo }"
														style="left: ${left + adjust}px; top:${top}px;" disabled>&nbsp;</button>
												</c:when>
											</c:choose>

										</c:forEach>

									</div>
								</div>

							</div>
							<!-- // 좌석 선택 frame -->

						</div>
						<!--// 좌석 프레임 -->

						<!-- 좌석 결과 -->
						<div class="seat-result">
						<div class= "seat-wrap">
							<div class="movie-info"  align="left">
							<span><img id="movie-age-${scheduleDetailVO.movieAge }"  alt="${scheduleDetailVO.movieAge }" src=""></span>
							<span id="movie-title">${scheduleDetailVO.movieTitle }</span>
							</div>
							
							<div class="schedule-info">
							
								<div class="schedule">
									<div class="theater scheudle-text">${scheduleDetailVO.theaterName }</div>
									<fmt:formatDate
								value="${scheduleDetailVO.scheduleDate }" pattern="yyyy.MM.dd" var="regdate" />
									<div class="date scheudle-text">${regdate }</div>
									<div class="time scheudle-text">${scheduleDetailVO.scheduleTime } (${scheduleDetailVO.movieShowtime })</div>
								</div>
								<div class="poster-area">
									<img class="poster" alt="${scheduleDetailVO.movieTitle } " src="${scheduleDetailVO.moviePoster }">
								</div>
							</div>
							
							<div class="seat-info">
								<div class="choice-legend">
									<ul class="legend-list">
										<li>
											<div  class="seat-condition choice"  title="선택한 좌석"></div>
											<em>선택</em>
										</li>
										<li>
											<div  class="seat-condition finish" title="예매 완료"></div>
											<em>예매완료</em>
										</li>
										<li>
											<div  class="seat-condition impossible" title="선택 불가"></div>
											<em>선택불가</em>
										</li>
										<li>
											<div  class="seat-condition common" title="일반"></div>
											<em>일반</em>
										</li>
									</ul>
								</div>
								<div class="choice-result">
									<p>선택 좌석</p>
									<div class="result 0">-</div>
									<div class="result 1">-</div>
									<div class="result 2">-</div>
									<div class="result 3">-</div>
								</div>
							</div>
							
							<div class="payment-info">								
								<p id="personnel" align="left">
									<span></span>									
								</p>							
								
								<div class="payment-area">
									<p id="payment-tit" >최종결제금액</p>
									<div class="payment" >
										<em id="money">0</em>
										<span>원</span>
									</div>
								</div>
							</div>
							<div class="result-choice">
							<a id="page-prev"  href="/booking">이전</a>
							<a id="page-next" href="/">다음</a>
							</div>
							</div>
						</div>
						<!-- // 좌석 결과 -->
					</div>

				</div>
				<!-- // frame-main -->

			</div>

		</div>
		<!-- // frame -->

	</div>
	<!-- // frame(여백포함) div -->
	
	<input type="hidden" id="member-id" value="${memberId }">
	<input type="hidden" id="member-name" value="${memberVO.memberName }">
	<input type="hidden" id="member-phone" value="${memberVO.memberPhone }">
	<input type="hidden" id="member-email" value="${memberVO.memberEmail }">
		
	<!-- Footer -->
	<jsp:include page="../footer.jsp"></jsp:include>


	<form action="/booking/result "  method="post" >
		<input type="hidden" id="pay-no"  name="payNo" >
		<input type="hidden" id="pay-type" name="payType" > 
		<input type="hidden" id="pay-price" name="payPrice" >
		
		<input type="hidden" id="schedule-no" name="scheduleNo"  value="${scheduleDetailVO.scheduleNo }">
		<input type="hidden" id="seat-no" name="seatNo" >
		<input type="hidden" id="ticket-price" name="ticketPrice" >
		<input type="hidden" id="ticket-personnel" name="ticketPersonnel" >
	</form>

 





	<script>	
	
$(function(){
	
		let adultNo = 0; // 성인 수
		let teenNo = 0; // 청소년 수
		let peopleNo = 0; // 총 사람 수 
		const maxNo = 4;	// 관람인원의 최대인원
		let seatClick = false;  // seatbtn 클릭여부 확인 값

		
	$('.count-cell button').click(function(){			
		const tagId = $(this).attr('id');		
		console.log(tagId);		
	
		// 관람인원을 선택하는 switch 문	
		switch(tagId){
		case "adult-up":
			if(adultNo+teenNo == maxNo){
				break;
			}
			peopleNo += 1
			adultNo += 1;			
			$("#adult-now").html(adultNo);
			break;
		case "adult-down":
			if(adultNo == 0){
				break;
			}
			if(seatClick == true){
				pageRefresh();
				break;
			}
			peopleNo -= 1;
			adultNo -= 1;
			$("#adult-now").html(adultNo);
			break;
		case "teen-up":
			if(adultNo+teenNo == maxNo){
				break;
			}
			peopleNo += 1
			teenNo += 1;			
			$("#teen-now").html(teenNo);
			break;
		case "teen-down":
			if(teenNo == 0){
				break;
			}
			if(seatClick == true){
				pageRefresh();
				break;
			}
			peopleNo -= 1;
			teenNo -= 1;
			$("#teen-now").html(teenNo);
			break;
		}
		console.log(peopleNo);
		
		if(teenNo>=0 || adultNo>=0){
			
			let adult = '';
			let teen = '';
			let comma = '';
			if(adultNo > 0) {
				adult = '성인 ' + adultNo;
			}		
			if(teenNo > 0) {
				teen = '청소년 ' + teenNo;
			}
			if(adultNo > 0 && teenNo > 0){
				comma = ", ";
			}
			const personnel = adult + comma + teen;
			const money = (teenNo * 8000) + (adultNo * 10000)
			$("#money").val(money);			
			$("#money").html(numberWithCommas(money));
			$("#personnel span").html(personnel);
			$("#ticket-personnel").val(personnel);
			$("#ticket-price").val(money);
		}		
		
		}); // end count-cell btn click()
		
		
		$('.seat-choice button').click	(function(){
			const tagId = $(this).attr('id'); // 클릭한 좌석 버튼의 id			
			
			
			// 관람인원 선택 전이나 자리 선택이 끝난 후 좌석 버튼을 클릭했을때 처리하는 if문
			
			if(peopleNo == 0 && seatClick == false){				
				alert("관람하실 인원을 먼저 선택해 주세요");				
				return;
			} else if(peopleNo == 0 && seatClick == true && tagId == "active") {
				alert("좌석선택이 완료되었습니다.");
				return;
			}else{
				seatClick = true;		
			}				
			
			// 좌석 선택 취소 과정을 처리하는 if문
			if(tagId == "active" && peopleNo > 0){
			$(this).attr('id', 'choice');	
			peopleNo -= 1;				
			} else if(tagId == "choice" && peopleNo <= maxNo){
			$(this).attr('id', 'active');
			peopleNo += 1;		
			}				
			let leng = $('.seat-choice #choice').length; // 선택한 버튼 개수
			
			setChoiceResult(leng);			
		}); // end choice btn click()
		
		$('.seat-title p button').on('click',function(){
			pageRefresh();
		}); // end seat-title p button click()		
		
		
		var IMP = window.IMP; // 생략가능
		IMP.init('imp59920969'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

			// 결제 회원 정보 
			const memberId = $('#member-id').val();
			
			
			const movie = $('#movie-title').text();
			
			
			
			$('#page-next').on('click',function(){
				const money = $('#money').val();
				event.preventDefault(); // a 태그의 기본 동작(페이지 이동)을 금지
				
				if(money == 0 || peopleNo != 0){
					alert('좌석을 선택해 주세요');
				}else if(memberId == ""){
					 if (confirm("로그인 하시겠습니까??") == true){    //확인
						 $("#login").trigger('click');
					 }else{   //취소
					     return false;
					 }
				}else{					
					payment(money);
				}
				
			}); // end page-next click()
			
			
			
			// 아임포트
			const memberName = $('#member-name').val();
			const memberPhone = $('#member-phone').val();
			const memberEmail = $('#member-email').val();
			function payment(money){		
				IMP.request_pay({
				    pg : 'inicis', // version 1.1.0부터 지원.
				    pay_method : 'card',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : movie,
				    amount : money,
				    buyer_name : memberName,
				    buyer_tel : memberPhone,
				    buyer_email : memberEmail				    
				}, function(rsp) {
				    if ( rsp.success ) {
				        var msg = '결제가 완료되었습니다.';
				        msg += '결제 금액 : ' + rsp.paid_amount;
				        
				        $("#pay-no").val(rsp.apply_num);
				        $("#pay-type").val(rsp.card_name);
				        $("#pay-price").val(rsp.paid_amount);
				        
				         $('form').submit();
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        msg += '에러내용 : ' + rsp.error_msg;
				    }
				    alert(msg);
				}); // end IMP.request_pay()
			} // end payment()			
		
			// 금액에 콤마를 찍어주는 함수
			function numberWithCommas(x) {
			    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			
			// 선택한 좌석을 선택 좌석 div에 넣어주는 함수
			function setChoiceResult(leng){			
				$(".result").html("-");
				let seatVal = new Array(leng); // 좌석 value
				let seatTitle = new Array(leng); // 좌석 row + column
				for(let i = 0;  i<leng; i++ ){				
					seatVal[i] = $(".seat-choice #choice").eq(i).val(); 
					seatTitle[i] = $(".seat-choice #choice").eq(i).attr('row') + $(".seat-choice #choice").eq(i).attr('column'); 
					console.log(seatTitle[i]);
					$("." + i).html(seatTitle[i]);
				}
				$("#seat-no").val(seatVal);
				console.log(seatVal);
				console.log(seatTitle);
			} // end setSeat()
			
			//  페이지 초기화
			function pageRefresh(){
				if(confirm("초기화하시겠습니까 ?") == true){
					history.go(0);
			    }
			    else{
			        return ;
			    }
			} // end pageRefresh()			
		
	}); // end document()
		
	
</script>


<!-- 영화 연령 포스터 추가 -->
<script type="text/javascript">
getAgePoster();
function getAgePoster(){
			 $("#movie-age-0").attr("src","https://img.megabox.co.kr/static/pc/images/common/txt/txt-age-small-all.png");
			 $("#movie-age-12").attr("src","https://img.megabox.co.kr/static/pc/images/common/txt/txt-age-small-12.png");
			 $("#movie-age-15").attr("src","https://img.megabox.co.kr/static/pc/images/common/txt/txt-age-small-15.png");
			 $("#movie-age-19").attr("src","https://img.megabox.co.kr/static/pc/images/common/txt/txt-age-small-19.png");
			 $("#movie-age-0").attr("alt",0);
			 $("#movie-age-12").attr("alt",12);
			 $("#movie-age-15").attr("alt",15);
			 $("#movie-age-19").attr("alt",19);
}
</script>




