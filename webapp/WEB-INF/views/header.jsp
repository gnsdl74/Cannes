<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- Header -->
	<header id="header">
		<div class="menubar" align="center">
		
			<div class="header-inner">
				<a class="logo" href="/" title="Cannes 메인으로 가기"><img src="/resources/img/NewLogo.png" alt="Cannes메인으로" /></a>
	
				<nav class="clearfix">
					<a href="/movieList" title="영화" class="menu">영화</a>
					<a href="/booking" title="예매" class="menu">예매</a>
					<a href="/notice" title="공지사항" class="menu">공지사항</a>
				</nav>
				<div class="header-util">
				<c:if test="${empty memberId }">
						<a id="login" href="" title="로그인">로그인</a>
						<a href="/tos" title="회원가입">회원가입</a>
					</c:if>
					<c:if test="${not empty memberId }">
						<a id="logout" href="" title="로그아웃">로그아웃</a>
						<a href="/mypage" title="마이페이지">마이페이지</a>
					</c:if>
					<div class="header-search">
						<a href="movieList"><i class="material-icons">&#xe8b6;</i></a>
					</div>
					
				</div>
			</div>
		</div>
	</header>
	<!-- // Header -->

