<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- fmt : formatter, 출력형식을 바꿔줌 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/noticeList.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<div class="notice-box">
		<p class="notice-title">공지사항</p>
		<div class="notice-side">
			<strong>전체&nbsp;<span id="noticeCnt">${pageMaker.totalCount }</span>건</strong>
			<p><input id="searchTitle" type="text" placeholder="검색어를 입력해주세요."><button id="btnSearch" type="button"><i class="material-icons">&#xe8b6;</i></button></p>
		</div>
		<div class="notice-list">
			<table class="notice-table">
				<thead>
					<tr>
						<th style="width: 70px;">번호</th>
						<th style="width: 100px;">구분</th>
						<th style="width: 600px;">제목</th>
						<th style="width: 200px;">작성일</th>
					</tr>
				</thead>
				<tbody id="noticeInfo">
					<c:forEach var="vo" varStatus="vs" items="${noticeList }">
						<tr>
							<td>${pageMaker.totalCount - (pageMaker.totalCount - ((pageMaker.criteria.page - 1) * pageMaker.criteria.numsPerPage + vs.index)-1) }</td>
							<td>공지</td>
							<td><a class="goToDetail" href="${vo.noticeNo }">${vo.noticeTitle }</a></td>
							<!-- vo.regdate를 pattern 형식으로 바꾸어 var에 저장 -->
							<fmt:formatDate value="${vo.noticeDate }" pattern="yyyy.MM.dd"
								var="regdate" />
							<td>${regdate }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="page-num">
			<ul class="pager">
				<c:if test="${pageMaker.hasPrev }">
					<li><a href="${pageMaker.startPageNo - 1 }">이전</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPageNo }" end="${pageMaker.endPageNo }" var="num">
					<c:choose>
						<c:when test="${pageMaker.criteria.page == num }">
							<li><a href="${num }" style="pointer-events: none; cursor: default;">${num }</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${num }">${num }</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${pageMaker.hasNext }">
					<li><a href="${pageMaker.endPageNo + 1 }">다음</a></li>
				</c:if>
			</ul>
		</div>
	</div>

	<div class="form-box">
		<form id="pagingForm" style="display: none;">
			<input type="text" id="pageNum" name="page" value="${pageMaker.criteria.page }" />
			<input type="text" name="noticeNo" />
			<input id="keywordBox" type="text" name="keyword" />
		</form>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script type="text/javascript">
		$(document).ready(function() {
			// 클릭한 a태그의 정보를 가져오는 코드
			// .pager 클래스의 하위 li 요소의 하위 a 요소를 찾아감
			$(document).on("click", ".pager li a", function(e) {
			  	e.preventDefault(); // a 태그의 기본 동작(페이지 이동)을 금지
			  
				var idCheck = $(".form-box form").attr("id");
			  	var targetPage = $(this).attr('href'); // a 태그 href 속성의 값을 저장
				console.log(targetPage);
				
				
				if(idCheck == "pagingForm") {
					var frm = $('#pagingForm'); // form의 정보를 frm에 저장
					frm.find('[name="page"]').val(targetPage); // name="page"를 찾아서 value=targetPage를 저장
					frm.attr('action', '/notice'); // form에 action 속성 추가
					frm.attr('method', 'get'); // form에 method 속성 추가
					frm.submit(); // form 데이터 전송
					
				} else if(idCheck == "pagingSearch") {
					var keyword = $("#searchTitle").val();
					var data = {
							keyword : keyword,
							page : targetPage
					};
					
					$.ajax({
						type : "GET",
						url : "/notice/search",
						data : data,
						success : function(result, status) {
							
							var content = "";
							// 검색한 결과가 있는 경우
							if(result != "" && status == "success") {
								console.log(result);
								
								for(var i = 0; i<result.length; i++) {
									var noticeDate = new Date(result[i].noticeDate);
									var formatDate = date_to_str(noticeDate);
									var cnt = result[i].noticeCount - (result[i].noticeCount - ((result[0].pageMaker.criteria.page  - 1) * result[0].pageMaker.criteria.numsPerPage  + i)-1);							
								
									$("#pageNum").attr("value", result[0].pageMaker.criteria.page);
									$("#noticeInfo tr").remove();
									
									if(result[i].noticeTitle != "") {
										content += '<tr>';
										content += '<td>'+ cnt +'</td>';
										content += '<td>공지</td>';
										content += '<td><a class="goToDetail" href="'+result[i].noticeNo+'">'+result[i].noticeTitle+'</a></td>';
										content += '<td>'+formatDate+'</td>';
										content += '</tr>';
									}
								}
								$("#noticeInfo").prepend(content);
								$("#pagingForm").attr("id", "pagingSearch");
								
								var paging= "";
								// 검색한 키워드에 대한 페이징처리
								$(".page-num ul").remove();
								
								const maker = result[0].pageMaker;
								console.log("pageMaker를 가져왔습니다.");
								
								var start = maker.startPageNo;
								var end = maker.endPageNo;
								console.log(start);
								console.log(end);
								var prev = maker.startPageNo-1;
								var next = maker.endPageNo+1;
									
								paging += '<ul class="pager">';
								
								if(maker.hasPrev) {
									paging += '<li><a href="'+prev+'">이전</a></li>';	
								}
										
								for(var i= start; i<= end; i++) {
									if(maker.criteria.page == i) {
										paging += '<li><a href="'+i+'" style="pointer-events: none; cursor: default;">'+i+'</a></li>';
									} else {
											paging += '<li><a href="'+i+'">'+i+'</a></li>';	
									}
								}
										
								if(maker.hasNesx) {
									paging += '<li><a href="'+next+'">다음</a></li>';
								}
								paging += '</ul>';
								
								$(".page-num").prepend(paging);
								
								var selectCnt = result[0].noticeCount;
								fn_notice_cnt(selectCnt);
							}
						},
						error : function(request, status, error) {
					    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					}); // end ajax()
				} else {
					location.href = "/error";
				}
				
			}); // end click()
			
			// 공지 세부사항으로 이동
			$(document).on("click", ".goToDetail", function(e) {
				e.preventDefault();
				var noticeNo = $(this).attr('href'); // 클릭한 게시물의 글번호 저장
				
				var idCheck = $(".form-box form").attr("id");
				let frm = "";
				if(idCheck == "pagingForm") {
					frm = $('#pagingForm'); // id가 pagingForm인 객체 정보 저장
					$("input").remove("#keywordBox");
				} else {
					var keyword = $("#searchTitle").val();
					frm = $('#pagingSearch');
					frm.find('[name="keyword"]').val(keyword);
				}
				frm.attr('action', '/detail'); // detail로 이동
				frm.attr('method', 'get'); // 이동시 method는 get방식
				frm.find('[name="noticeNo"]').val(noticeNo); // pagingForm 객체에서 name이 noticeNo인 객체를 찾고 value를 noticeNo로 저장
				frm.submit(); // 제출
			}); // end click()
			
			// 검색버튼 클릭
			$("#btnSearch").click(function() {
				var keyword = $("#searchTitle").val();
				console.log(keyword);
				
				// 검색한 키워드의 공지사항 가져오기
				$.ajax({
					type : "GET",
					url : "/notice/search",
					data : { keyword : keyword },
					success : function(result, status) {
											
						var content = "";
						// 검색한 결과가 있는 경우
						if(result != "" && status == "success") {
							console.log(result);
							
							for(var i = 0; i<result.length; i++) {
								var noticeDate = new Date(result[i].noticeDate);
								var formatDate = date_to_str(noticeDate);
								var cnt = result[i].noticeCount - (result[i].noticeCount - ((result[0].pageMaker.criteria.page  - 1) * result[0].pageMaker.criteria.numsPerPage  + i)-1);							
							
								$("#pageNum").attr("value", result[0].pageMaker.criteria.page);
								$("#noticeInfo tr").remove();
								
								if(result[i].noticeTitle != "") {
									content += '<tr>';
									content += '<td>'+ cnt +'</td>';
									content += '<td>공지</td>';
									content += '<td><a class="goToDetail" href="'+result[i].noticeNo+'">'+result[i].noticeTitle+'</a></td>';
									content += '<td>'+formatDate+'</td>';
									content += '</tr>';
								}
							}
							$("#noticeInfo").prepend(content);
							$("#pagingForm").attr("id", "pagingSearch");
							
							var paging= "";
							// 검색한 키워드에 대한 페이징처리
							$(".page-num ul").remove();
							
							const maker = result[0].pageMaker;
							console.log("pageMaker를 가져왔습니다.");
							
							var start = maker.startPageNo;
							var end = maker.endPageNo;
							console.log(start);
							console.log(end);
							var prev = maker.startPageNo-1;
							var next = maker.endPageNo+1;
								
							paging += '<ul class="pager">';
							
							if(maker.hasPrev) {
								paging += '<li><a href="'+prev+'">이전</a></li>';	
							}
									
							for(var i= start; i<= end; i++) {
								if(maker.criteria.page == i) {
									paging += '<li><a href="'+i+'" style="pointer-events: none; cursor: default;">'+i+'</a></li>';
								} else {
										paging += '<li><a href="'+i+'">'+i+'</a></li>';	
								}
							}
									
							if(maker.hasNesx) {
								paging += '<li><a href="'+next+'">다음</a></li>';
							}
							paging += '</ul>';
							
							$(".page-num").prepend(paging);
							
							var selectCnt = result[0].noticeCount;
							fn_notice_cnt(selectCnt);
							
						// 검색 결과가 없는 경우
						} else {
							$("#page-num").remove();
							$("#noticeInfo tr").remove();
							
							content += '<tr>';
							content += '<td colspan="4">목록이 없습니다.</td>';
							content += '</tr>';
							
							$("#noticeInfo").prepend(content);
							fn_notice_cnt();
						}
					},
					error : function(request, status, error) {
				    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				}); // end ajax() - 검색 공지사항
			}); // end btnSearch click()

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
			}; // end date_to_str()
			
			function fn_notice_cnt(selectCnt) {
				if(selectCnt == undefined) {
					$("#noticeCnt").text(0);
				} else {
					$("#noticeCnt").text(selectCnt);
				}
			}; // end fn_notice_cnt()
			
		}); // end document
	</script>