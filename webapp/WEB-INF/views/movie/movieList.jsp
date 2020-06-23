<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/movieList.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="sub-location">
		<div class="sub-location-inner">
			<i class="material-icons">&#xe88a;</i>
			<p>> 영화 > 전체영화</p>
		</div>
	</div>
	<!-- container -->
	<div class="container" align="center">
		<p id="movie-title">전체 영화</p>
		<!-- movie-conunt -->
		<div class="movie-count">
			<p><span id="cnt"></span>의 영화가 검색되었습니다.</p>
			<div class="movie-finder">
				<p>
					<input type="text" id="searchBox" placeholder="영화명 검색">
					<button type="button" id="movieSearch"><i class="material-icons">&#xe8b6;</i></button>
				</p>
			</div>
		</div>
		<!-- // movie-conunt -->
		<!-- movie-list -->
		<div class="movie-list">
			<ol id="movieRepeat">
				<c:if test="${not empty movieAll }">
					<c:forEach items="${movieAll }" var="movie" varStatus="varstatus">
						<li class="movie-select">
							<a href="/movieList/${movie.movieNo }"><img alt="${movie.movieTitle }" src="${movie.moviePoster}"></a>
							<div class="movie-detail">
								<c:choose>
									<c:when test="${movie.movieAge eq 0 }">
										<p>All</p>
									</c:when>
									<c:otherwise>
										<p>${movie.movieAge }</p>	
									</c:otherwise>
								</c:choose>
								<p>${movie.movieTitle }</p>
								<fmt:formatDate value="${movie.movieDate }" pattern="yyyy.MM.dd" var="regdate" />
								<p>${regdate }</p>
								<input type="hidden" id="movieCount" value="${movie.movieCount }">
							</div>
						</li>
					</c:forEach>
				</c:if>
			</ol>
		</div>
		<!-- // movie-list -->
		<!-- more-wrap -->
		<div class="more-wrap">
			<button type="button" class="btnMore" id="btnMore">더보기&nbsp;<i class="fas fa-angle-down"></i></button>
		</div>
		<!-- // more-wrap -->
	</div>
	<!-- // container -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript">
		window.onpageshow = function(event) {
	
			// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
		    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
		    	// 페이지를 새로고침
				window.location.reload();
		    }
		}

		$(document).ready(function() {
			fn_more_valid();
			fn_movie_cnt();
			
			// 전체영화 리스트 더보기 구현
			$("#btnMore").click(function() {
				$.ajax({
					type : "POST",
					url : "/movieList/more",
					success : function(list) {
						console.log(list);
						if(list == null) {
							location.href="/error";
							
						} else if(list != null) {
							var content = "";
							
							for(var i=0; i<list.length; i++) {
								console.log("list의 Date : " + list[i].movieDate);
								var movieOpen = new Date(list[i].movieDate);
								formatDate = date_to_str(movieOpen);
								console.log(formatDate);
								
								if(list[i].movieTitle != "") {
									content += '<li class="movie-select">'; 
									content += '<a href="/movieList/'+list[i].movieNo+'">';
									content += '<img alt="'+list[i].movieTitle+'" src="'+list[i].moviePoster+'"></a>';
									content += '<div class="movie-detail">';
									content += '<p>';
									if(list[i].movieAge == 0) {
										content += 'All';
									} else {
										content += list[i].movieAge;
									}
									content += '</p>';
									content += '<p>';
									content += list[i].movieTitle;
									content += '</p>';
									content += '<p>';
									content += formatDate;
									content += '</p>';
									content += '</div>';
									content += '</li>';
								}
								
							}
							$("#movieRepeat li:last").after(content);
							
							// 더보기를 나타낼 판단을 하는 함수
							fn_more_valid();
						}
					},
					error : function(request, status, error) {
				    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				}); // end ajax()
			}); // end btnMore click()
			
			// 영화명을 입력
			$("#searchBox").on("keyup", function(e) {
				// 검색창이 공백이 아니면
				if($("#searchBox").val() != "") {
					if(e.keyCode == 13) {
						$("#movieSearch").click();
					}
				} else {
					if(e.keyCode == 13) {
						alert("검색할 영화명을 입력해주세요.");
					}
				}
			}); // end searchBox focus()
			
			// 입력한 영화명을 검색
			$("#movieSearch").click(function() {
				var keyword = $("#searchBox").val();
				console.log(keyword);
				
				$.ajax({
					type : "POST",
					url : "/movieList/search",
					data : {keyword : keyword},
					success : function(list) {
						var content = "";
						if(list == "" || list == null || list == undefined || ( list != null && typeof list == "object" && !Object.keys(list).length )) {
							console.log("list 없음");
							// 검색한 영화가 없으면
							// 없다는 설명 화면 출력
							content += '<div class="empty-movie">';
							content += '<hr>';
							content += '<h1>현재 상영 중인 영화가 없습니다.</h1>';
							content += '<hr>';
							content += '</div>';
							
							$(".empty-movie").remove();
							$("#movieRepeat li").remove();
							$("#movieRepeat").prepend(content);
							$("#cnt").text(0+"개");
							$(".btnMore").css("display", "none");
							
						} else if (list != null) {
							console.log("list 있음");
							// 영화전체 더보기 버튼을 검색한 영화 더보기 버튼으로 변경
							$("#btnMore").attr("id", "btnSearchMore");
							
							for(var i=0; i<list.length; i++) {
								console.log("list의 Date : " + list[i].movieDate);
								var movieOpen = new Date(list[i].movieDate);
								formatDate = date_to_str(movieOpen);
								console.log(formatDate);
								
								if(list[i].movieTitle != "") {
									content += '<li class="movie-select">'; 
									content += '<a href="/movieList/'+list[i].movieNo+'">';
									content += '<img alt="'+list[i].movieTitle+'" src="'+list[i].moviePoster+'"></a>';
									content += '<div class="movie-detail">';
									content += '<p>';
									if(list[i].movieAge == 0) {
										content += 'All';
									} else {
										content += list[i].movieAge;
									}
									content += '</p>';
									content += '<p>';
									content += list[i].movieTitle;
									content += '</p>';
									content += '<p>';
									content += formatDate;
									content += '</p>';
									content += '<input type="hidden" id="movieCount" value="'+list[i].movieCount+'">';
									content += '</div>';
									content += '</li>';
								}
								
							}
							$("#movieRepeat li").remove();
							$("#movieRepeat hr").remove();
							$("#movieRepeat h1").remove();
							$("#movieRepeat").prepend(content);
							fn_movie_cnt();
							fn_more_valid();
						}
					}, 
					error : function(request, status, error) {
				    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				}); // end ajax()
			}); // end movieSearch click()
			
			// 검색한 영화 리스트 더보기 구현
			$("#btnSearchMore").click(function() {
				$.ajax({
					type : "POST",
					url : "/movieList/searchMore",
					success : function(list) {
						console.log(list);
						if(list == null) {
							location.href="/error";
							
						} else if(list != null) {
							var content = "";
							
							for(var i=0; i<list.length; i++) {
								console.log("list의 Date : " + list[i].movieDate);
								var movieOpen = new Date(list[i].movieDate);
								formatDate = date_to_str(movieOpen);
								console.log(formatDate);
								
								if(list[i].movieTitle != "") {
									content += '<li class="movie-select">'; 
									content += '<a href="/movieList/'+list[i].movieNo+'">';
									content += '<img alt="'+list[i].movieTitle+'" src="'+list[i].moviePoster+'"></a>';
									content += '<div class="movie-detail">';
									content += '<p>';
									content += list[i].movieAge;
									content += '</p>';
									content += '<p>';
									content += list[i].movieTitle;
									content += '</p>';
									content += '<p>';
									content += formatDate;
									content += '</p>';
									content += '<input type="hidden" id="movieCount" value="'+list[i].movieCount+'">';
									content += '</div>';
									content += '</li>';
								}
								
							}
							$("#movieRepeat li:last").after(content);
							
							// 더보기를 나타낼 판단을 하는 함수
							fn_more_valid();
						}
					},
					error : function(request, status, error) {
				    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				}); // end ajax()
			}); // end btnMore click()
			
			// 전체 영화 수 및 검색한 영화 개수를 변경
			function fn_movie_cnt() {
				var movieCount = $("ol > li:first-child #movieCount").val();
				$("#cnt").text(movieCount+"개");
				console.log(movieCount);
			} // end fn_movie_cnt()
			
			// date형태를 yyyy.MM.dd로 변환
			function date_to_str(format) {
			    var year = format.getFullYear();
			    
			    var month = format.getMonth() + 1;
			    if(month<10) {
			    	month = '0' + month;
			    }
			    
			    var date = format.getDate();
			    if(date<10) {
			    	date = '0' + date;
			    }
			    
			    return year + "." + month + "." + date;
			} // end date_to_str()
			
			// 더보기 버튼이 이용가능한지
			function fn_more_valid() {
				var length = $("#movieRepeat li").length;
				console.log(length);
				console.log(length%20);
				if(length % 20 != 0) {
					$(".btnMore").css("display", "none");
				}
			} // end fn_more_valid()
			
		}); // end document		
	
	</script>
	