<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/booking_main.css">
<link rel="stylesheet" href="/resources/css/booking_form.css">
<link rel="shortcut icon" href="/resources/img/shortCut.png">


<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>

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
					<!-- 날짜 선택 -->
					<div class="reservation-date">


						<div class="reservation-date-inner">
							<c:if test="true">
								<button class="date-prev-btn date-btn"><</button>
							</c:if>


							<span class="date-btn-list"></span>


							<c:if test="true">
								<button class="date-next-btn date-btn">></button>
							</c:if>
						</div>

						<span><input type="hidden" name="dateValue" id="dateVal" ></span>		
						<span class="date-icon"><input type="hidden" name="date"
							id="datepicker" size="12" /></span>


					</div>
					<!-- // 날짜 선택 -->
					<!-- 영화,시간 -->
					<div class="frame-main-body clearfix">
						<!-- 영화 목록 -->
						<div class="movie-frame">
							<div class="movie-frame-title">영화</div>
							<!-- 1 -->
							<div>
								<!-- 영화 선택 -->
								<div class="movie-area">
									<!-- 영화 list -->
									<div class="movie-list" align="center">
										<ul class ="list"  style="none;">
											<!-- 영화 제목 출력 -->											
											<c:forEach var="movieVO" items="${movieList }">
												<li><button type="button" id="movie-btn" onclick="movieBtnClick(this.value)" value="${movieVO.movieNo}" >
												<span ><img id="movie-age-${movieVO.movieAge }"  alt="${movieVO.movieAge }" src=""></span>
												<span class="title">${movieVO.movieTitle }</span>
												</button></li>
											</c:forEach>	
										</ul>
									</div>
									<!--// 영화 list -->
								</div>
								<!--// 영화 선택 -->
								<!-- 영화 포스터 -->
								<div class="movie-poster">
									<div class="poster-area">
										<img class="poster " alt="poster_area"
											src="/resources/img/poster_area.png">
									</div>
								</div>
								<!--// 영화 포스터 -->
							</div>
							<!-- // 1 -->
						</div>
						<!-- // 영화 목록 -->
						<!-- 상영시간 선택 -->
						<div class="schedule-frame">
							<!-- 제목 -->
							<div class="schedule-frame-title">시간</div>
							<!-- 상영 시간 -->
							<div class="schedule-hour"></div>
							<!-- 상영 목록 -->
							<div class="schedule-list">
								<ul class ="list" style="list-style-type: none; magin: 0;">
									
								</ul>
							</div>							
							<!-- // 상영 목록 -->
						</div>
						<!-- // 상영시간 선택 -->
					</div>
					<!-- // 영화,시간 -->

				</div>
				<!-- // frame-main -->

			</div>

		</div>
		<!-- // frame -->

	</div>
	<!-- // frame(여백포함) div -->
	<!-- Footer -->


	<jsp:include page="../footer.jsp"></jsp:include>

	<!-- // Footer -->

 	<!-- 날짜버튼관련 script -->
	<script type="text/javascript">
		let date = new Date(); // 오늘날짜 설정
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		
		$('#dateVal').val(date);	 
		
		
			getDate(date); // 날짜를 출력하는 함수 	
		
			
			
		
		function getDate(date){ 
				let list = ''; // 출력할 요소
				let week = ''; // 요일(한글)				
				let dateVal = '' // 버튼에 들어가는 날짜 값
				
				for(var i=0; i<14; i++){ 
					
					switch(date.getDay()){ // 요일(한글 입력)
					case 0:
						week = '일';
						 break;
					case 1:
						week = '월';
						 break;
					case 2:
						week = '화';
						 break;
					case 3:
						week = '수';
						 break;
					case 4:
						week = '목';
						 break;
					case 5:
						week = '금';
						 break;
					case 6:
						week = '토';
						 break;
					default:
						console.log('요일 error');
					} // end switch						
						if(week=="일"){
							list += '<button type="button" id="date-btn-sun" onclick="dateBtnClick(this.value)" value=" ' +  
							date + ' "">' +"<div class='date-text' id='" + date.getDate() +"'>" + date.getDate() + "."+ week + "<div>";  
							+'</button>' ;
						}else if(week=="토"){
							list += '<button type="button" id="date-btn-sat" onclick="dateBtnClick(this.value)" value=" ' +  
							date + ' "">' +"<div class='date-text' id='" + date.getDate() +"'>"+ date.getDate() + "."+ week + "<div>";  
							+'</button>' ;
						} else {
							list += '<button type="button" id="date-btn" onclick="dateBtnClick(this.value)" value=" ' +  
							date + ' "">' +"<div class='date-text' id='" + date.getDate() +"'>" +  date.getDate() + "."+ week + "<div>";  
							+'</button>' ;
							
						} // end if
				
					// 버튼 출력					
					
					if(i != 13){ // 반복문 마지막 순서에서 date 값을 첫번째 버튼의 날짜로 변경
					 date.setDate(date.getDate() +1);						
					}else {
					date.setDate(date.getDate() - 13);
					 console.log('첫번째 버튼날짜 : ' + date);
						}					
					} // end for
					
				$('.date-btn-list').html(list);	// 버튼 추가
				$('#dateVal').val(' ' + date);  // 오늘날짜 input에 넣어주기
				choiceDate();
				
				function choiceDate(){
					let dateValue = $('#dateVal').val();
						console.log("ㅠㅠ"  +$('#dateVal').val());	
						let day = dateValue.substring(9,11);
						if(day<10){
							day = day.substring(1,2);							
						}
						
						$("#"+day).attr("id","day-choice");			
				}
				
				} // end getDate()	
		
				
			
					$('.date-prev-btn').click(function(){
						let today = new Date();
						if(today >= date){ // 이전 날짜가 오늘 날짜보다 작으면 실행하지않음.
							console.log('오늘 날짜보다 작습니다.')
						}else {
							date.setDate(date.getDate() -1);
							console.log(date.getDate());
							getDate(date);	
							dateBtnClick(" " +date);
						}								
					}); // end next-prev-click()
					
					$('.date-next-btn').click(function(){
						date.setDate(date.getDate() +1);
						console.log("첫번째 버튼 날짜 : " + date);
						getDate(date);
						dateBtnClick( ' ' + date);
						}); // end next-btn-click()
						
						
	</script>	

 	<!-- 날짜버튼을 클릭하면 영화제목과 영화스케줄을 가져오는 스크립트 -->
	<script type="text/javascript">
	dateBtnClick($('#dateVal').val());
	
	
	
	function dateBtnClick(dateVal){		
			$('#dateVal').val(dateVal); // 날짜를 저장하는 input에 클릭한 값 넣어주기 	
			
			
			
			dateVal = dateVal + '';
		 	let yyyy = dateVal.substr(12,4);
            let mm = dateVal.substr(5,3);
            let dd = dateVal.substr(9,2);
            switch(mm){
            case "Jan" : mm = "01";
    		break;
    		case "Feb" : mm = "02";
    		break;
    		case "Mar" : mm = "03";
    		break;
    		case "Apr" : mm = "04";
    		break;
    		case "May" : mm = "05";
    		break;
    		case "Jun" : mm = "06";
    		break;
    		case "Jul" : mm = "07";
    		break;
    		case "Aug" : mm = "08";
    		break;
    		case "Sep" : mm = "09";
    		break;
    		case "Oct" : mm = "10";
    		break;
    		case "Nov" : mm = "11";
    		break;
    		case "Dec" : mm = "12";
    		break;		
            }           
          let strDate = yyyy + mm + dd;
            console.log("날짜 : " + strDate);
		
		// 해당 날짜의 영화 제목을 가져오는 ajax
		let movieUrl = '/booking/movies/' +strDate;
		
		$.getJSON(movieUrl,function(movieList){
			let list = '';
		/* 	if(movieList == ''){
				list =  '<li><button type="button" id="movie-btn" onclick="movieBtnClick(this.value)"value=' +this.movieNo + '>'+
					"상영가능한 영화가 없습니다." +
  	    		'</button></li>'
			} */
			$(movieList).each(
					function(){
						console.log("흠"+movieList);
					list += '<li><button type="button" id="movie-btn" onclick="movieBtnClick(this.value)"value=' +this.movieNo + '>'+
					'<span>' + '<img id="' + this.movieAge + '"  alt="" src="'+movieAge(this.movieAge)+'">' + '</span>' +
	  	    		'<span>' + this.movieTitle + '</span>' +
	  	    		'</button></li>'					
				}); // end each()
			 $('.movie-list').html(list);

			} // end callback()
		); // end getJSON
		
		
		// 해당 날짜의 영화 상영일정을 가져오는 ajax
		let scheduleUrl = '/booking/schedules/' + strDate;
		
		$.getJSON(scheduleUrl,function(scheduleList){		
			list = '';
			if(scheduleList == ''){
				list =  '<li><button id="schedule-btn">'+
				"상영가능한 영화가 없습니다." +
  	    		'</button></li>'		
			}
			$(scheduleList).each(
					function(){					
						if(this.seatCount != 0){
							list += '<li><button id="schedule-btn" onclick="scheduleBtnClick(this.value)" value=' +this.scheduleNo + '>'+
							'<div class ="left">' +
							'<div class="time">' +
			  	    		'<span class="start-time">' + this.scheduleTime+ "  " + '</span>' +
			  	    		'<span class="show-time">' + "(" + this.movieShowtime +  ")  " + '</span>' +
			  	    		'</div>' +		  	    		
			  	    		'<span class="title">' +" "+ this.movieTitle + "  " + '</span>' +
			  	    		'</div>' +
			  	    		'<div class="right" >' +
			  	    		'<span class="theater">' + this.theaterName + "  " + '</span>' +
			  	    		'<div class="count"> ' +
			  	    		'<span class="seat-count">' + this.seatCount + '</span>' +
			  	    		'<span class= "seat-amount">' +" / " + this.theaterSeat + '</span>'  +
			  	    		'</div> </div>' +		  	    		
			  	    		'</button></li>'		
						}					
				}); // end each()
			 $('.schedule-list ul').html(list);			
			} // end callback()
		); // end getJSON		
			$(".poster").attr("src", "/resources/img/poster_area.png");
			$(".poster").attr("alt", "poster_area");
			
			$(document).on("click",".date-btn-list button",function(){		
				let dateValue = $('#dateVal').val();
				console.log("아" + dateValue);
				$("#day-choice").attr("id"," ");
				$(".choice-btn").attr("class"," ");
				$("button[value='" + dateValue + "']").attr("class", "choice-btn");
				$(".choice-btn .date-text").attr("id","date-choice");
			}) // end date-btn click()
	} // end dateBtnClick()
	

	//  해당 영화연령의 포스터를 가져오는 함수
	function movieAge(movieAge){
		switch(movieAge){
		case 0 :
			movieAge = "https://img.megabox.co.kr/static/pc/images/common/txt/txt-age-small-all.png";
			break;
		case 12 :
			movieAge = "https://img.megabox.co.kr/static/pc/images/common/txt/txt-age-small-12.png";
			break;
		case 15 :
			movieAge = "https://img.megabox.co.kr/static/pc/images/common/txt/txt-age-small-15.png";
			break;
		case 19 :
			movieAge = "https://img.megabox.co.kr/static/pc/images/common/txt/txt-age-small-19.png";
			break;
		}
		return movieAge;
	} //end movieAge
	
	
	
	</script>	

	<!-- 영화버튼을 클릭하면 해당영화스케줄을 가져오는 스크립트 -->
	<script type="text/javascript">
	
	function movieBtnClick(movieNo){		
		let dateVal = $('#dateVal').val(); // 날짜 값
		console.log("영화번호 : " + movieNo);
		
		let yyyy = dateVal.substr(12,4);
        let mm = dateVal.substr(5,3);
        let dd = dateVal.substr(9,2);
        switch(mm){
        case "Jan" : mm = "01";
		break;
		case "Feb" : mm = "02";
		break;
		case "Mar" : mm = "03";
		break;
		case "Apr" : mm = "04";
		break;
		case "May" : mm = "05";
		break;
		case "Jun" : mm = "06";
		break;
		case "Jul" : mm = "07";
		break;
		case "Aug" : mm = "08";
		break;
		case "Sep" : mm = "09";
		break;
		case "Oct" : mm = "10";
		break;
		case "Nov" : mm = "11";
		break;
		case "Dec" : mm = "12";
		break;		
        }           
      let strDate = yyyy + mm + dd;
        console.log("날짜 : " + strDate);       
        
     // 해당 날짜, 선택영화의 상영일정을 가져오는 ajax
		let scheduleUrl = '/booking/schedules/' + strDate + '/' + movieNo;
		
		$.getJSON(scheduleUrl,function(scheduleList){
			let list = '';
		
			$(scheduleList).each(
					
					function(){
						if(this.seatCount != 0){
							list += '<li><button id="schedule-btn" onclick="scheduleBtnClick(this.value)" value=' +this.scheduleNo + '>'+
							'<div class ="left">' +
							'<div class="time">' +
			  	    		'<span class="start-time">' + this.scheduleTime+ "  " + '</span>' +
			  	    		'<span class="show-time">' + "(" + this.movieShowtime +  ")  " + '</span>' +
			  	    		'</div>' +		  	    		
			  	    		'<span class="title">' +" "+ this.movieTitle + "  " + '</span>' +
			  	    		'</div>' +
			  	    		'<div class="right" >' +
			  	    		'<span class="theater">' + this.theaterName + "  " + '</span>' +
			  	    		'<div class="count"> ' +
			  	    		'<span class="seat-count">' + this.seatCount + '</span>' +
			  	    		'<span class= "seat-amount">' +" / " + this.theaterSeat + '</span>'  +
			  	    		'</div> </div>' +		  	    		
			  	    		'</button></li>'		
						}						
				}); // end each()
			 $('.schedule-list ul').html(list);
			} // end callback()
		); // end getJSON
        
		
		  let movieUrl = '/booking/moviePoster/' + movieNo;
			$.getJSON(movieUrl, function(movieVO){
					$(".poster").attr("src",movieVO.moviePoster)
				} // end callback()
			); // end getJSON()		
	
		
	} // end movieBtnClick() 
	</script>	
			
	<!-- datepicker -->
	<script type="text/javascript">
//datepicker
$(function() {
  $("#datepicker").datepicker({
    showOn : "button",
    buttonImage : "/resources/img/calender.png",
    buttonImageOnly : false,
    buttonText : "Select date",
    minDate : 0,
    onSelect : function(dateText, inst) {
      let yyyy = dateText.substr(6, 4);
      let mm = dateText.substr(0, 2);
      let dd = dateText.substr(3, 2);
      const datePicker = new Date(yyyy, mm - 1, dd);
      btnDate = datePicker;
      console.log("btnDate : " + datePicker);
      getDate(datePicker);
      dateBtnClick(' ' + datePicker); // 날짜의 str 규칙을 맞춰주기
    } // end onSelect()
  }); // end datepicker
}); // end document
</script>			
	
	
	<!-- 스케줄 클릭시 값 넘겨주기  -->
	<script type="text/javascript">	
			function scheduleBtnClick(scheduleNo){				
				const memberId = $('#member-id').val();
				
					console.log("상영번호" + scheduleNo);
					let action = "/booking/seat";
					let param = scheduleNo;
					let val = $(".count .seat-amount").val();
					console.log(val);				
					sendPost(action, param);
				
				
				
				function sendPost(action, param) {
					console.log("action : " + action);
					console.log("param : " + param);
					const form = document.createElement('form');
					form.setAttribute('method', 'post');
					form.setAttribute('action', action);
					
					const hiddenField = document.createElement('input');

					hiddenField.setAttribute('type', 'hidden');
					hiddenField.setAttribute('name', 'scheduleNo');
					hiddenField.setAttribute('value', param);
					form.appendChild(hiddenField);			

					document.body.appendChild(form);
					form.submit();
				} // end sendPost()
				
			} // end scheduleBtnClick()		
	</script>
	
	
	
	
	
	
