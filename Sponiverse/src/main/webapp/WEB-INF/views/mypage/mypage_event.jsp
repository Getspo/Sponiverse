<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage_event</title>

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
         </tr>
         
         <c:forEach var="order" items="${order}">
         <tr>
            <td>
                    <c:choose>
                        <c:when test="${order.event_sports_idx == 1}">
                            러닝
                        </c:when>
                        <c:when test="${order.event_sports_idx == 2}">
                            철인3종
                        </c:when>
                        <c:otherwise>
                            기타
                        </c:otherwise>
                    </c:choose>
                </td>
            <td>
               <a href="javascript:" 
               onclick="location.href='event_detail.do?event_idx=${order.event_idx}'">
               ${order.event_name}
               </a>
            </td>
            <td>${order.event_addr}</td>
            <td>${order.formattedEventHStart}</td>
            <td>${order.formattedOrderDate}</td>
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
</html>