<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/mypage.css">
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
	
	<div class="mypage-container">
		<div class="sub-location">
			<div class="sub-location-inner">
				<i class="material-icons">&#xe88a;</i>
				<p>> 마이페이지</p>
			</div>
		</div>
		<div class="mypage-info">
			<div class="top">
				<!-- 세션에서 memberId 가져옴 -->
				<p>${memberId }님의<br>마이 페이지입니다.
				<p>
					<a href="/mypage/myinfo">개인정보수정 ></a>
			</div>
			<div class="bottom">
				<p>나의 한줄평</p>
				<ol>
				<c:set var="n" value="1"/>
				<c:forEach var="replyVO" items="${replyList }" end="6" varStatus="status">
					<li>${status.count} .${replyVO.replyContent }</li>
				</c:forEach>
					
				</ol>
			</div>
		</div>

		<div class="division">
			<div class="myticket ticket-pay">
				<p class="mypage-title">나의 예매정보</p>
				<div class="booking-list">
				<c:set var="now" value="<%=new java.util.Date()%>" />
				<c:set var="sysDate"><fmt:formatDate value="${now}" pattern="yyyy.MM.dd" /></c:set>
				<c:set var="sysTime"><fmt:formatDate value="${now}" pattern="hh:mm:ss" /></c:set>  
				<c:choose>
				<c:when test="${not empty bookingList }">
				<c:forEach var="bookingVO" items="${bookingList }">
				<fmt:formatDate
								value="${bookingVO.payDate }" pattern="yyyy.MM.dd" var="payRegDate" />
				<fmt:formatDate
								value="${bookingVO.scheduleDate }" pattern="yyyy.MM.dd" var="scheduleRegDate" />
					<div class ="booking">
						<div class = "moviePoster">
							<img alt="poster" src="${bookingVO.moviePoster }">
						</div>
						<div class = "booking-info">
							<div class = "payment-date">결제일시: ${payRegDate }
							<c:choose>
								<c:when test="${sysDate == scheduleRegDate}">
									<c:if test="${sysTime < bookingVO.scheduleTime }">
										<button class="booking-cancel" id="${bookingVO.payNo}" value="${bookingVO.seatNo}">예매취소</button>
									</c:if>
								</c:when>
								<c:when test="${sysDate < scheduleRegDate}">
									<button class="booking-cancel" id="${bookingVO.payNo}" value="${bookingVO.seatNo}">예매취소</button>
								</c:when>
							</c:choose>
							</div>
							
							<div class= "ticket-no">예매번호: ${bookingVO.ticketNo } </div>
							<div class="movie-info">
								<span class= "movie-title">${bookingVO.movieTitle }</span>
								<span class="movie-showtime">(${bookingVO.movieShowtime })</span>
							</div>
							<div class= "theater-name">${bookingVO.theaterName }</div>
							<div class="scheudle">
								<span class= "schedule-date">${scheduleRegDate }</span>
								<span class= "schedule-time">(${bookingVO.scheduleTime })</span>
							</div>							
						</div>
					</div>
					</c:forEach>
					</c:when>
						<c:otherwise><div class="booking-null" ><p>예매 내역이 없습니다.</p></div></c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="mypay ticket-pay">
				<p class="mypage-title">나의 결제정보</p>
				<div class="pay-info" >
					<p>결제 내역이 없습니다.</p>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	$(function(){
		$(".booking .booking-cancel").on('click',function(){			
			let payNo = $(this).attr('id');
			let seatNo = $(this).val();
			console.log(payNo);
			if (confirm("예매취소 하시겠습니까?") == true){  //확인
				 $.ajax({
			  	      type : 'delete',
			  	      url : '/booking' ,
			  	   	 headers : {
			  	    	'Content-Type' : 'application/json',
			  	    	'X-HTTP-Method-Override' : 'DELETE' 
			  	      },
			  	      data : JSON.stringify({
			  	    	'payNo' : payNo,
			  	    	'seatNo' : seatNo
			  	      }),
			  	      success : function(result) {
			  	        if (result == 1) {
			  	          alert('예매취소 성공');
			  	        location.reload(true);
			  	        }else{
			  	        	alert('예매취소 실패');
			  	        }
			  	      }
			  	    }); // end ajax()
				 }else{ //취소
			     return false;
			 }
			
		}); // end booking-cancel click()
		
	}); // end document()

	
	</script>