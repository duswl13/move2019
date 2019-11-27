<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<style>
 select {justify-content:center;}
 .center-block {display:flex;
                justify-content:center; /* 가운데 정렬 */}
 #id {text-align:center;}
 h1 {text-align:center; color:beige;}
</style>
<script>
 $(function(){
	 $("button").click(function(){
		 location.href="BoardWrite.bo";
	 })
 })
</script>
<script>
	$(document).on('click', '#btnSearch', function(e){
		e.preventDefault();

		var url = "${pageContext.request.contextPath}/board/board_list.jsp";
		url = url + "?searchType=" + $('#searchType').val();
		url = url + "&keyword=" + $('#keyword').val();

		location.href = url;
		console.log(url);
	});	
</script>
<title>영화 토론 게시판</title>
</head>
<body>
<h1>영화 토론 게시판</h1>
<div class="container">
<%-- 게시글이 있는 경우 --%>
 <c:if test="${listcount>0 }">
   <table class="table table-striped">
     <tr>
       <th colspan="3">목록</th>
       <th colspan="2">
          <font size=3>글 개수: ${listcount }</font>
       </th>
     </tr>
     <tr>
       <th width="8%"><div>번호</div></th> <!-- 글번호 아님 -->
       <th width="50%"><div>제목</div></th>
       <th width="14%"><div>글쓴이</div></th>
       <th width="17%"><div>날짜</div></th>
       <th width="11%"><div>조회수</div></th>
     </tr>
    <c:set var="num" value="${listcount-(page-1)*10 }"/>
    <c:forEach var="b" items="${boardlist }">
      <tr>
        <td>
        <c:out value="${num }"/> <%-- num 출력 --%>
        <c:set var="num" value="${num-1 }"/> <%--num=num-1 --%>
        </td>
        <td>
           <div>
             <%-- 답변글 제목 앞에 여백 처리 부분
                  BOARD_RE_LEV, BOARD_RE_LEV, BOARD_NUM,
                  BOARD_SUBJECT, BOARD_NAME, BOARD_DATE,
                  BOARD_READCOUNT : property 이름 --%>
             <c:if test="${b.BOARD_RE_LEV != 0 }"> <!-- 답글인 경우 -->
               <c:forEach var="a" begin="0"
                          end="${b.BOARD_RE_LEV*2 }" step="1">
               &nbsp;
               </c:forEach>
             </c:if>
             <c:if test="${b.BOARD_RE_LEV ==0 }"> <!-- 원문인 경우 -->
              &nbsp;
             </c:if>
             
             <a href="BoardDetailAction.bo?num=${b.BOARD_NUM }">
                ${b.BOARD_SUBJECT}
             </a>
           </div>
        </td>
        <td>
          <div>${b.BOARD_NAME }</div>
        </td>
        <td>
          <div>${b.BOARD_DATE }</div>
        </td>
        <td>
          <div>${b.BOARD_READCOUNT }</div>
        </td>
      </tr>
    </c:forEach>
   </table>
   
   <div class="center-block">
     <div class="row">
       <div class="col">
          <ul class="pagination">
          <c:if test="${page <= 1 }">
            <li class="page-item">
            <a class="page-link" href="#">이전&nbsp;</a>
            </li>
          </c:if>
          <c:if test="${page > 1 }">
            <li class="page-item">
            <a href="BoardList.bo?page=${page-1 }"
                class="page-link">이전</a>&nbsp;
            </li>
          </c:if>
          <c:forEach var="a" begin="${startpage }" end="${endpage }">
            <c:if test="${a == page }">
              <li class="page-item">
              <a class="page-link" href="#">${a }</a>
              </li>
            </c:if>
            <c:if test="${a != page }">
              <li class="page-item">
              <a href="BoardList.bo?page=${a }"
                 class="page-link">${a }</a>
              </li>
            </c:if>
          </c:forEach>
          <c:if test="${page >= maxpage }">
            <li class="page-item">
            <a class="page-link" href="#">&nbsp;다음</a>
            </li>
          </c:if>
          <c:if test="${page < maxpage }">
            <li class="page-item">
            <a href="BoardList.bo?page=${page+1 }"
                class="page-link">&nbsp;다음</a>
            </li>
          </c:if>
          </ul>
       </div>
     </div>
   </div>
 </c:if>
<c:if test="${listcount==0 }">
     <font id="f" size=5>등록된 글이 없습니다.</font>
 <br>
 <div class="center-block">
     <div class="row">
       <div class="col">
          <ul class="pagination">
          <c:if test="${page <= 1 }">
            <li class="page-item">
            <a class="page-link" href="#">이전&nbsp;</a>
            </li>
          </c:if>
          <c:if test="${page > 1 }">
            <li class="page-item">
            <a href="BoardList.bo?page=${page-1 }"
                class="page-link">이전</a>&nbsp;
            </li>
          </c:if>
          <c:forEach var="a" begin="${startpage }" end="${endpage }">
            <c:if test="${a == page }">
              <li class="page-item">
              <a class="page-link" href="#">${a }</a>
              </li>
            </c:if>
            <c:if test="${a != page }">
              <li class="page-item">
              <a href="BoardList.bo?page=${a }"
                 class="page-link">${a }</a>
              </li>
            </c:if>
          </c:forEach>
          <c:if test="${page >= maxpage }">
            <li class="page-item">
            <a class="page-link" href="#">&nbsp;다음</a>
            </li>
          </c:if>
          <c:if test="${page < maxpage }">
            <li class="page-item">
            <a href="BoardList.bo?page=${page+1 }"
                class="page-link">&nbsp;다음</a>
            </li>
          </c:if>
          </ul>
       </div>
     </div>
   </div>
 </c:if>
 <br>
 
 <button type="button"
         class="btn btn-info float-right">글쓰기</button>
<br>
 <select id="searchType">
 <option selected>제목</option>
 <option>내용</option>
 <option>글쓴이</option>
 </select>
 <input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
 <button type="button" id="btnSearch">검색</button>

</div>
</body>
</html>