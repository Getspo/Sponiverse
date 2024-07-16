<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>행사 관리</title>
		
		<!-- css -->
        <link rel="stylesheet" href="/getspo/resources/css/host/host_event_management.css">
        
        <!-- js -->
        <!-- <script src="/getspo/resources/js/host_event_management.js"></script> -->
		
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>                
	</head>
	<body>
		<jsp:include page="host_event_navigation.jsp"/>
		<jsp:include page="host_sidebar.jsp"/>
		
		<div class="row channel-list-row">
		    <div class="col s12 justify-content-between">
		        <div class="d-flex justify-content-between align-items-center">
		            <div class="d-flex">
		                <div class="selectbox">
		                    <select class="browser-default d-inline-block" style="width: 150px;">
		                        <option value="all">전체</option>
		                        <option value="add">참가확정자</option>
		                        <option value="payattend">참가대기자</option>
		                        <option value="outstanding">미결제자</option>
		                    </select>
		                </div>
		                <div class="selectbox mx-16px">
		                    <select class="browser-default d-inline-block" style="width: 150px;">
		                        <option value="all">전체</option>
		                        <option value="true">출석</option>
		                        <option value="false">출석안함</option>
		                    </select>
		                </div>
		                <div class="selectbox" style="width: 200px;">
		                    <select class="browser-default d-inline-block">
		                        <option value="all">티켓 정보</option>
		                        <option value="Group1">개인</option>
		                        <option value="Group2">릴레이</option>
		                    </select>
		                </div>
		            </div>
		        </div>
		    </div>
		    <div class="col s12 mt-3">
		        <div class="align-items-center">
		            <div class="d-flex justify-content-between align-items-center">
		                <div>
		                    <label>신청인원: 44명</label> / 
		                    <label> 신청 티켓 수: 44개</label> / 
		                    <label>모집 정원: 700명</label>
		                </div>
		                <div>
		                    <div class="d-flex align-items-center">
		                        <a class="eventus-btn eventus-btn-w p-2 mr-2" style="border: none;">QR출석/명찰출력</a>
		                        <a class="eventus-btn eventus-btn-w p-2 mr-2" style="border: none;">다운로드</a>
		                        <div class="position-relative d-inline-block">
		                            <a class="eventus-btn eventus-btn-w p-2 dropDown" style="border: none;">+ 추가/업로드 <i class="mdi-hardware-keyboard-arrow-down dropDown"></i></a>
		                            <div id="e-dropdown-data" class="position-absolute d-none e-dropdown-content">
		                                <a class="d-block w-100" style="padding: 10px 16px;">참가자 추가하기</a>
		                                <a class="d-block w-100 modal-trigger" style="padding: 10px 16px; z-index: 1005;">엑셀 업로드</a>
		                            </div>
		                        </div>
		                        <div class="ml-10px" style="position: relative;">
		                            <input placeholder="참가자 검색" class="eventus-input" style="width: 200px; height: 40px;">
		                            <button class="eventus-search_button"><i class="mdi-action-search"></i></button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		    <div class="col s12 mt-3" style="background: rgb(248, 250, 251);">
		        <div class="py-3 font-weight-bold">
		            <div class="row">
		                <div class="col s2"><span>신청자 정보</span></div>
		                <div class="col s5 px-0">
		                    <span class="d-inline-block" style="width: 40%;">신청 티켓</span>
		                    <span class="d-inline-block px-10px" style="width: 30%;">결제</span>
		                    <span class="d-inline-block px-10px">상태</span>
		                </div>
		                <div class="col s1"></div>
		                <div class="col s2"></div>
		                <div class="col s2"></div>
		            </div>
		        </div>
		    </div>
		    <div class="col s12 txt-15">
		        <div class="row">
		            <div class="col s2">
		                <div class="py-3">
		                    <div>
		                        <div class="font-weight-700">전성현</div>
		                        <div title="efging6875@naver.com" style="word-break: break-all;">ef********@naver.com</div>
		                        <div title="01051761549">010****1549</div>
		                        <div>개인코드 : <span>Ej2v2D</span></div>
		                        <div class="mt-4px" style="display: none;">
		                            <a class="d-inline-block text-underline">사전 설문</a>
		                        </div>
		                        <div class="mt-10px">신청일 : 24년06월06일</div>
		                    </div>
		                </div>
		            </div>
		            <div class="col s5">
		                <div class="row attendee-border-bottom">
		                    <div class="py-3" style="width: 40%;"><span class="d-inline-block">개인</span>
		                        <div class="mt-2 mr-10px d-flex justify-content-between"><span>1개</span></div>
		                    </div>
		                    <div class="px-10px py-3" style="width: 30%;">
		                        <div class="mb-10px">110,000원</div>
		                        <p>
		                            <span style="font-size: 12px;">결제완료/신용카드</span> <br>
		                            <span style="font-size: 12px;">2024-06-06 오후 6:46:10</span>
		                        </p>
		                    </div>
		                    <div class="px-10px py-3" style="width: 30%;">
		                        <div><span style="color: rgb(141, 113, 221);">참가확정</span></div>
		                        <span class="d-inline-block txt-12 mt-10px" style="border: 1px solid rgb(228, 228, 228); cursor: pointer; border-radius: 6px; padding: 4px 6px; background-color: white;">상태변경</span>
		                    </div>
		                </div>
		            </div>
		            <div class="col s1 py-3 position-relative" style="display: inline-block;">
		                <div>
		                    <span class="mr-16px">
		                        <input type="checkbox" id="allAttend0" class="filled-in">
		                        <label for="allAttend0">출석</label>
		                    </span>
		                </div>
		            </div>
		            <div class="col s2 py-3"><span style="word-break: break-all;"></span></div>
		            <div class="col s2 py-3 position-relative text-right">
		                <span>
		                    <input type="checkbox" id="cancelLockCheckbox0" class="filled-in">
		                    <label for="cancelLockCheckbox0">참가자 취소 잠금 설정</label>
		                </span>
		                <div class="mt-10px">
		                    <span class="text-center mr-10px" style="display: none;"><a download="">파일 다운로드</a></span>
		                    <a class="d-inline-block">메모</a>
		                    <a href="#editModal" class="modal-trigger ml-10px" style="color: rgb(58, 132, 232); z-index: 1007;">수정</a>
		                    <a href="#PaymentCancelModal" class="modal-trigger ml-10px" style="color: rgb(191, 69, 69); z-index: 1009;">취소/환불</a>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</body>
</html>