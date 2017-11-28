<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
<!-- <meta charset="UTF-8"> -->
<title>Welcome! ${sessionScope.loginId}</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="assets/css/bootstrap.css" rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="assets/css/facebook.css" rel="stylesheet">
<script src="https://use.fontawesome.com/804ea8b780.js"></script>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
<style>
.profile {
	border-radius: 50px 50px 50px 50px;
	border-style: dotted;
	border-color: fuchsia;
	border-width: 3px;
}

.search-bar {
	margin-bottom: 0px;
	border-width: 0px;
}

.top-bar {
	height: 46px;
}

.status {
	
}

.profile-link {
	height: 43px;
}

ul {
	padding: 0px;
}

ul li {
	list-style-type: none;
}

.write-time {
	color: gray;
	font-size: 8px;
}

hr {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 0px;
	margin-right: 0px;
}

.comment-write-area {
	border-style: none;
	border-color: #FFF;
	width: 100%;
	height: 100%;
}

#comment-delete {
	color: #CCC;
	font-size: 5px;
}

.modal-body {
	margin: 0px;
}

.modal-footer {
	margin: 0px;
}

.form-group {
	margin: 0px;
}

.form-group>textarea {
	display: inline;
}

.upload-btn-wrapper {
	position: relative;
	overflow: hidden;
	display: inline-block;
}

.upload-btn {
	border: 2px solid gray;
	color: gray;
	background-color: white;
	padding: 0px;
	border-radius: 8px;
	font-weight: bold;
}

.upload-btn-wrapper input[type=file] {
	position: absolute;
	left: 0;
	top: 0;
	opacity: 0;
}
</style>
<script>
	var uploadPhotoCount = 0;
	var photoNum = 0;
	$(function() {

		$('.comment-write-area').on('keydown', function(e) {
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
					dataType : 'text', // 응답데이터 형식
					success : function(resultData) {
						alert("댓글 작성 성공!");
						$('.comment-area').append('<tr id="new-comment">'
							+ '<td><div style="margin-bottom: 5px;">'
							+ '		<img'
							+ '			src="assets/img/profile_pictures/${sessionScope.loginId}.JPG"'
							+ '			height="20px" width="20px"> <span><b>${sessionScope.loginId}</b>'
							+ content
							+ '	</div></td>'
							+ '	<td><input type="hidden" name="id"'
							+ '		value="${sessionScope.loginId}">'
							+ '      <input type="hidden" name="' + content + '">'
							+ '  <a id="comment-delete"'
							+ '		onclick="deleteNewComment(${sessionScope.loginId},' + content + ')">'
							+ 'X' + '</a></td>'
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

		$(document).on('change', "#imgInp", function() {
			readURL(this);
		});

		$(document).on('submit', '#postBtn', function(e) {
			$('#postBtn').attr('data-dismiss', 'modal');

			var content = $('#content').val();
			// 							alert(content)
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				url : 'writePost.do', // 우리가 작성한 java 서블릿에게
				data : {
					'content' : content
				}, // 검색어 데이터
				dataType : 'text', // 응답데이터 형식
				success : function(resultData) {
					// alert('글쓰기 완료');
					$(".well").after(
						'<div class="panel panel-default"><div class="panel-thumbnail"></div>'
						+ '<div class="panel-body">'
						+ '<a href="#">'
						+ '<p class="lead">'
						+ '<!--  profile -->'
						+ '<img class="profile"'
						+ ' src="assets/img/profile_pictures/${sessionScope.loginId}.JPG"'
						+ '				height="40px" width="40px"> <span>${sessionScope.loginId}</span>'
						+ '			<!--  -->'
						+ '		</p>'
						+ '	</a>'
						+ '	<!--  if photo exists -->'
						//		 					+ '	<img src="${articleVO.photo_path}" class="img-responsive">'
						+ '		<!-- -->'
						+ '	<p>'
						+ content
						+ '</p>'
						+ '	<p>'
						+ '		<button type="button" class="btn btn-default btn-sm">'
						+ '			<i class="glyphicon glyphicon-thumbs-up"></i>'
						+ '		</button>'
						+ '		<!-- List of people who liked if more than 3, show number  otherwise id -->'
						+ '		<label>아이디 리스트</label>'
						+ '		<!-- EO liked list -->'
						+ '	</p>'
						+ '	<p>'
						+ '	<table>'
						+ '		<!-- Start Comment  -->'
						+ '		<tr>'
						+ '			<td><img'
						+ '				src="assets/img/uFp_tsTJboUY7kue5XAsGAs28.png"'
						+ '				height="28px" width="28px"> <span>아이디</span></td>'
						+ '			<td>댓글 내용</td>'
						+ '		</tr>'
						+ '		<!--  EO Comment -->'
						+ '	</table>'
						+ '	</p>'
						+ '</div>'
						+ '</div>');
				},
				error : function() {
					alert('ajax 요청 실패');
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
		$('#file-container').append('<span id="upload-btn-' + uploadPhotoCount + '"class="upload-btn-wrapper" style="width:10%"><a href="#"><input type="file" name="fileList" id="imgInp" class="upload-btn" name="myfile" style="width:80%; height:50px"/><img src="assets/img/addPhotoButtonImage.png" style="width:80%; height:50px;" alt="업로드할 파일 선택"></a><a href="#" style="color:red;" onclick="removePhoto(' + uploadPhotoCount + ')" style="width:20%">X</a><span>');
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
</script>

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
				<div class="row row-offcanvas row-offcanvas-left">

					<!-- sidebar -->
					<div class="column col-sm-2 col-xs-1 sidebar-offcanvas"
						id="sidebar">

						<ul class="nav">
							<li><a href="#" data-toggle="offcanvas"
								class="visible-xs text-center"><i
									class="glyphicon glyphicon-chevron-right"></i></a></li>
						</ul>

						<ul class="nav hidden-xs" id="lg-menu">
							<li class="active"><a href="#featured"><i
									class="glyphicon glyphicon-list-alt"></i> Featured</a></li>
							<li><a href="#stories"><i
									class="glyphicon glyphicon-list"></i> Stories</a></li>
							<li><a href="#"><i class="glyphicon glyphicon-paperclip"></i>
									Saved</a></li>
							<li><a href="initMain.do"><i
									class="glyphicon glyphicon-refresh"></i> Refresh</a></li>
						</ul>
						<ul class="list-unstyled hidden-xs" id="sidebar-footer">
							<li><a href="http://usebootstrap.com/theme/facebook"><h3>Bootstrap</h3>
									<i class="glyphicon glyphicon-heart-empty"></i> Bootply</a></li>
						</ul>

						<!-- tiny only nav-->
						<ul class="nav visible-xs" id="xs-menu">
							<li><a href="#featured" class="text-center"><i
									class="glyphicon glyphicon-list-alt"></i></a></li>
							<li><a href="#stories" class="text-center"><i
									class="glyphicon glyphicon-list"></i></a></li>
							<li><a href="#" class="text-center"><i
									class="glyphicon glyphicon-paperclip"></i></a></li>
							<li><a href="initMain.do" class="text-center"><i
									class="glyphicon glyphicon-refresh"></i></a></li>
						</ul>

					</div>
					<!-- /sidebar -->

					<!-- main right col -->
					<div class="column col-sm-10 col-xs-11" id="main">

						<!-- top nav -->
						<div class="top-bar navbar navbar-blue navbar-static-top">
							<div class="navbar-header">
								<button class="navbar-toggle" type="button"
									data-toggle="collapse" data-target=".navbar-collapse">
									<span class="sr-only">Toggle</span> <span class="icon-bar"></span>
									<span class="icon-bar"></span> <span class="icon-bar"></span>
								</button>
								<a href="initMain.do" class="navbar-brand logo">b</a>
							</div>
							<nav class="collapse navbar-collapse" role="navigation">
							<form class="search-bar navbar-form navbar-left">
								<div class="input-group input-group-sm"
									style="max-width: 360px;">
									<input class="form-control" placeholder="Search"
										name="srch-term" id="srch-term" type="text">
									<div class="input-group-btn">
										<button class="btn btn-default" type="submit">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</div>
								</div>
							</form>
							<ul class="nav navbar-nav">
								<li><a class="profile-link" href="myProfile.do"><img
										class="status"
										src="assets/img/profile_pictures/${sessionScope.loginId}.JPG"
										width="20px" height="20px"> ${sessionScope.loginId}</a></li>
								<li><a href="#"><i class="glyphicon glyphicon-user"></i></a></li>
								<li><a href="#" role="button" data-toggle="modal"><i
										class="	glyphicon glyphicon-comment"></i></a></li>
								<li><a href="#"><span
										class="glyphicon glyphicon-heart-empty"></span></a></li>
							</ul>
							<ul class="nav navbar-nav navbar-right">
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown"><i class="glyphicon glyphicon-cog"></i></a>
									<ul class="dropdown-menu">
										<li><a id="logout" href="logout.do">Log Out</a></li>
										<li><a href="">More</a></li>
										<li><a href="">More</a></li>
										<li><a href="">More</a></li>
										<li><a href="">More</a></li>
									</ul></li>
							</ul>
							</nav>
						</div>
						<!-- /top nav -->

						<div class="padding">
							<div class="full col-sm-9">

								<!-- content -->
								<div class="row">

									<!-- main col left -->
									<div style="margin: auto; max-width: 800px">
										<!-- 									<div class="col-sm-7 article-list"> -->

										<div class="well" data-target="#modal" data-toggle="modal">
											<form class="form-horizontal" role="form"
												action="writePost.do" method="post">
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
											</form>
										</div>

										<!-- Start For Loop  -->
										<c:forEach items="${articleList}" var="articleVO">
											<div class="panel panel-default">
												<div class="panel-thumbnail"></div>
												<div class="panel-body">
													<p class="lead">
														<a href="#"> <!--  profile --> <img class="profile"
															src="assets/img/profile_pictures/${articleVO.id}.JPG"
															height="40px" width="40px"> <span>${articleVO.id}</span>
															<!--  -->
														</a>
													</p>
													<!--  if photo exists -->
													<%-- 													<img src="${articleVO.photo_path}" class="img-responsive"> --%>
													<!-- -->
													<p>${articleVO.content}</p>
													<p>
														<button type="button" class="btn btn-default btn-sm">
															<i class="glyphicon glyphicon-thumbs-up"></i>
														</button>
														<!-- List of people who liked if more than 3, show number  otherwise id -->
														<label>아이디 리스트</label>
														<!-- EO liked list -->
													</p>
													<table class="comment-area">
														<!-- Start Comment  -->
														<c:forEach var="commentVO"
															items="${articleVO.commentList}">
															<tr id="comment-${commentVO.comment_num}">
																<td><div style="margin-bottom: 5px;">
																		<img
																			src="assets/img/profile_pictures/${commentVO.id}.JPG"
																			height="20px" width="20px"> <span><b>${commentVO.id}</b>
																			${commentVO.content}</span>
																	</div></td>
																<c:if test="${sessionScope.loginId==commentVO.id}">
																	<td><input id="comment-delete" type="hidden"
																		name="comment_num" value="${commentVO.comment_num}">
																		<a onclick="deleteComment(${commentVO.comment_num})"
																		style="color: #CCC; font-size: 5px;">X</a></td>
																</c:if>
															</tr>
														</c:forEach>
														<!--  EO Comment -->
													</table>
													<a class="write-time">${articleVO.write_time}</a>
													<hr>
													<span> <input type="hidden" class="article-num"
														value="${articleVO.article_num}"> <textarea
															class="comment-write-area" placeholder="댓글달기..."
															name="${articleVO.article_num}"></textarea>
													</span>
												</div>
											</div>
										</c:forEach>
										<!-- End of For loop -->

										<!--<div class="panel panel-default"> -->
										<!--	<div class="panel-heading"><a href="#" class="pull-right">View all</a> <h4>Bootstrap Examples</h4></div> -->
										<!--	  <div class="panel-body"> -->
										<!--		<div class="list-group"> -->
										<!--		  <a href="http://usebootstrap.com/theme/facebook" class="list-group-item">Modal / Dialog</a> -->
										<!--		  <a href="http://usebootstrap.com/theme/facebook" class="list-group-item">Datetime Examples</a> -->
										<!--		  <a href="http://usebootstrap.com/theme/facebook" class="list-group-item">Data Grids</a> -->
										<!--		</div> -->
										<!--	  </div> -->
										<!--</div> -->


										<!--<div class="panel panel-default"> -->
										<!--	 <div class="panel-heading"><a href="#" class="pull-right">View all</a> <h4>More Templates</h4></div> -->
										<!--	  <div class="panel-body"> -->
										<!--		<img src="assets/img/150x150.gif" class="img-circle pull-right"> <a href="#">Free @Bootply</a> -->
										<!--		<div class="clearfix"></div> -->
										<!--		There a load of new free Bootstrap 3 -->
										<!-- 		 ready templates at Bootply. All of these templates are free and don't  -->
										<!-- 		require extensive customization to the Bootstrap baseline. -->
										<!--		<hr> -->
										<!--		<ul class="list-unstyled"><li><a href="http://usebootstrap.com/theme/facebook">Dashboard</a></li><li><a href="http://usebootstrap.com/theme/facebook">Darkside</a></li><li><a href="http://usebootstrap.com/theme/facebook">Greenfield</a></li></ul> -->
										<!--	  </div> -->
										<!--</div> -->

										<!--<div class="panel panel-default"> -->
										<!--	<div class="panel-heading"><h4>What Is Bootstrap?</h4></div> -->
										<!--	<div class="panel-body"> -->
										<!--		Bootstrap is front end frameworkto  -->
										<!-- 		build custom web applications that are fast, responsive &amp; intuitive. -->
										<!-- 		 It consist of CSS and HTML for typography, forms, buttons, tables,  -->
										<!-- 		grids, and navigation along with custom-built jQuery plug-ins and  -->
										<!-- 		support for responsive layouts. With dozens of reusable components for  -->
										<!-- 		navigation, pagination, labels, alerts etc..                          </div> -->
										<!--</div> -->



									</div>

									<!-- main col right -->
									<!--<div class="col-sm-3"> -->

									<!--	<div class="well">  -->
									<!--	   <form class="form"> -->
									<!--		<h4>Sign-up</h4> -->
									<!--		<div class="input-group text-center"> -->
									<!--		<input class="form-control input-lg" placeholder="Enter your email address" type="text"> -->
									<!--		  <span class="input-group-btn"><button class="btn btn-lg btn-primary" type="button">OK</button></span> -->
									<!--		</div> -->
									<!--	  </form> -->
									<!--	</div> -->

									<!-- <div class="panel panel-default"> -->
									<!--	 <div class="panel-heading"><a href="#" class="pull-right">View all</a> <h4>Bootply Editor &amp; Code Library</h4></div> -->
									<!--	  <div class="panel-body"> -->
									<!--		<p><img src="assets/img/150x150.gif" class="img-circle pull-right"> <a href="#">The Bootstrap Playground</a></p> -->
									<!--		<div class="clearfix"></div> -->
									<!--		<hr> -->
									<!--		Design, build, test, and prototype  -->
									<!-- 		using Bootstrap in real-time from your Web browser. Bootply combines the -->
									<!-- 		 power of hand-coded HTML, CSS and JavaScript with the benefits of  -->
									<!-- 		responsive design using Bootstrap. Find and showcase Bootstrap-ready  -->
									<!-- 		snippets in the 100% free Bootply.com code repository. -->
									<!--	  </div> -->
									<!-- </div> -->

									<!-- <div class="panel panel-default"> -->
									<!--	 <div class="panel-heading"><a href="#" class="pull-right">View all</a> <h4>Stackoverflow</h4></div> -->
									<!--	  <div class="panel-body"> -->
									<!--		<img src="assets/img/150x150.gif" class="img-circle pull-right"> <a href="#">Keyword: Bootstrap</a> -->
									<!--		<div class="clearfix"></div> -->
									<!--		<hr> -->

									<!--		<p>If you're looking for help with Bootstrap code, the <code>twitter-bootstrap</code> tag at <a href="http://stackoverflow.com/questions/tagged/twitter-bootstrap">Stackoverflow</a> is a good place to find answers.</p> -->

									<!--		<hr> -->
									<!--		<form> -->
									<!--		<div class="input-group"> -->
									<!--		  <div class="input-group-btn"> -->
									<!--		  <button class="btn btn-default">+1</button><button class="btn btn-default"><i class="glyphicon glyphicon-share"></i></button> -->
									<!--		  </div> -->
									<!--		  <input class="form-control" placeholder="Add a comment.." type="text"> -->
									<!--		</div> -->
									<!--		</form> -->

									<!--	  </div> -->
									<!-- </div> -->

									<!-- <div class="panel panel-default"> -->
									<!--	 <div class="panel-heading"><a href="#" class="pull-right">View all</a> <h4>Portlet Heading</h4></div> -->
									<!--	  <div class="panel-body"> -->
									<!--		<ul class="list-group"> -->
									<!--		<li class="list-group-item">Modals</li> -->
									<!--		<li class="list-group-item">Sliders / Carousel</li> -->
									<!--		<li class="list-group-item">Thumbnails</li> -->
									<!--		</ul> -->
									<!--	  </div> -->
									<!-- </div> -->

									<!-- <div class="panel panel-default"> -->
									<!--	<div class="panel-thumbnail"><img src="assets/img/bg_4.jpg" class="img-responsive"></div> -->
									<!--	<div class="panel-body"> -->
									<!--	  <p class="lead">Social Good</p> -->
									<!--	  <p>1,200 Followers, 83 Posts</p> -->

									<!--	  <p> -->
									<!--		<img src="assets/img/photo.jpg" height="28px" width="28px"> -->
									<!--		<img src="assets/img/photo.png" height="28px" width="28px"> -->
									<!--		<img src="assets/img/photo_002.jpg" height="28px" width="28px"> -->
									<!--	  </p> -->
									<!--	</div> -->
									<!--</div> -->

									<!--</div> -->
								</div>
								<!--/row-->

								<!--<div class="row"> -->
								<!--	<div class="col-sm-6"> -->
								<!--<a href="#">Twitter</a> <small class="text-muted">|</small> <a -->
								<!--	href="#">Facebook</a> <small class="text-muted">|</small> <a -->
								<!--	href="#">Google+</a> -->
								<!--	</div> -->
								<!--</div> -->
								<hr>
								<div class="row" id="footer footer-column">
									<div>
										<div class="col-sm-3">
											<ul>
												<li><a href="#">SeFo정보</a></li>
												<li><a href="#">지원</a></li>
											</ul>
										</div>
										<div class="col-sm-3">
											<ul>
												<li><a href="#">블로그</a></li>
												<li><a href="#">홍보 센터</a></li>
												<li><a href="#">채용 정보</a></li>
											</ul>
										</div>
										<div class="col-sm-3">
											<ul>
												<li><a href="#">개인정보처리방침</a></li>
												<li><a href="#">약관</a></li>
												<li><a href="#">디렉터리</a></li>
												<li><a href="#">언어</a></li>
											</ul>
										</div>
									</div>
									<div class="col-sm-3">
										<p>
											<a href="#" class="pull-right">© 2017 SeFo</a>
										</p>
									</div>
								</div>
								<hr>
								<!--<hr> -->

								<!--<h4 class="text-center"> -->
								<!--	<a href="http://usebootstrap.com/theme/facebook" target="ext">Download -->
								<!--this Template @Bootply</a> -->
								<!--</h4> -->

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
						<!-- 						<button type="button" class="close" data-dismiss="modal" -->
						<!-- 							aria-hidden="true">&times;</button> -->
					</div>
					<form class="form center-block" role="form" action="writePost.do"
						method="post" enctype="multipart/form-data">
						<div class="well modal-body">
							<!--<h4>Update your status</h4> -->
							<div class="form-group" style="padding: 14px;">
								<textarea class="form-control form-group input-lg" id="content"
									name="content" placeholder="Update your status"
									data-target="#modal" data-toggle="modal" autofocus="true"></textarea>
							</div>
						</div>
						<div id="file-container" style="background-color: gray;"></div>
						<div class="modal-footer">
							<div>
								<input class="btn btn-primary pull-right btn-sm" id="postBtn"
									type="submit" value="POST" aria-hidden="true">
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

		<script type="text/javascript" src="assets/js/jquery.js"></script>
		<script type="text/javascript" src="assets/js/bootstrap.js"></script>
		<script type="text/javascript">
			$(document)
				.ready(
					function() {
						$('[data-toggle=offcanvas]')
							.click(
								function() {
									$(this)
										.toggleClass(
											'visible-xs text-center');
									$(this)
										.find('i')
										.toggleClass(
											'glyphicon-chevron-right glyphicon-chevron-left');
									$('.row-offcanvas')
										.toggleClass(
											'active');
									$('#lg-menu')
										.toggleClass(
											'hidden-xs')
										.toggleClass(
											'visible-xs');
									$('#xs-menu')
										.toggleClass(
											'visible-xs')
										.toggleClass(
											'hidden-xs');
									$('#btnShow').toggle();
								});
					});
		</script>
	</c:if>
</body>
</html>