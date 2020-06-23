<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">

<!-- 슬라이드 플러그인 -->
<link rel="stylesheet" type="text/css" href="/resources/css/slick.css">
<script src="/resources/js/slick.js"></script>
<script>
	$(function() {
		$(".notice-slider").slick({
			slidesToShow : 1,
			slidesToScroll : 1,
			arrows : false,
			fade : false,
			dots : false,
			autoplay : true,
			speed : 1000,
			infinite : true,
			autoplaySpeed : 4000,
			pauseOnHover : false,
			vertical : true
		});
	});
</script>

<script>
	$(function() {
		$("#boxoffice-movie ol li").hover(function() {
			$(this).addClass("on");
			$("#boxoffice-movie ol").addClass("active");
		});

		$("#boxoffice-movie ol li").mouseleave(function() {
			$(this).removeClass("on");
			$("#boxoffice-movie ol").removeClass("active");
		});
	});
</script>


</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>
	<div id="container" align="center">
		<!-- 박스오피스 -->
		<div id="boxoffice">
			<!-- <p id="boxoffice-text">여기는 Container1입니다.</p> -->
			<div id="boxoffice-movie">
				<ol class="clearfix">
					<c:forEach items="${weeklyList }" var="boxoffice" varStatus="varstatus">
						<li class="poster" style="background-image: url('${boxoffice.value.moviePoster}');">
							<input type="hidden" id="movieNo" value="${boxoffice.value.movieNo }">
							<div class="poster-hover">
								<h3>${boxoffice.value.movieTitle }</h3>
								<fmt:formatDate value="${boxoffice.value.movieDate }"
									pattern="yyyy.MM.dd" var="regdate" />
								<h2>${regdate }</h2>
								<p class="poster-star" id="rank${varstatus.count }">${boxoffice.key }위</p>
								<p class="poster-star">
									<c:choose>
										<c:when test="${boxoffice.value.movieAge == 0 }">
									전체 관람가
								</c:when>
										<c:otherwise>
									${boxoffice.value.movieAge }세 관람가
								</c:otherwise>
									</c:choose>
								</p>
								<p class="poster-info">${boxoffice.value.movieContent }</p>
								<input id="boxoffice-video" type="hidden" value="${boxoffice.value.movieVideo }">
							</div>
						</li>
					</c:forEach>
				</ol>
			</div>
		</div>
		<!--// 박스오피스 -->

		<!-- 영화 광고 -->
		<div id="movieAd">
			<h2 class="font-anton">MOVIE AD</h2>
			<div id="movieAdVideo" class="clearfix">
				<iframe id="youtube" width="700" height="400"
					src="https://www.youtube.com/embed/1JsvqaWd_2U" frameborder="0"
					allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
					allowfullscreen></iframe>
				<img id="poster" alt="포스터" src="resources/img/MovieAd.jpg">
			</div>
		</div>
		<!-- // 영화 광고 -->

		<div id="notice">
			<div id="noticeConn" align="center" class="clearfix">

				<h2 class="notice-title">공지사항</h2>
				<div class="notice-slider">
					<c:forEach items="${noticeList }" var="notice">
						<div class="notice-slider-inner">
						<a href="/detail?noticeNo=${notice.noticeNo }">
							<p>${notice.noticeTitle }</p> 
							<fmt:formatDate value="${notice.noticeDate }" pattern="yyyy.MM.dd" var="regdate" />
							<span>${regdate }</span>
						</a>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
