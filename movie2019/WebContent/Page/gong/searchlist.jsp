<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp" %>
<%
pageContext.setAttribute("br", "<br/>");
pageContext.setAttribute("cn", "\n");
%>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	color: white;
}
.page-link{
background-color: black;
color: white;
border: none;

}
.pagination{
justify-content:center;

}
td, th{
text-align: center;
}
.cursor_test {cursor: pointer;}
</style>
<script type="text/javascript">
	$(function() {
		for(let a =1; a<11;a++){
		$("#oclick"+a).click(function(){
			$("#divresult" + a).toggle('midle');}); 		
		}
		
	});
</script>
</head>
<body>

<div class="container">
	<table class="table table-dark" >
		<tr>
			<th>제목</th>
			<th width="200px">날짜</th>
		</tr>
		
	<c:choose>
	<c:when test="${list eq '[]'}"><tr><td colspan="2" style="color: red; text-align: center;">검색결과가없습니다</td></tr></c:when>		
<c:otherwise>
		<c:forEach var="row" items="${list}" varStatus="status">
			<tr>
				<td id="oclick${status.count }" class="cursor_test">${row.NOTICE_SUBJECT }</td>			
				<td>${row.NOTICE_DATE }</td>
			</tr>
			<tr>
			<td style="border-bottom: none;" colspan="2">
			<div id="divresult${status.count }" style="display: none; text-align: left;">${fn:replace(row.NOTICE_CONTENT,cn,br) } </div></td>
			</tr>
			
		</c:forEach>
		</c:otherwise>
		</c:choose>
		</table>
	<div class="center-block">
		<div class="row">	 
			<div class="col">			
	<ul class="pagination">
	<c:if test="${current_page>1 }">
	<li class="page-item" ><a class="page-link" href="#" onclick="gongSearch('1')">First</a></c:if>
	<c:if test="${current_block>1 }">
	<li class="page-item"><a class="page-link" href="#2" href="#2" onclick="gongSearch('${prev_page}')">Previous</a></li>
	</c:if>
	<c:forEach var="page" begin="${block_start }" end="${block_end }">
	<!-- 현재페이지 하이퍼링크 제거 -->
	<c:if test="${page==current_page }">
	<li class="page-item"><a class="page-link" href="#2" style="color: #27AE60;">${page}</a></li>
	</c:if>
	<!-- 현재페이지가 아니면 하이퍼링크 표시 -->
	<c:if test="${page!=current_page }">
	<li class="page-item"><a class="page-link" href="#1"
							onclick="gongSearch('${page}')">${page}</a></li>
	</c:if>
	</c:forEach>
	<c:if test="${current_block<total_block }">
	<li class="page-item"><a class="page-link" href="#4"
						onclick="gongSearch('${next_page}')">Next</a></li>
	</c:if>
	<c:if test="${current_page<total_page }">
	<li class="page-item"><a class="page-link" href="#5"
						onclick="gongSearch('${total_page}')">Last</a></li>
	</c:if>
	
	</ul>
	</div>
	</div>
	</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>