<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 공지/안내 페이지</title>
<!-- css -->
<link rel="stylesheet" href="/getspo/resources/css/host/host_event_notice.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="host_event_navigation.jsp"/>
    <jsp:include page="host_sidebar.jsp"/>
    
    <form class="event_notice">
        <div class="notice_header">
            <h2>
                공지/안내 작성하기
                <input type="button" value="작성하기" onclick="showModal()">
            </h2>    
            <p>공지/안내할 내용을 작성해주세요.</p>
        </div>
    
        <div id="no_notice_message">등록된 공지사항이 없습니다.</div>
        
        <div class="notice_content" style="display: none;">
            <div>
                <h3>
                    <span id="notice_title"></span>
                    <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAIJJREFUSEtjZKAxYKSx+QwjyIKOvon+//8zdDAwMPz/z8BQUlWcv42Y4CU6iNp7Jz5hYGCQhhp6r7I4X5naFjxkYGCQgxr6oLI4X5GqFkCDqIuBkeHH//8MlVQPImJci00N0XFAcwtGUxHBIB5NRcQG0WhZhDukRlMRwVRErgKal6YA5vdXGfdrqV8AAAAASUVORK5CYII="/>
                </h3>
            </div> 
            <span id="write_date"></span>
            <div id="notice_content_body"></div>
        </div>
    </form>

    <!-- Modal -->
    <div class="modal fade" id="noticeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">공지/안내 작성하기</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <label for="modal-title" class="col-form-label">제목:</label>
                <input type="text" class="form-control" id="modal-title">
              </div>
              <div class="form-group">
                <label for="modal-content" class="col-form-label">내용:</label>
                <textarea class="form-control" id="modal-content"></textarea>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary" onclick="saveNotice()">저장하기</button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function showModal() {
            $('#noticeModal').modal('show');
        }

        function saveNotice() {
            var title = document.getElementById('modal-title').value;
            var content = document.getElementById('modal-content').value;
            var date = new Date().toLocaleDateString();

            if (title && content) {
                document.getElementById('notice_title').innerText = title;
                document.getElementById('notice_content_body').innerText = content;
                document.getElementById('write_date').innerText = date;
                
                document.querySelector('.notice_content').style.display = 'block';
                document.getElementById('no_notice_message').style.display = 'none';
            } else {
                alert('제목과 내용을 입력해주세요.');
            }

            $('#noticeModal').modal('hide');
        }

        document.addEventListener('DOMContentLoaded', function() {
            var noticeTitle = document.getElementById('notice_title').innerText;
            var noticeContent = document.getElementById('notice_content_body').innerText;
            if (!noticeTitle && !noticeContent) {
                document.querySelector('.notice_content').style.display = 'none';
                document.getElementById('no_notice_message').style.display = 'block';
            } else {
                document.querySelector('.notice_content').style.display = 'block';
                document.getElementById('no_notice_message').style.display = 'none';
            }
        });
    </script>
</body>
</html>
