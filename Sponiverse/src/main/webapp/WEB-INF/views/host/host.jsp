<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
			
		<link rel="stylesheet" href="/getspo/resources/css/host/host.css">
		
	</head>
	
	<body>
		<jsp:include page="host_navigation.jsp"/><br>
		
		<div class="host_content">
			<h2 class="menu_title">개최 이벤트 리스트</h2>
			<p class="menu_subtitle">이벤트 관리 페이지로 가려면 이벤트명을 클릭하세요.</p><br>
			
			<c:if test="${not empty events}">
			
			<table border="1">
			<tr>
				<th>행사등록번호</th>
				<th>조회수</th>
				<th>행사이름</th>
				<th>행사장소</th>
				<th>행사일자</th>
				<th>개설일자</th>
			</tr>
			
			<!-- 대회 개설 시, 보여짐 -->
			<c:forEach var="event" items="${events}">
			<tr>
				<td>${event.event_idx}</td>
				<td>${event.event_viewCount}</td>
				<td><a href="javascript:" onclick="location.href='host_event_management.do?event_idx=${event.event_idx}'">${event.event_name}</a></td>
				<td>${event.event_addr}</td>
				<td>${event.formattedEventHStart}</td>
				<td>${event.formattedEventCreateDate}</td>
			</tr>
			</c:forEach>
			</table>
			
			</c:if>
			<c:if test="${empty events}">
				<p>개설된 이벤트가 없습니다</p>
			</c:if>
		</div>	
	</body>
</html>