<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<!-- Bootstrap CSS CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- jQuery CDN -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!--    <script type="text/javascript"
      src="http://code.jquery.com/jquery-2.1.4.js"></script>-->
<!-- Bootstrap Js CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/MovieList.css">

<style>

#myBtn {
  display: none; /* Hidden by default */
  position: fixed; /* Fixed/sticky position */
  bottom: 20px; /* Place the button at the bottom of the page */
  right: 30px; /* Place the button 30px from the right */
  z-index: 99; /* Make sure it does not overlap */
  border: none; /* Remove borders */
  outline: none; /* Remove outline */
  background-color: red; /* Set a background color */
  color: white; /* Text color */
  cursor: pointer; /* Add a mouse pointer on hover */
  padding: 15px; /* Some padding */
  border-radius: 10px; /* Rounded corners */
  font-size: 18px; /* Increase font size */
}

#myBtn:hover {
  background-color: #555; /* Add a dark-grey background on hover */
}
</style>


<%
boolean open = Boolean.parseBoolean(request.getParameter("open"));
	String apikey = application.getInitParameter("APIKEY");
%>
<title>VOSHU</title>

</head>
<body>


<% if(!open) {%>
<jsp:include page="/Page/Navi/Navi.jsp" />
<%} else{ %>
<jsp:include page="/Page/Navi/Navi3.jsp" />
<%} %>




<div id="main">

		<span style="font-size: 30px; cursor: pointer; color: white;"
			onclick="openNav()">&#9776;</span>
			
		<div class="container all">
		
		<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
	
		<div class="movieList">
		</div>

		<div class="row">
		<div class="col-xs-6 col-centered text-center">
			<button class="more">더보기</button>
		</div>
		</div>
		
	</div>
	
	
	
	</div>
	
	
</body>

<script>


if(<%=open%>)
	document.getElementById("main").style.marginLeft = "250px";
		

	var page = 1;
	var more = ${more};
	var listsize = 0; //필터링으로 인한 영화 빈거 채우려고
	
	var list = new Array();

	<c:forEach items="${list}" var="item2">
	

	
	list.push({
		poster_path : "${item2.poster_path}",
		id : "${item2.id}",
		original_title : "${item2.original_title}",
		title : "${item2.title}",
		Star : "${item2.star}"
	});
	</c:forEach>
	
	printMore(more);				
	printMovie(list);
	
	
	
	function searchList(){
		
	page++;
	
	var link = "<%=request.getContextPath()%>/Search.ml?key=${key}&re=true&page="+page;
	
	console.log('이동할 페이지 :'+ page+","+link);

	$.ajax({
				url : link, //요청 전송 url
				dataType : 'json',
				cache : false,
				success : function(data) {
					
					var list = data.results;
					allpages = data.total_pages;
					console.log('list.length:'+list.length);
					printMore(data.more);				
					printMovie(list);
					

				}, //HTTP 요청이 성공한 경우 실행
				error : function(request, status, error) {
					console.log('목록 error');

				},
				complete : function() {
					console.log('목록완료');

				} 
			});
	
	
	
	}
	
	

	//api 결과가 20개가 아닌 경우 결과의 끝이라고 보고 더보기 숨김
	function printMore(size){
		
		if(!size)
			$('.more').css('visibility','hidden');
		else
			$('.more').css('visibility','visible');
	}
	
	
	function printMovie(list){
		
		var text = '';
		var check = 0;
		
	
		
		if(listsize == 0 || listsize % 4 == 0)
			outer :	for (var i = 0; i < 5; i++) {
			
		
			text += '<div class="row">';
			
			for(var j=0; j < 4; j++){
				
			if(check < list.length){
			
			
			text += '<div class="col-xs-3">';
		
			text += '<img class="img-responsive" src="https://image.tmdb.org/t/p/w500'+list[check].poster_path+'">';
			
			list[check].title = list[check].title.replace(/\"/gi, "");
			list[check].title = list[check].title.replace(/\'/gi, "");
			
			
			
			text += '<div class="centered" Onclick="window.open(\'moviedetail.ml?open=false&id='+list[check].id +'&title='+list[check].title+'&poster_path='+list[check].poster_path+'\',\'_blank\')">';
			text += '<h3 style="clear:right;" class="centeredText"><b>' + list[check].title + '</b></h3>\n';
			
			text += ' <div>';
			
			for(var k =0; k < list[check].Star; k++)
			text += '<span class="fa fa-star"></span>';
		
			text += ' </div>';
			text +='</div>\n';
			text += '<h5>' + list[check].title + '</h5>';
		
			text += '</div>';
			listsize ++;
			check++;
			}else{
				break outer;
			}
				
			}
			text += '</div>';
			
		}
		else{
			//listsize 가 4로 나누어 떨어지지 않았을 경우 빈 영화아이템이 있다는 뜻임
			//4 - (listsize % 4) 로 몇개의 공간이 비어있는지 체크
			var add = 4 - (listsize % 4);
		

			
			
			//빈 공간만큼 추가하기
			for (var j = 0; j < add; j++) {

				if (check < list.length) {
					
					text += '<div class="col-xs-3">';
					
					text += '<img class="img-responsive" src="https://image.tmdb.org/t/p/w500'+list[check].poster_path+'">';
					
					list[check].title = list[check].title.replace(/\"/gi, "");
					list[check].title = list[check].title.replace(/\'/gi, "");
					
					
					
					text += '<div class="centered" Onclick="window.open(\'moviedetail.ml?open=false&id='+list[check].id +'&title='+list[check].title+'&poster_path='+list[check].poster_path+'\',\'_blank\')">';
					text += '<h3 style="clear:right;" class="centeredText"><b>' + list[check].title + '</b></h3>\n';
		
					text += ' <div>';
					for(var k =0; k < list[check].Star; k++)
					text += '<span class="fa fa-star"></span>';
					
					text += ' </div>';
					text +='</div>\n';
					text += '<h5>' + list[check].title + '</h5>';
				
					text += '</div>';
					listsize ++;
					check++;
				}
				
			}
			
			if(page == 1)
				$('.movieList').html(text);
				else
					$('.movieList > .row:last').html($('.movieList > .row:last').html()+text);
				
			
			
			//채운만큼 리스트삭제하기
			 list.splice(0, check);
			
			//빈 공간이 채워졌으면 다시 printMovie이동
			printMovie(list);
			return; 
		}

		console.log('check : '+ check);
		
		if(page == 1)
		$('.movieList').html(text);
		else
		$('.movieList').html($('.movieList').html()+text);	
		
	}
	
	
	$('.more').click(function(){
		searchList();
	});
	
	
	mybutton = document.getElementById("myBtn");

	// When the user scrolls down 20px from the top of the document, show the button
	window.onscroll = function() {scrollFunction()};

	function scrollFunction() {
	  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	    mybutton.style.display = "block";
	  } else {
	    mybutton.style.display = "none";
	  }
	}

	// When the user clicks on the button, scroll to the top of the document
	function topFunction() {
	  document.body.scrollTop = 0; // For Safari
	  document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
	}
	
</script>
</html>