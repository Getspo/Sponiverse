<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 페이지</title>
<link rel="stylesheet"
	href="/getspo/resources/css/event/event_detail.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">

<script>
        // 메뉴바 이동
        document.addEventListener("DOMContentLoaded", function() {
            const buttons = document.querySelectorAll(".button_bar button");

            buttons.forEach(button => {
                button.addEventListener("click", function() {
                    buttons.forEach(btn => btn.classList.remove("active"));
                    this.classList.add("active");

                    // 섹션 이동
                    const targetSection = this.getAttribute("data-target");
                    document.getElementById(targetSection).scrollIntoView({ behavior: 'smooth' });
                });
            });

            // 모달 관련 스크립트
            const modal = document.querySelector('.modal');
            const modalOpen = document.querySelector('.modal_btn');
            const modalClose = document.querySelectorAll('.close_btn');
            const submitBtn = document.getElementById('submitQuestion');
            const questionText = document.getElementById('questionText');

            // 모달 열기
            modalOpen.addEventListener('click', function() {
                modal.style.display = 'block';
                questionText.focus();
            });

            // 모달 닫기
            modalClose.forEach(btn => {
                btn.addEventListener('click', function() {
                    modal.style.display = 'none';
                });
            });

            // 문의하기 버튼 클릭 시
            submitBtn.addEventListener('click', function() {
                const question = questionText.value.trim();
                if (question !== '') {
                    const xhr = new XMLHttpRequest();
                    xhr.open('POST', '/your-server-endpoint', true);
                    xhr.setRequestHeader('Content-Type', 'application/json');
                    xhr.onreadystatechange = function() {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            if (xhr.status === 200) {
                                alert('문의가 접수되었습니다.');
                                modal.style.display = 'none';
                            } else {
                                alert('문의 접수 중 오류가 발생했습니다.');
                            }
                        }
                    };
                    const data = JSON.stringify({ question: question });
                    xhr.send(data);
                } else {
                    alert('문의 내용을 입력해주세요.');
                }
            });
        });

        //공지사항 날짜
        document.addEventListener("DOMContentLoaded", function() {
            const noticeDateSpan = document.querySelector(".notice-date");
            const noticeDateStr = noticeDateSpan.dataset.noticeDate; // 데이터셋을 이용해 날짜 값을 가져옴
            const noticeDate = new Date(noticeDateStr);
            const today = new Date();
            
            // 시간 부분을 제거하여 날짜만 비교
            noticeDate.setHours(0, 0, 0, 0);
            today.setHours(0, 0, 0, 0);
            
            // 시간 차이를 계산하여 일 단위로 변환
            const timeDiff = today - noticeDate;
           const diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
            
            // 날짜 차이에 따라 텍스트 설정
            if (diffDays === 0) {
                noticeDateSpan.textContent = "오늘";
            } else {
                noticeDateSpan.textContent = diffDays + "일 전";
            }
        });
    </script>
</head>
<body>
	<jsp:include page="../home/navigation.jsp"></jsp:include><br>
	<div class="event_detail_page">
		<div class="event_line">
			<div>
				<img src="/getspo/resources/upload/${event.event_thumbnail}"
					id="event_image" alt="Event Thumbnail">
			</div>
			<div class="button_bar">
				<ul>
					<li>
						<button type="button" class="active" data-target="intro">
							<span>행사소개</span>
						</button>
					</li>
					<li>
						<button type="button" data-target="place">
							<span>행사장소</span>
						</button>
					</li>
					<li>
						<button type="button" data-target="notice">
							<span>공지/안내</span>
						</button>
					</li>
					<li>
						<button type="button" data-target="ask">
							<span>문의하기</span>
						</button>
					</li>
					<li>
						<button type="button" data-target="cancel">
							<span>취소/환불</span>
						</button>
					</li>
				</ul>
			</div>
			<br>
			<hr>
			<br>

			<section id="intro" class="intro">
				<div>
					<span>일시 : </span> <span>${event.getFormattedEventHStart()}~${event.getFormattedEventHEnd()}</span>
				</div>
				<div>
					<span>신청 : </span> <span>${event.getFormattedEventRStart()}~${event.getFormattedEventREnd()}</span>
				</div>
				<div>
					<span>비용 : </span>
					<c:choose>
						<c:when test="${event.event_price > 0}">
							<fmt:formatNumber value="${event.event_price}" type="number"
								groupingUsed="true" />원
                        </c:when>
						<c:otherwise>
							<span>무료</span>
						</c:otherwise>
					</c:choose>
				</div>
				<div>
					<span>장소 : </span> <span>${event.event_addr}${event.event_addrdetail}</span>
				</div>
			</section>

			<hr>
			<br>

			<section id="content" class="content">
				<div>${event.event_content}</div>
			</section>

			<section id="place" class="place">
				<div>
					<h4>행사장소</h4>
					<div>
						<span id="loc">장소</span> <span>${event.event_addr}${event.event_addrdetail}</span>
					</div>
				</div>
			</section>

			<section id="notice" class="notice">
				<c:choose>
					<c:when test="${empty notice}">
						<div>
							<h4>공지/안내</h4>
							<div class="notice_box">
								<span>등록된 공지/안내가 없습니다.</span>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<h4>공지/안내</h4>
						<div class="notice-container">
							<div class="notice-header">
								<div class="notice-title">${notice.notice_title}</div>
								<span class="notice-date"
									data-notice-date="${notice.notice_date}"></span>
							</div>
							<div class="notice-content" id="feedBody">
								<div class="notice-content-body">${notice.notice_content}</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</section>

			<section id="ask" class="ask">
				<div>
					<h4>
						문의하기
						<button type="button" class="modal_btn">호스트에게 문의하기</button>
					</h4>
					<div class="ask_box">
						<span>등록된 문의가 없습니다.</span>
					</div>
				</div>
			</section>

			<section id="contact" class="contact">
				<div>
					<div>
						<div class="contact_category">
							<span>담당자</span>
						</div>
						<div class="contact_db" id="name">${event.event_contact_name}</div>
					</div>
					<div>
						<div class="contact_category">
							<span>이메일</span>
						</div>
						<div class="contact_db" id="email">${event.event_contact_email}</div>
					</div>
					<div>
						<div class="contact_category">
							<span>전화번호</span>
						</div>
						<div class="contact_db" id="tel">${event.event_contact_tel}</div>
					</div>
				</div>
			</section>

			<section id="cancel" class="cancel">
				<div>
					<h4>취소 및 환불규정</h4>
					<div class="cancel_box">
						<div>
							<span>- <b>행사의 취소/환불 기간은</b> 행사 호스트가 설정한 신청기간과 동일합니다.
							</span>
						</div>
						<div>
							<span>- 신청한 행사의 <b>신청 정보 수정 및 취소/환불은</b> ‘마이페이지-신청 행사’에서 할
								수 있습니다.
							</span>
						</div>
						<div>
							<span>- 결제 수단, 환불 신청 시점, 환불 사유에 따라 <b>환불 수수료가 부과</b>될 수
								있습니다.
							</span>
						</div>
						<div style="color: red;">
							<span>*이벤터스는 통신판매 중개자이며, 해당 행사의 호스트가 아닙니다.</span>
						</div>
					</div>
				</div>
			</section>
		</div>

		<div class="apply_line">
			<div class="apply_box">
				<div class="apply_category">
					<c:choose>
						<c:when test="${event.event_sports_idx == 1}">
							<a href="javascript:"
								onclick="location.href='event_list.do?event_loc=all&event_sports_idx=1'"
								id="sports">러닝</a>
						</c:when>
						<c:when test="${event.event_sports_idx == 2}">
							<a href="javascript:"
								onclick="location.href='event_list.do?event_loc=all&event_sports_idx=2'"
								id="sports">철인3종</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:"
								onclick="location.href='event_list.do?event_loc=all&event_sports_idx=0'"
								id="sports">기타</a>
						</c:otherwise>
					</c:choose>
					<span>|</span> <a href="javascript:"
						onclick="location.href='event_list.do?event_loc=${event.event_loc}'"
						id="loc">${event.event_loc}</a>
				</div>
				<div class="apply_name">
					<span>${event.event_name}</span>
				</div>
				<div class="apply_ticket">
					<div class="ticket_details">
						<span class="ticketname">${event.event_ticketname}</span>
						<div class="price">
							<c:choose>
								<c:when test="${event.event_price > 0}">
									<fmt:formatNumber value="${event.event_price}" type="number"
										groupingUsed="true" />원
                				</c:when>
								<c:otherwise>
									<span>무료</span>
								</c:otherwise>
							</c:choose>
							</div>
					</div>
				</div>
				
				<div class="remain" style="${event.event_ticket_open eq 'open' ? '' : 'display: none;'}">
    <span>잔여수량 : ${remainticket}</span>
</div>
				<input type="button" id="apply_btn" value="신청하기"
					onclick="location.href='event_apply.do?event_idx=${event.event_idx}'">
			</div>
		</div>
	</div>

	<div class="modal" style="display: none;">
		<div class="modal_popup">
			<h3>호스트에게 문의하세요!</h3>
			<p>행사와 관련 없거나, 부적합한 내용이 기재되어 있을 경우 관리자에 의해 삭제되거나 차단 될 수 있습니다</p>
			<textarea id="questionText" rows="4"
				placeholder="문의 사항이 자세할수록 더욱 정확한 답변을 받으실 수 있습니다."></textarea>
			<button type="button" class="close_btn">닫기</button>
			<button type="button" id="submitQuestion" class="submit_btn">문의하기</button>
		</div>
	</div>
</body>
</html>
