<%@page import="com.yedam.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="mt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
div.reply div {
	margin: auto;
}

div.reply ul {
	list-style-type: none;
}

div.reply span {
	display: inline-block;
}
</style>

<link rel="stylesheet"
	href="//cdn.datatables.net/2.1.5/css/dataTables.dataTables.min.css">
<script src="js/jquery-3.7.1.js"></script>
<script src="//cdn.datatables.net/2.1.5/js/dataTables.min.js"></script>

<script>
	const bno = '${board.boardNo}'; //원본글번호.
	const writer = '${logid}'; //로그인정보.
</script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<h3>게시글 상세정보</h3>
<%
BoardVO bd = (BoardVO) request.getAttribute("board");
%>
<table class="table">
	<tr>
		<th>글번호</th>
		<td><%=bd.getBoardNo()%></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><%=bd.getTitle()%></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><%=bd.getContent()%></td>
		<td colspan="2" rowspan="3"><c:if test="${!empty board.image }">
				<img width="1000px" src="images/${board.image }">
			</c:if></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=bd.getWriter()%></td>
	</tr>
	<tr>
		<th>작성일시</th>
		<td><%=bd.getCreationDate()%></td>
	</tr>

</table>

<form action="removeBoard.do" name="actForm">
	<input type="hidden" name="keyword" value="${kw }"> <input
		type="hidden" name="searchCondition" value="${sc }"> <input
		type="hidden" name="page" value="${page }"> <input
		type="hidden" name="bno" value="${board.boardNo }">
</form>
<!-- <td><button class="btn btn-info" onclick="history.back()">목록으로</button></td>  -->
<a class="btn btn-info" onclick="form_submit('boardList.do')">목록으로</a>
<a class="btn btn-success ${board.writer ne logid ? 'disabled' : '' }"
	href="modifyBoard.do?page=${page }">수정</a>
<a class="btn btn-danger" onclick="form_submit('removeBoard.do')">삭제</a>
<c:if test="${!empty message }">
	<span style="color: red;">${message }</span>
</c:if>

<!-- 댓글관련 -->
<div class="container reply">
	<!-- 댓글등록 -->
	<div class="header">
		<input type="text" id="reply" class="col-sm-8">
		<button id="addReply" class="btn btn-primary">댓글동록</button>
	</div>
	<!-- 댓글목록 -->
	<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
				<th>댓글번호</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일시</th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<th>댓글번호</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일시</th>
			</tr>
		</tfoot>
	</table>
	<!-- 댓글페이징 -->
</div>

<script>
	//매개값으로 이동할 컨트롤을 받아서 파라미터를 전달.

	function form_submit(uri) {
		document.forms.actForm.action = uri;
		document.forms.actForm.submit();
	}
</script>


