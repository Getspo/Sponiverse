<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 공지/안내 작성</title>
</head>
<body>
	<div>
		<h2>공지/안내 작성하기</h2>
		<p>참가자에게 공지/안내할 내용을 작성해주세요.</p>
	</div>
	<div>
		<a href="javascript:" onclick="location.href='host_event_management.do?event_idx=${event.event_idx}'">
			<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAALxJREFUSEvt0jGKAlEQRdHjIgTNR3ENIswuBGPB7Yix4F5UcA+TmAuzCC2wQQys/9UGAzv9zb1Vr15Hy1+nZb6vIE34IyPqYYZlOj7VRw74DgMssM4kNREFfI8fHDHG6V2CLg5X+B9+S+AhL9kg4BHL6JJ9wCf4zyZv3jPBS/CSDVoXxBAvSbKImijvj1x8h1JBiG5rWtykGkEj2WKIOTZZm2oFwetjilUGL2lRCePhP89sUCX9CtK4Wo/oDIwQHhmOKR7aAAAAAElFTkSuQmCC"/>
			돌아가기
		</a>
		<input type="button" value="작성완료">
	</div>
	<div>
		<input name="notice_title" placeholder="제목을 입력하세요.">
	</div>
	<div>
		<textarea name="notice_content" placeholder="공지 및 안내 사항을 작성하세요."></textarea>
	</div>
</body>
</html>