<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage_event</title>
<!-- ajax -->
<script src="/getspo/resources/js/httpRequest.js"></script>

</head>

<body>
	<div class="content_event">
		<h2>참가 행사 목록</h2>
		<div>
			<c:if test="${not empty order}">

				<table border="1">
					<tr>
						<th>카테고리</th>
						<th>행사이름</th>
						<th>행사장소</th>
						<th>행사날짜</th>
						<th>신청날짜</th>
						<th>참가취소</th>
					</tr>

					<c:forEach var="order" items="${order}">

						<input type="hidden" id="user_idx" name="user_idx" value="${order.user_idx}">
						<input type="hidden" id="event_idx" name="event_idx" value="${order.event_idx}">

						<tr>
							<td><c:choose>
									<c:when test="${order.event_sports_idx == 1}">러닝</c:when>
									<c:when test="${order.event_sports_idx == 2}">철인3종</c:when>
									<c:otherwise>기타</c:otherwise>
								</c:choose></td>
							<td><a href="javascript:" onclick="location.href='event_detail.do?event_idx=${order.event_idx}'"> ${order.event_name} </a></td>
							<td>${order.event_addr}</td>
							<td>${order.formattedEventHStart}</td>
							<td>${order.formattedOrderDate}</td>
							<td><a href="javascript:" onclick="cancelEvent(${order.user_idx})">삭제</a></td>
						</tr>


					</c:forEach>
				</table>
			</c:if>
			<c:if test="${empty order}">
				<p>개설된 이벤트가 없습니다</p>
			</c:if>
		</div>
	</div>
</body>
<script>
	function cancelEvent(user_idx) {
		let idx = document.getElementById("user_idx").value;
		let event_idx = document.getElementById("event_idx").value;
		
		
//이후, 유료 티켓의 '신용카드/간편결제'로 참가를 진행한 경우 환불 절차를 추가할 것.
		
	   
	    let url = "cancelEvent.do";
	    let param = "&user_idx=" + idx + "&event_idx=" + event_idx;
	    sendRequest(url, param, resultFn, "post");
	}
	function resultFn() {
	    if (xhr.readyState == 4 && xhr.status == 200) {
	       
	    	let data = xhr.responseText;
	    	let json = (new Function('return ' + data))();
	    	if (json[0].result == 'no') {
				alert("비밀번호가 일치하지 않습니다.");
				return;
			} else if (json[0].result == 'fail') {
				alert("[행사취소 실패]여러차례 반복될 경우 담당자에게 문의하세요.");
				return;
			} else {
				alert("[행사취소 완료]회원님의 모든 정보가 삭제 되었습니다.");
				location.href = 'mypageform.do?user_idx=${vo.user_idx}&menu=link1';
			}
	    	
	    }
	}
</script>
</html>