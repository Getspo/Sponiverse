<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/getspo/resources/css/host/host.css">
<!-- ajax -->
<script src="/getspo/resources/js/httpRequest.js"></script>
</head>

<body>
	<jsp:include page="host_navigation.jsp" /><br>

	<div class="host_content">
		<h2 class="menu_title">개최 이벤트 리스트</h2>
		<p class="menu_subtitle">이벤트 관리 페이지로 가려면 이벤트명을 클릭하세요.</p>
		<br>

		<c:if test="${not empty events}">

			<table border="1">
				<tr>
					<th>행사등록번호</th>
					<th>조회수</th>
					<th>행사이름</th>
					<th>행사장소</th>
					<th>행사일자</th>
					<th>개설일자</th>
					<th>행사삭제</th>
				</tr>

				<!-- 대회 개설 시, 보여짐 -->
				<c:forEach var="event" items="${events}">
				<input type="hidden" id="event_idx" name="event_idx" value="${event.event_idx}">
					<tr>
						<td>${event.event_idx}</td>
						<td>${event.event_viewCount}</td>
						<td><a href="javascript:" onclick="location.href='host_event_management.do?event_idx=${event.event_idx}'">${event.event_name}</a></td>
						<td>${event.event_addr}</td>
						<td>${event.formattedEventHStart}</td>
						<td>${event.formattedEventCreateDate}</td>
						<td><a href="javascript:" onclick="deleteEvent(${event.event_idx})">삭제</a></td>
					</tr>
				</c:forEach>
			</table>

		</c:if>
		<c:if test="${empty events}">
			<p>개설된 이벤트가 없습니다</p>
		</c:if>
	</div>
</body>
<script>
	function deleteEvent(event_idx){
		let idx = document.getElementById("event_idx").value;

		let url = "deleteEvent.do";
		let param = "&event_idx=" + idx;
		sendRequest(url, param, resultFn, "post");
	}

	function resultFn(){
		if(xhr.readyState == 4 && xhr.status == 200){
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if(json[0].result == 'fail'){
				alert("[행사삭제 실패]여러차례 반복될 경우 담당자에게 문의하세요.")
				return;
			}else{
				alert("[행사삭제 완료]개설된 행사가 삭제 되었습니다.")
				location.href='hostMain.do';
			}

		}
	}
</script>
</html>