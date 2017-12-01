<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.Image"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
<meta charset="UTF-8">
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

		$(document).on('change', "#fileList", function() {
			readURL(this);
		});
		
		$(document).on('keyup', '#modalContent', function(){
			var modalContent = $('#modalContent').val();
			$('#content').val(modalContent);
			$("#content").val();
		});
		
		$(document).on('click', '#postBtn', function(e) {
			//폼객체를 불러와서
			var form = $('#write_form')[0];
			//FormData parameter에 담아줌
			var formData = new FormData(form);
			
			$('#content').val("");
			$('#modalContent').val("");
			$('#file-container').empty();
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				enctype: 'multipart/form-data',
				url : 'writePost.do', // 우리가 작성한 java 서블릿에게
				processData : false,
	            cache: false,
				contentType : false,
				data : formData,
				dataType : 'json', // 응답데이터 형식
				success : function(resultData) {
					var photoList = resultData.photoList;
// 					$.each(result, function(idx, value){
// 							consol.log(idx+" " +value.article_num)
// 					});
					
					// alert('글쓰기 완료');
					$("#timeline").after(
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
						+ '	<img src="'+ photoList[0].file_origiName+ '" class="img-responsive">'
						+ '		<!-- -->'
						+ '	<p>'
						+ '<p>'
						+ resultData.content
						+ '</p>'
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
		
		$('#srch-term').on('keyup', function(){
			var searchWord = $(this).val();
			console.log(searchWord);
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				url : 'search.do', // 우리가 작성한 java 서블릿에게
				data : {
					'searchWord' : searchWord, // 검색어 데이터	
				},
				dataType : 'json',// 응답데이터 형식
				success : function(resultData) {
					console.log(resultData);
					$('.search-option').remove();
					var bookData='';
					for(var i=0; i<resultData.length; i++){
						bookData += '<option class="search-option" value="' +resultData[i]+ '">';
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
										<c:forEach items="${articleList}" var="articleVO" begin="0"
											end="${articleList.size()-1}" step="1" varStatus="i">
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
																	<c:set var="fileContext" value="${photo.file_path}" />
																	<%
																		String fileContext = (String) pageContext.getAttribute("fileContext");
																						System.out.println(fileContext);
																						String height = "";
																						String width = "";
																						try {
																							File file = new File(fileContext);
																							BufferedImage bi = ImageIO.read(file);

																							if (bi.getWidth() < bi.getHeight()) {
																								height = "100%";
																								width = "auto";
																							} else {
																								width = "100%";
																								height = "auto";
																							}
																							System.out.println(bi.getWidth() + "," + bi.getHeight());
																						} catch (Exception e) {
																							System.out.println("이미지 파일이 아닙니다.");
																						}
																	%>
																	<c:set var="width" value="${pageScope.width}" />
																	<c:set var="height" value="${pageScope.height}" />
																		<div class="item" style="overflow: hidden; width:100%; height:auto; background-color:black;">
																		<img src="${photo.file_origiName}"
																			class="img-responsive"
																			style="width:${width}; height=${height}; margin-top:auto; margin-left:auto; margin-right:auto; margin-bottom:auto;">
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
								<jsp:include page="${request.getContextPath()}/footer.jsp" />
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
						<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
					</div>
					<form class="form center-block" role="form" action="writePost.do"
						method="post" enctype="multipart/form-data" id="write_form"
						name="write_form">
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
	</c:if>
</body>
</html>