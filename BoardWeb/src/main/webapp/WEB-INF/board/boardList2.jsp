<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.yedam.vo.BoardVO"%>
<%@page import="java.util.List"%>


<h3>게시글 목록</h3>
<div class="center">
	<form action="boardList.do">
		<div class="row">
			<!-- 검색조건(title, writer 검색) -->
			<div class="col-sm-2">
				<select name="searchCondition" class="form-control">
					<option value="">선택하세요</option>
					<option value="T" ${sc eq 'T' ? 'selected' : '' }>제목</option>
					<option value="W" ${sc eq 'W' ? 'selected' : '' }>작성자</option>
					<option value="TW" ${sc eq 'TW' ? 'selected' : '' }>제목 & 작성자</option>
				</select>
			</div>
			<!-- 키워드 -->
			<div class="col-sm-3">
				<input type="text" name="keyword" value="${kw }" class="form-control">
			</div>
			<!-- 조회버튼 -->
			<div class="col-sm-2">
				<input type="submit" value="조회" class="btn btn-primary">
			</div>		
		</div><!-- end of div.row -->
	</form>
</div><!-- end of div.center -->

<c:choose>
	<c:when test="${!empty message }">
		<p>"${empty message }"</p>
	</c:when>
	<c:otherwise>
		<table class="table">
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일시</th>
				</tr>
			</thead>
			<tbody>
				<!-- for (BoardVO board : list) { -->
				<c:forEach var="board" items="${list }">
					<tr>
						<td><c:out value="${board.boardNo }" /></td>
						<td><a href="getBoard.do?page=${paging.page }&bno=${board.boardNo}&keyword=${kw }&searchCondition=${sc }">${board.title }</td>
						<td>${board.writer }</td>
						<td>${board.viewCnt }</td>
						<td><fmt:formatDate value="${board.creationDate}"
								pattern="yyyy.MM.dd HH:mm:ss" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<p>${paging }</p>
		<nav aria-label="...">
			<ul class="pagination">
				<li class="page-item ${paging.prev ? '' : 'disabled' }"><a
					class="page-link" href="boardList.do?page=${paging.startPage-1 }&keyword=${kw }&searchCondition=${sc }&">Previous</a>
				</li>
				<c:forEach var="pg" begin="${paging.startPage }"
					end="${paging.endPage }">
					<c:choose>
						<c:when test="${paging.page == pg }">
							<li class="page-item active" aria-current="page"><a
								class="page-link" href="boardList.do?page=${pg }&keyword=${kw }&searchCondition=${sc }">${pg }</a></li>
						</c:when>
						<c:otherwise>
							<!-- 현재 페이지 아닌 경우 -->
							<li class="page-item"><a class="page-link"
								href="boardList.do?page=${pg }&keyword=${kw }&searchCondition=${sc }">${pg }</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<li class="page-item ${paging.next ? '' : 'disabled' }"><a
					class="page-link" href="boardList.do?page=${paging.endPage+1 }&keyword=${kw }&searchCondition=${sc }&">Next</a></li>
			</ul>
		</nav>
	</c:otherwise>
	
</c:choose>


<p>${'문자열, 숫자, boolean null' }</p>
<p>${3+5 > 10 ? '참입니다' : '거짓입니다.'}</p>

<%
String name = "hong";
%>

<c:set var="name" value="Hongkildong"></c:set>
<c:out value="">"${name }"</c:out>
<c:set var="age" value="20"></c:set>
<c:out value="${age >= 20 ? '성인' : '미성년' }"></c:out>

<c:if test="${name ne 'Hongkildong' }">
	<p>털렸습니다</p>
</c:if>

