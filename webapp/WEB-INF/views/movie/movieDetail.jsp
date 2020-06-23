<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/reply.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="area">
		<div class="top-container">
			<div class="movie-info">
				<div class="sub-location">
					<div class="sub-location-inner">
						<i class="material-icons">&#xe88a;</i>
						<p>> 영화 > 상세정보</p>
					</div>
				</div>
				<div class="movie-bx clearfix">
					<div class="info">
						<div class="info-setting">
							<p class="tit"  movie-no ="${movieDetail.movieNo }">${movieDetail.movieTitle }</p>
							<p class="type">${movieDetail.movieType }</p>
							<c:choose>
								<c:when test="${movieDetail.movieAge != 0 } ">
									<p class="age">${movieDetail.movieAge }</p>
								</c:when>
								<c:otherwise>
									<p class="age">All</p>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="movie-bottom">
							<a class="reserve-movie" href="/booking">예매</a>
							<p class="director">${movieDetail.movieDirector }</p>
							<fmt:formatDate value="${movieDetail.movieDate }"
								pattern="yyyy.MM.dd" var="regdate" />
							<p class="date">${regdate }</p>
						</div>
					</div>
					<div class="movie-img">
						<iframe id="youtube" width="700" height="370"
							src="${movieDetail.movieVideo }" frameborder="0"
							allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
							allowfullscreen></iframe>
					</div>
				</div>
				<p class="content">${movieDetail.movieContent }</p>
			</div>
		</div>
		<div>
			<div class="bottom-container">
				
				<div id="reply-frame">
					<div id="reply-area">
						<div id="reply-count">
							<h2>
								아직 남겨진 한줄평이 없어요.
							</h2>
						</div>
						<div id="reply-insert-frame">
							<div class="insert-img-wrap">
								<img alt="유저" src="/resources/img/shortCut.png">
								<div id="user-id">
									<c:choose>
										<c:when test="${not empty memberId }">
											<p>${memberId }</p>
										</c:when>
										<c:otherwise>
											<p>Cannes</p>
										</c:otherwise>
									</c:choose>

								</div>
							</div>
							<div id="reply-insert-area">
								<div id="reply-insert-content">
									<p>
										<span>${movieDetail.movieTitle }</span> 재미있게 보셨나요? 영화의 어떤 점이 좋았는지
										이야기해주세요.
									</p>
								</div>
								<div id="reply-write">
									<button id="reply-write-btn">
										<p>
											관람평쓰기
											<p>
									</button>
								</div>
							</div>
						</div>
					
						<ul id="reply" style="list-style: none;"></ul>
						
						
					</div>
					
					<div id="page-num">
						<ul id="pager"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<input type="hidden" id="page-no">
	<jsp:include page="../footer.jsp"></jsp:include>


	<script type="text/javascript">
		$(function() {			
			let page = 1;
			$('#page-no').val(page);
			getReplies(page);		
			
			$(document).on('click','#pager li a' ,function(){
				event.preventDefault();
				
				page = $(this).attr('href'); // 페이지 번호 가져오기
				
				
				console.log(page);
				getReplies(page);				
			}); // end delete-btn click()		
			
			
			function getReplies(page) {
				let movieNo = $('.tit').attr('movie-no');
				const uri = "/reply/all/" + movieNo + "/" + page;
				$
						.getJSON(
								uri,
								function(jsonData) {
									let replyContent = "";
									let pageNoContent = "";
									let date = "";
									
									const pageMaker = jsonData[0].pageMaker; // jsonData 0번째 순서에 페이지 정보가 담겨져서 옴
									console.log(pageMaker);
									
									let page = pageMaker.page;
									$('#page-no').val(page); // 페이지 입력
									
									let totalCount = pageMaker.totalCount;
									
									let replyInfo ='<span>${movieDetail.movieTitle }</span>에 대한 <span id="total-count">'+ totalCount + '</span>개의 이야기가 있어요!';
									$('#reply-count h2').html(replyInfo);
									let userId = $('#user-id p').text();
									$(jsonData)
											.each(
													function() {
														date = new Date(
																this.replyDate);
														console
																.log(this.replyNo);
														replyContent += '<li class="reply"><div class="reply-wrap"><div class="icon-id"><img alt="유저" src="/resources/img/user.png">';
														replyContent += '<p class="member-id">' + this.memberId +'</p></div>';
														replyContent += '<div class="reply-content"><p class="r-title">관람평</p><div class="r-content">';
														replyContent += this.replyContent;
														replyContent += '</div><div class="r-date">' + date_to_str(date) + '</div>';
														if(this.memberId == userId ){
															replyContent += '<button class="delete-btn" value="' + this.replyNo + '">삭제</button>';
														}
														replyContent += '</div></div></li>';
													})// end each()

									if (pageMaker.hasPrev) {
										pageNoContent += '<li><a href="'
												+ (pageMaker.criteria.page - 1)
												+ '">이전</a></li>';
									}
									for (let i = pageMaker.startPageNo; i <= pageMaker.endPageNo; i++) {
										pageNoContent += '<li><a href="'+ i +'">'
												+ i + '</a></li>';
									}
									if (pageMaker.hasNext) {
										pageNoContent += '<li><a href="'
												+ (pageMaker.criteria.page + 1)
												+ '">다음</a></li>';
									}

									$('#reply').html(replyContent);
									$('#pager').html(pageNoContent);
								}); // end getJSON()				
			} // end getReplies()			

			// date형태를 yyyy.MM.dd로 변환
			function date_to_str(format) {
				let year = format.getFullYear();

				let month = format.getMonth() + 1;
				if (month < 10) {
					month = '0' + month;
				}
				let date = format.getDate();
				if (date < 10) {
					date = '0' + date;
				}
				return year + "." + month + "." + date;
			} // end date_to_str()

		}); // end document()
	</script>
	
	<script type="text/javascript">
		$(function(){
			$(document).on('click','#reply-write-btn' ,function(){
				let userId = $('#user-id p').text();
				let movieNo = $('.tit').attr('movie-no');
				if(userId == 'Cannes'){
					 if (confirm("로그인 하시겠습니까??") == true){    //확인
						 $("#login").trigger('click');
					 }else{   //취소
					     return false;
					 }
				}else{
					$('#reply-insert-content').html('<input id="content-input" type="text" maxlength="75" placeholder="70자 작성가능">');
					$('#content-input').focus();
					$(this).attr('id', 'reply-input-btn');
					$('#reply-write button').text('작성');					
				} // end else
			}) // end reply-write button click()
			
			$(document).on('click','#reply-input-btn',function(){
				let text = $('#content-input').val();
				
				let userId = $('#user-id p').text();
				let movieNo = $('.tit').attr('movie-no');
				let obj = {
						'memberId' : userId,
						'movieNo' : movieNo,
						'replyContent' : text
				};
				console.log(obj);
				 // $.ajax로 송신
		  	    $.ajax({
		  	      type : 'post',
		  	      url : '/reply',
		  	      headers : {
		  	    	'Content-Type' : 'application/json',
		  	    	'X-HTTP-Method-Override' : 'POST' // RequestMethod.POST인 메소드로 전송
		  	      },
		  	      data : JSON.stringify(obj), // 제이슨 객체로 변환 
		  	      success : function(result) {
		  	        if (result == 1) {
		  	          alert('댓글 입력 성공');
		  	        location.reload(true);
		  	        }
		  	      }
		  	    }); // end ajax()
			}); // end reply-input-btn click()
			
			
			$(document).on('click','.delete-btn' ,function(){
				let replyNo = $(this).val();
				$.ajax({
			  	      type : 'delete',
			  	      url : '/reply/' + replyNo,
			  	   	 headers : {
			  	    	'Content-Type' : 'application/json',
			  	    	'X-HTTP-Method-Override' : 'DELETE' 
			  	      },
			  	      success : function(result) {
			  	        if (result == 'success') {
			  	          alert('댓글 삭제 성공');
			  	        location.reload(true);
			  	        }
			  	      }
			  	    }); // end ajax()
			}); // end reply-input-btn click()
			
			$(document).on('click','.delete-btn' ,function(){
				
			}); // end click
			
		}); // end document()
	</script>
	
	
	
	
	
	
	