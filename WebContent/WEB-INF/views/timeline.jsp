<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
  <%@page import="java.util.ArrayList"%>
<%@page import="vo.ReactVO"%>
<%@page import="java.util.List"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Image"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Welcome! ${sessionScope.loginId}</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="assets/css/bootstrap.css" rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="assets/css/sefo.css" rel="stylesheet">
<link href="assets/css/timeline.css" rel="stylesheet">
<script src="https://use.fontawesome.com/804ea8b780.js"></script>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
<script type="text/javascript" src="assets/js/jquery.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/facebook.js"></script>
<style type="text/css">
.item img {
	vertical-align: middle;
}
.item {
	text-align: center;
	margin: 1em 0;
}

</style>
<script>
	var uploadPhotoCount = 0;
	var photoNum = 0;
	$(function() {
		$(document).on('keydown', '.comment-write-area', function(e) {
			var article_num = $(this).attr("name");
			var content = $(this).val()
			if (e.which == 13 && content.length > 0) {
				$.ajax({
					type : 'post', // 요청 보내면 doPost가 실행됨
					url : 'writeComment.do', // 우리가 작성한 java 서블릿에게
					data : {
						'article_num' : article_num,
						'content' : content
					}, // 검색어 데이터
					dataType : 'json', // 응답데이터 형식
					success : function(resultData) {
						alert("댓글 작성 성공!");
						var id = resultData.id;
						var photo_path = resultData.photo_path;
						var write_time = resultData.write_time;
						var comment_num = resultData.comment_num;
						$('#comment-area-'+article_num).append('<tr id="new-comment" style="margin-bottom: 5px;">'
							+ '	<td width="45px">'
							+ ' 	<a href="<%=request.getContextPath()%>/profile.do/'+id+'">'
							+ '			<img class="comment-img"'
							+ '			src="<%=request.getContextPath()%>/'+photo_path+'">'
							+ '		</a>' 
							+ '</td>'
							+ '<td>'
							+ '	<a href="<%=request.getContextPath()%>/profile.do/'+id+'"><b>'+id
							+ '	</b></a> &nbsp;'+content
							+ '      <input id="comment-delete" type="hidden"'
							+ '  		name="comment_num" value="'+comment_num+'">'
							+ '		<a onclick="deleteComment('+comment_num+')"'
							+ '			style="color: #CCC; font-size: 5px;">X</a>'
							+ '<div style="font-size: 5px; color:grey;">'+write_time+'</div>'
							+ '</td>'
							+ '</tr>'
						);
						$('.comment-write-area').val("");
					},
					error : function() {
						alert('댓글 ajax 요청 실패');
					}
				})
			}
		})
		// timeline item (image container)
		$(".item").width("100%");
		$(".item").height($(".item").width());
		// image
		$(".item img").each(function() {
			// 			$(this).load(function(){
			var width = this.naturalWidth;
			var height = this.naturalHeight;
			var parentHeight = $(this).parent().height();
			var parentWidth = $(this).parent().width()
			if (width < height) {
				var w = width * (parentHeight / height);
				$(this).css({
					width : w,
					height : parentHeight
				})
			} else {
				var h = height * (parentWidth / width);
				$(this).css({
					width : parentWidth,
					height : h
				})
			}
			// 				if(width < height){
			// 					$(this).width("auto");
			// 					$(this).height($(this).parent().height());
			// 				}else{
			// 					$(this).width($(this).parent().width());
			// 					$(this).height("auto");					
			// 				}
			// 				$(this).width('auto');
			// 				$(this).height('auto');
			console.log('original size:' + width + "/" + height)
			console.log('src:' + $(this).attr('src'))
			console.log("부모 사이즈: " + $(this).parent().width() + ", " + $(this).parent().height());
			console.log("이미지 사이즈: " + $(this).width() + ", " + $(this).height());
			var diffWidth = $(this).parent().width() - $(this).width();
			var diffHeight = $(this).parent().height() - $(this).height();
			console.log("diffWidth: " + diffWidth + ", diffHeight: " + diffHeight);
			$(this).attr('style', 'vertical-align:middle');
			$(this).parent().attr('style', 'text-align:center')
			$(this).css('margin', '30px 10px');
		// 			})
		})
		//
		// if window size changes...
		$(window).on('resize', function() {
			$(".item").width("100%");
			$(".item").height($(".item").width());
			// image
			$(".item img").each(function() {
				var diffWidth = $(this).parent().width() - $(this).width();
				var diffHeight = $(this).parent().height() - $(this).height();
				$(this).css('margin-top', (diffHeight / 2) + 'px ');
				$(this).css('margin-left', (diffWidth / 2) + 'px');
			})
		})
		$(document).on('change', "#fileList", function() {
			readURL(this);
		});
		$(document).on('keyup', '#modalContent', function() {
			var modalContent = $('#modalContent').val();
			$('#content').val(modalContent);
			$("#content").val();
		});
		$(document).on('click', '#postBtn', function(e) {
			//폼객체를 불러와서
			var form = $('#write_form')[0];
// 			var form = jQuery('#write_form')
// 			form = form.serialize();
			//FormData parameter에 담아줌
// 			alert(form.serialize());
			var formData = new FormData(form);
			$('#content').val("");
			$('#modalContent').val("");
			$('#file-container').empty();
			
// 			for (var pair of formData.entries()) {
// 			    console.log(pair[0]+ ', ' + pair[1]); 
// 			}
			
			var newForm = new FormData();
			for(var pair of formData.entries()) {
				if (pair[0] == 'content'){
				   	newForm.append(pair[0],encodeURIComponent(pair[1]));
				}else{
					newForm.append(pair[0],pair[1],encodeURIComponent(pair[1].name));
				}
			}
			for (var pair of newForm.entries()) {
			    console.log(pair[0]+ ', ' + pair[1]); 
			}
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				url : 'writePost.do', // 우리가 작성한 java 서블릿에게
				processData : false,
				cache : false,
				contentType : false,
				data : newForm,
				dataType : 'json', // 응답데이터 형식
				success : function(resultData) {
					var photoCount = resultData.photo_count;
					var photoList = resultData.photoList;
					var content = resultData.content;
					var photoPath = resultData.photo_path;
					var article_num = resultData.article_num;
					var write_time = resultData.write_time;
					var article_id = resultData.id;
					// alert('글쓰기 완료');
					var newPost = '<div class="panel panel-default"><div class="panel-thumbnail"></div>'
						+ '<div class="panel-body">'
						+ '<p class="lead">'
						+ '<a href="<%=request.getContextPath()%>/profile.do/'+article_id+'">'
						+ '<!--  profile -->'
						+ '<img class="profile"'
						+ ' src="<%=request.getContextPath()%>/'+photoPath+'"'
						+ '				height="40px" width="40px"> <span>${sessionScope.loginId}</span>'
						+ '			<!--  -->'
						+ '	</a>';
						+ '</p>'
					if (photoCount != 0) {
						newPost += '<img src="' + photoList[0].file_origiName + '" class="img-responsive">';
					}
					newPost += '<p>'
						+ '<p style="word-break:break-all;">'
						+ content
						+ '</p>'
						+ '<div style="width:100%; text-align: right;">'
						+ '<a class="write-time">'+write_time+'</a>'
						+ '</div>'
						+ '<br>'
						+ '</p>'
						+ '	<p>'
						+ '		<button type="button" class="btn btn-default btn-sm">'
						+ '			<i class="glyphicon glyphicon-thumbs-up"></i>'
						+ '		</button>'
						+ '		<!-- List of people who liked if more than 3, show number  otherwise id -->'
						+ '		<!-- EO liked list -->'
						+ '	</p>'
						+ '<table id="comment-area-'+article_num+'" class="comment-area" width="100%">'
						+ '	<p>'
						+ '</table>'
						+ '<hr>'
						+ '		<span> <input type="hidden" class="article-num"'
						+ '			value="'+article_num+'"> <textarea'
						+ '			class="comment-write-area" placeholder="댓글달기..."'
						+ '			name="'+article_num+'"></textarea>'
						+ '		</span>'
						+ '		<!--  EO Comment -->'
						+ '	</p>'
						+ '</div>'
						+ '</div>';
					$("#timeline").after(newPost);
				},
				error : function() {
					alert('ajax 요청 실패');
				}
			})
		})
		// 		$(document).on('hover', '.react-button', function()){
		// 			$(this).after('<button>좋아요</button><button>화나요</button><button>슬퍼요</button>');
		// 		}
		// 		$(document).on('mouseout', '.react-button', function()){
		// 			$(this).after("");
		// 		}
		$('#srch-term').on('keyup', function() {
			var searchWord = $(this).val();
			console.log(searchWord);
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				url : 'search.do', // 우리가 작성한 java 서블릿에게
				data : {
					'searchWord' : searchWord // 검색어 데이터	
				},
				dataType : 'json', // 응답데이터 형식
				success : function(resultData) {
					console.log(resultData);
					$('.search-option').remove();
					var bookData = '';
					for (var i = 0; i < resultData.length; i++) {
						bookData += '<option class="search-option" value="' + resultData[i] + '">';
					}
					// 					$.each(resultData, function(index, item) {
					// 						bookData += '<option class="search-option" value="'+item+'">';
					console.log(bookData);
					$('#search-data-list').append(bookData);
				},
				error : function() {
					console.log('검색 ajax 요청 실패');
				}
			})
		})
	})
	function deleteComment(comment_num) {
		if (confirm("댓글을 삭제하시겠습니까?")) {
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				url : 'deleteComment.do', // 우리가 작성한 java 서블릿에게
				data : {
					'comment_num' : comment_num
				}, // 검색어 데이터
				dataType : 'text', // 응답데이터 형식
				success : function(resultData) {
					alert("삭제 성공!");
					$('#comment-' + comment_num).remove();
				},
				error : function() {
					alert('ajax 요청 실패');
				}
			})
		}
	}
	function deleteNewComment(id, content) {
		if (confirm("댓글을 삭제하시겠습니까?")) {
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				url : 'deleteNewComment.do', // 우리가 작성한 java 서블릿에게
				data : {
					'id' : id,
					'content' : content
				}, // 검색어 데이터
				dataType : 'text', // 응답데이터 형식
				success : function(resultData) {
					alert("삭제 성공!");
					$('#new-comment').remove();
				},
				error : function() {
					alert('ajax 요청 실패');
				}
			})
		}
	}
	function makeFileContainer(uploadPhotoCount) {
		addMorePhoto(uploadPhotoCount);
	}
	function addMorePhoto(uploadPhotoCount) {
		console.log('uploadPhotoCount:' + uploadPhotoCount);
		++photoNum;
		++uploadPhotoCount;
		$('#file-container').append('<span id="upload-btn-' + uploadPhotoCount + '"class="upload-btn-wrapper" style="width:10%"><a href="#"><input type="file" name="fileList" id="fileList" class="upload-btn" style="width:80%; height:50px"/><img src="assets/img/addPhotoButtonImage.png" style="width:80%; height:50px;" alt="업로드할 파일 선택"></a><a href="#" style="color:red;" onclick="removePhoto(' + uploadPhotoCount + ')" style="width:20%">X</a><span>');
	}
	function removePhoto(uploadNum) {
		console.log('선택 번호:' + uploadNum);
		$("#upload-btn-" + uploadNum).remove();
		--photoNum;
		console.log('남은 사진 갯수:' + photoNum);
	}
	function readURL(changeInput) {
		// 	console.log(id);
		if (changeInput.files && changeInput.files[0]) {
			var reader = new FileReader();
			reader.readAsDataURL(changeInput.files[0]);
			reader.onload = function(e) {
				//     	console.log(e.target.result);
				//     	alert($(changeInput).siblings('img').attr('src'));
				$(changeInput).siblings('img').attr('src', reader.result);
			}
			addMorePhoto(++uploadPhotoCount);
		}
	}
	
function removeArticle(article_num) {
	if (confirm("게시글을 삭제 하시겠습니까?")) {
		alert(article_num);
		$.ajax({
			type : 'post', // 요청 보내면 doPost가 실행됨
			url : 'remove-article.do', // 우리가 작성한 java 서블릿에게
			data : {
				'article_num' : article_num
			}, // 검색어 데이터
			dataType : 'text', // 응답데이터 형식
			success : function(resultData) {
				if(resultData) {		
					$('#article-'+article_num).remove();
				}
				else {
					alert("삭제 실패!");
				}
			},
			error : function() {
				alert('ajax 요청 실패');
			}
		})
	}
}
	
	function reactListener(id, article_num, expression) {
		alert(id + " " + article_num + " " + expression);
		$.ajax({
			type : 'post', // 요청 보내면 doPost가 실행됨
			url : 'react.do', // 우리가 작성한 java 서블릿에게
			data : {
				'article_num' : article_num,
				'id' : id,
				'expression' : expression
			}, // 검색어 데이터
			dataType : 'text', // 응답데이터 형식
			success : function(resultData) {
				alert("리액션 달기 설공!");
// 				var a = '<c:if test="${not empty articleVO.reactList}">'
// 					+ '<ul style="display: inline-block;">'
// 					+ '<c:if test="${articleVO.react_like == true}" >'
// 					+ '<li style="display: inline-block;">'
// 					+ '<img src="assets\img\icon\like.gif" width="40px" height="40px">'
// 					+ '</li>'	
// 					+ '</c:if>'
// 					+ '<c:if test="${articleVO.react_love == true}" >'	
// 					+ '<li style="display: inline-block;" >'
// 					+ '<img'
// 					+ 'src="assets\img\icon\love.gif" width="40px"'	
// 					+ 'height="40px">'		
							
							
							
// 						</li>
// 					</c:if>
// 					<c:if test="${articleVO.react_angly == true}" >
// 						<li style="display: inline-block;">
// 							<img 
// 							src="assets\img\icon\angry.gif" width="40px"  height="40px">
							
// 						</li>
// 					</c:if>
// 					<c:if test="${articleVO.react_sad == true}" >
// 						<li style="display: inline-block;">
// 							<img
// 							src="assets\img\icon\sad.gif" width="40px"
// 							height="40px">
							
// 						</li>
// 					</c:if>
// 					</ul>
// 					${articleVO.react_count}명
// 			</c:if>
// 		</span>
		<!-- EO liked list -->'
				$('#like-indicator-' + article_num).append("+");
			},
			error : function() {
				$.ajax({
					type : 'post', // 요청 보내면 doPost가 실행됨
					url : 'reactUpdate.do', // 우리가 작성한 java 서블릿에게
					data : {
						'article_num' : article_num,
						'id' : id,
						'expression' : expression
					}, // 검색어 데이터
					dataType : 'text', // 응답데이터 형식
					success : function(resultData) {
						alert("리액션 달기 설공!");
						$('#like-indicator-' + article_num).append("+");
					},
					error : function() {
						alert('React ajax 요청 실패');
					}
				})
			}
		})
	}
</script>
<style>
.react-button:hover {
	background-color: yellow;
}
.dropdown {
	position: relative;
	/** Make it fit tightly around it's children */
	display: inline-block;
}
.dropdown .dropdown-menu {
	position: absolute;
	/**
     * Set the top of the dropdown menu to be positioned 100%
     * from the top of the container, and aligned to the left.
     */
	top: 100%;
	left: 0;
	/** Allow no empty space between this and .dropdown */
	margin: 0;
}
.dropdown:hover .dropdown-menu {
	display: block;
}
.dropdown-menu>li {
	display: inline;
}
.dropdown-menu>*:hover {
	background-color: yellow;
}
</style>
</head>
<body>
	<c:if test="${empty sessionScope.loginId}">
		<%
			response.sendRedirect(request.getContextPath() + "/loginPageMove.do");
		%>
	</c:if>
	<c:if test="${not empty sessionScope.loginId}">
		<div class="wrapper">
			<div class="box">
				<div class="row row-offcanvas">

					<!-- sidebar -->
					<%-- 					<jsp:include page="${request.getContextPath()}/sidebar.jsp" /> --%>
					<!-- /sidebar -->

					<!-- main right col -->
					<div class="column col-sm-12" id="main">

						<!-- top nav -->
						<jsp:include page="${request.getContextPath()}/topNav.jsp" />
						<!-- /top nav -->

						<div class="padding timeline-main">
							<div>

								<!-- content -->
								<div class="row">

									<!-- main col left -->
									<div class="timeline-container">
										<!-- 									<div class="col-sm-7 article-list"> -->

										<div id="timeline" class="well" data-target="#modal"
											data-toggle="modal">
											<!-- 											<form class="form-horizontal" role="form" enctype="multipart/form-data"  -->
											<!-- 												action="writePost.do" method="post" id="write_form" name ="write_form"> -->
											<h4>What's New</h4>
											<div class="form-group" style="padding: 14px;">
												<textarea class="form-control" id="content" name="content"
													placeholder="Update your status"></textarea>
											</div>
											<input class="btn btn-primary pull-right" id="postBtn"
												type="submit" value="POST">
											<ul class="list-inline">
												<li><a href="#" class="glyphicon glyphicon-picture"></a></li>
												<li><a href="#" class="fa fa-camera"></a></li>
												<!-- <li><a href=""><i -->
												<!-- class="glyphicon glyphicon-map-marker"></i></a></li> -->
											</ul>
											<!-- 											</form> -->
										</div>

										<!-- Start For Loop  -->
										<c:if test="${not empty articleList}">
											<c:forEach items="${articleList}" var="articleVO" begin="0"
												end="${articleList.size()-1}" step="1" varStatus="i">
												<div id="article-${articleVO.article_num}"class="panel panel-default">
													<div class="panel-thumbnail"></div>
													<div class="panel-body">
														<p class="lead">
															<a
																href="<%=request.getContextPath()%>/profile.do/${articleVO.id}">
																<!--  profile --> <img class="profile"
																src="<%=request.getContextPath() %>/${articleVO.photo_path}"
																height="40px" width="40px"> <span>${articleVO.id}</span>
																<!--  -->
															</a> <i class="glyphicon glyphicon-menu-down"></i>
															<c:if test="${sessionScope.loginId eq articleVO.id}" >
																<a style="float: right;" onclick="removeArticle(${articleVO.article_num})">
																<i class="glyphicon glyphicon-remove-circle"></i>
																</a> 
															</c:if>
														</p>
														<!--  if photo exists -->
														<c:if test="${not empty articleVO.photoList}">
															<div id="myCarousel-${i.count}"
																class="carousel
															data-ride="carousel">
																<!-- Indicators -->
																<ol class="carousel-indicators">
																	<li data-target="#myCarousel-${i.count}"
																		data-slide-to="0" class="active"></li>
																	<c:forEach items="${articleVO.photoList}" var="photo"
																		begin="1" end="${articleVO.photoList.size()-1}"
																		step="1" varStatus="j">
																		<li data-target="#myCarousel-${i.count}"
																			data-slide-to="${j.count}"></li>
																	</c:forEach>
																</ol>
																<!-- Wrapper for slides -->
																<div class="carousel-inner">
																	<div class="item active">
																		<img
																			src="${articleVO.photoList.get(0).file_origiName }">
																	</div>
																	<c:forEach items="${articleVO.photoList}" var="photo"
																		begin="1" end="${articleVO.photoList.size()-1}"
																		step="1" varStatus="j">
																		<div class="item"
																			style="overflow: hidden; background-color: black;">
																			<img src="${photo.file_origiName}"
																				class="img-responsive">
																		</div>
																	</c:forEach>
																</div>
																<!-- Left and right controls -->
																<c:if test="${articleVO.photoList.size()>=2}">
																	<a class="left carousel-control"
																		href="#myCarousel-${i.count}" data-slide="prev"> <span
																		class="glyphicon glyphicon-chevron-left"></span> <span
																		class="sr-only">Previous</span>
																	</a>
																	<a class="right carousel-control"
																		href="#myCarousel-${i.count}" data-slide="next"> <span
																		class="glyphicon glyphicon-chevron-right"></span> <span
																		class="sr-only">Next</span>
																	</a>
																</c:if>
															</div>
														</c:if>
														<!--  EOF -->

														<!-- Content -->
														<p style="word-break: break-all;">${articleVO.content}</p>
														<div style="width:100%; text-align: right;">
															<a class="write-time">${articleVO.write_time}</a>
														</div>
														<!-- EO Content -->
														
														<br>
														
														<!-- React Start -->
														<div class="react-button dropdown btn btn-default btn-sm">
															<ul class="dropdown-menu">
																<li><img
																	onclick="reactListener('${sessionScope.loginId}', ${articleVO.article_num}, '1')"
																	src="assets\img\icon\like.gif" width="40px"
																	height="40px"></li>
																<li><img
																	onclick="reactListener('${sessionScope.loginId}', ${articleVO.article_num}, '2')"
																	src="assets\img\icon\love.gif" width="40px"
																	height="40px"></li>
																<li><img
																	onclick="reactListener('${sessionScope.loginId}', ${articleVO.article_num}, '3')"
																	src="assets\img\icon\angry.gif" width="40px"
																	height="40px"></li>
																<li><img
																	onclick="reactListener('${sessionScope.loginId}', ${articleVO.article_num}, '4')"
																	src="assets\img\icon\sad.gif" width="40px"
																	height="40px"></li>
															</ul>
															<i class="glyphicon glyphicon-thumbs-up"></i>
														</div>
														<!-- List of people who liked if more than 3, show number  otherwise id -->
														<span onclick="alert('test')">
																<c:if test="${not empty articleVO.reactList}">
																	<ul style="display: inline-block;">
																	<c:if test="${articleVO.react_like == true}" >
																		<li style="display: inline-block;">
																			<img
																			src="assets\img\icon\like.gif" width="40px"
																			height="40px">
																		</li>
																	</c:if>
																	<c:if test="${articleVO.react_love == true}" >
																		<li style="display: inline-block;" >
																			<img
																			src="assets\img\icon\love.gif" width="40px"
																			height="40px">
																			
																		</li>
																	</c:if>
																	<c:if test="${articleVO.react_angly == true}" >
																		<li style="display: inline-block;">
																			<img 
																			src="assets\img\icon\angry.gif" width="40px"  height="40px">
																			
																		</li>
																	</c:if>
																	<c:if test="${articleVO.react_sad == true}" >
																		<li style="display: inline-block;">
																			<img
																			src="assets\img\icon\sad.gif" width="40px"
																			height="40px">
																			
																		</li>
																	</c:if>
																	</ul>
																	${articleVO.react_count}명
															</c:if>
														</span>
														<!-- EO liked list -->
														
														<!-- Comment Start -->
														<table id="comment-area-${articleVO.article_num}" class="comment-area" width="100%">
															<!-- Start Comment  -->
															<c:forEach var="commentVO" items="${articleVO.commentList}">
																<tr id="comment-${commentVO.comment_num}" style="margin-bottom: 5px;">
																	<td width="45px">
																		<a href="<%=request.getContextPath()%>/profile.do/${commentVO.id}">
																			<img class="comment-img"
																				src="<%=request.getContextPath()%>/${commentVO.photo_path}">
																		</a> 
																	</td>
																	<td>
																		<a href="<%=request.getContextPath()%>/profile.do/${commentVO.id}"><b>${commentVO.id}
																			</b></a> &nbsp;${commentVO.content}
																			<c:if test="${sessionScope.loginId==commentVO.id}">
																				<input id="comment-delete" type="hidden"
																					name="comment_num"
																					value="${commentVO.comment_num}">
																				<a onclick="deleteComment(${commentVO.comment_num})"
																					style="color: #CCC; font-size: 5px;">X</a>
																			</c:if>
																		<div style="font-size: 5px; color:grey;">${commentVO.write_time}</div>
																	</td>
																</tr>
															</c:forEach>
															<!--  EO Comment -->
														</table>
														
														<hr>
														<span> <input type="hidden" class="article-num"
															value="${articleVO.article_num}"> <textarea
																class="comment-write-area" placeholder="댓글달기..."
																name="${articleVO.article_num}"></textarea>
														</span>
													</div>
												</div>
											</c:forEach>
										</c:if>
<!-- 										!end of articleList c: if -->
									</div>
								</div>
								<hr>
								<jsp:include page="${request.getContextPath()}/footer.jsp" />
								<hr>
								<!--<hr> -->
							</div>
							<!-- /col-9 -->
						</div>
						<!-- /padding -->
					</div>
					<!-- /main -->

				</div>
			</div>
		</div>


		<!--post modal-->
		<div id="modal" class="modal fade media-center" tabindex="-1"
			role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						What's New
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
					</div>
					<form class="form center-block" role="form" action="writePost.do"
						method="post" enctype="multipart/form-data" id="write_form"
						name="write_form" accept-charset="utf-8">
						<div class="well modal-body">
							<!--<h4>Update your status</h4> -->
							<div class="form-group" style="padding: 14px;">
								<textarea class="form-control form-group input-lg"
									id="modalContent" name="content"
									placeholder="Update your status" data-target="#modal"
									data-toggle="modal" autofocus="true"></textarea>
							</div>
						</div>
						<div id="file-container" style="background-color: gray;"></div>
						<div class="modal-footer">
							<div>
								<input class="btn btn-primary pull-right btn-sm" id="postBtn"
									value="POST" aria-hidden="true" data-dismiss="modal">
								<ul class="pull-left list-inline">
									<li><a href="#" class="glyphicon glyphicon-picture"
										onclick="makeFileContainer(uploadPhotoCount++)"></a></li>
									<li><a href="#" class="fa fa-camera"></a></li>
								</ul>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- remove modal -->
	</c:if>
</body>
</html>