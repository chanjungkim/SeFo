<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
<meta charset="EUC-KR">
<title>비밀의숲 - ${sessionScope.loginId}</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="shortcut icon"  href="<%=request.getContextPath()%>/favicon.ico" />
<link href="<%=request.getContextPath()%>/assets/css/bootstrap.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/assets/css/profile.css"
	rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="<%=request.getContextPath()%>/assets/css/sefo.css" rel="stylesheet">
<script src="https://use.fontawesome.com/804ea8b780.js"></script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
<script src="<%=request.getContextPath()%>/assets/js/gallery.js"></script>
<script type="text/javascript">

	$(function() {
		var article_last_index = $('#article_last_index').val();
		var id = '${memberVO.id}';
		var article_count = 12;
		$(window).scroll(function() {
			var maxHeight = $(document).height();
			currentScroll = $(window).scrollTop() + $(window).height();
			if ((maxHeight <= currentScroll) && article_count == 12) {
				//ajax 요청
				$.ajax({
					type : 'post', //요청 보내면 doPost가 실행됨
					url : '<%=request.getContextPath()%>/profileMoreArticle.do',
					data : {
						'id' : id,
						'articleNum' : article_last_index
					},
					dataType : 'json',
					success : function(resultData) {
						var loader = '<div id ="loader" class="col-md-3">';
						loader += '<div class="panel panel-default"  style="background-color:rgba(204,204,204,1);">';
						loader += '<div class="adjust">';
						loader += '<div class="loader2"></div>';
						loader += '</div>';
						loader += '</div>';
						loader += '</div>';

						var addImage = "";
						var article_count_sum = 0;
						$.each(resultData, function() {
							var myContext = "<%=request.getContextPath()%>";
							article_last_index = this.article_num;
							addImage += '<figure>'
							addImage += '<div><img id="article_img" name ="article_img" src="' + myContext + '/' + this.photoList[0].file_origiName + '"';
							addImage += 'style="z-index: 0;"><div class="photo-info" style="display: inline-block;">'
							addImage += '<img src="<%=request.getContextPath()%>/assets/img/icon/heart-profile.png"'
							addImage += 'style="width: 15px; height: 15px; display: inline-block;">';
							addImage += this.react_count+'개';
							addImage += '<img src="<%=request.getContextPath()%>/assets/img/icon/chat.png"';
							addImage += 'style="width: 15px; height: 15px; display: inline-block; margin-left: 10px">'+this.commentCount+'개';
							addImage += '</div></div></figure>';
							article_count_sum += 1;
						})
						article_count = article_count_sum;
						$("#gallery").append(
							addImage
						)
					},
					error : function() {
						alert('더보기 ajax 요청 실패');
					}
				})
			}
		})
		/***
		 * follow - unfollow start
		 */ 		
		 $(document).on('click', '#follower-btn2', function(){	
			 var memberId = $(this).val();
			 var btn = $(this);
			 $.ajax({
					type : 'POST',
					url : '<%=request.getContextPath()%>/follow.do',
					data : {
						'follow_id' : memberId
					},
					dataType : 'json',
					success : function (resultData){
						btn.attr('id', 'following-btn2');
						btn.text('팔로잉');
						btn.css("background-color","transparent");
						btn.css("color","black");
						btn.css("border-width","0.1px");
						btn.css("float", "right");
						btn.css("border", "groove");
					},
					error : function(){
						alert('팔로우 실패')
					}
				})
				return false;
		 });
		
		$(document).on('click', '#following-btn2', function(){	
			 var memberId = $(this).val();
			 var btn = $(this);
			 $.ajax({
					type : 'POST',
					url : '<%=request.getContextPath()%>/unfollow.do',
					data : {
						'follow_id' : memberId
					},
					dataType : 'json',
					success : function (resultData){
						btn.attr('id', 'follower-btn2');
						btn.text('팔로우');
						btn.css("background-color","#3897f0");
						btn.css("color","white");
						btn.css("border-width","0px");				
						btn.css("float","right");
						btn.css("border", "groove");
					},
					error : function(){
						alert('팔로우 실패')
					}
				})
				return false;
		});
		 $(document).on('click', '#follow-btn', function(){
				var memberId = '${memberVO.id}';
				$.ajax({
					type : 'POST',
					url : '<%=request.getContextPath()%>/follow.do',
					data : {
						'follow_id' : memberId
					},
					dataType : 'json',
					success : function (resultData){
						$('#follow-btn').attr('id', 'following-btn');
						$('#following-btn').text('팔로윙');
						$('#following-btn').css("float","left");
						$('#following-btn').css("background-color","transparent");
						$('#following-btn').css("color","black");
						$('#following-btn').css("border-width","0.5px");
						$('#follower-cnt').text(" "+resultData);						
					},
					error : function(){
						alert('팔로우 실패')
					}
				})
				return false;
			});
		
		$(document).on('click', '#following-btn', function(){
			var memberId = '${memberVO.id}';
			$.ajax({
				type : 'POST',
				url : '<%=request.getContextPath()%>/unfollow.do',
				data : {
					'follow_id' : memberId
				},
				dataType : 'json',
				success : function (resultData){

					$('#follower-cnt').text(" "+(resultData));
					$('#following-btn').attr('id', 'follow-btn');
					$('#follow-btn').text('팔로우');
					$('#follow-btn').css("float","left");
					$('#follow-btn').css("background-color","#3897f0");
					$('#follow-btn').css("color","white");
					$('#follow-btn').css("border-width","0px");
					
				},
				error : function(){
					alert('언팔 실패')
				}
			})
			return false;
		});
		/***
		 * follow - unfollow End
		 */ 
		$(document).on('mouseenter', "#article_img", function() {
			$(this).parent().attr('style', 'background-color:black;')
			$(this).attr('style', 'opacity: 0.6');
			$(this).siblings().attr('style', 'opacity: 1');
		});

		$(document).on('mouseleave', "#article_img", function() {
			$(this).parent().attr('style', 'background-color:none')
			$(this).attr('style', 'background-color: none; opacity:1');
			$(this).siblings().attr('style', 'opacity: 0');
		});
		$('#send').on('click',function(){
			var form = $('#write_form')[0];
			//FormData parameter에 담아줌
			var formData = new FormData(form);
			$('#content').val("");
			$('#modalContent').val("");
			$('#file-container').empty();
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				enctype : 'multipart/form-data',
				url : 'profilePhoto.do', // 우리가 작성한 java 서블릿에게
				processData : false,
				cache : false,
				contentType : false,
				data : formData,
				dataType : 'json', // 응답데이터 형식
				success : function(resultData) {
					alert("사진전송 성공")
					window.location.href="profile.do";
				},
				error : function() {
					alert('ajax 요청 실패');
				}
			})
		});
	});
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/js/bootstrap.js"></script>
<script type="text/javascript">
$(document).ready(function() {
			$('[data-toggle=offcanvas]').click(function() {
						$(this).toggleClass('visible-xs text-center');
						$(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
						$('.row-offcanvas').toggleClass('active');
						$('#lg-menu').toggleClass(	'hidden-xs')	.toggleClass('visible-xs');
						$('#xs-menu').toggleClass(	'visible-xs').toggleClass(	'hidden-xs');
						$('#btnShow').toggle();
					});
			$(document).on('change', ".file_input_hidden", function() {
				alert('실행됨!!');
				readURL(this);
				//폼객체를 불러와서
				var form = $('write_form')[0];
				//FormData parameter에 담아줌
				var formData = new FormData(form);
				$.ajax({
					type : 'post',
					url : '<%=request.getContextPath()%>/changeProfilePhoto.do',
					processData : false,
					cache : false,
					contentType : false,
					data : formData,
					enctype: "multipart/form-data",
					dataType : 'json',
					success : function(resultData) {
						alert("사진 변경 완료!");
					},
					error : function(resultData){
						alert("사진 변경 실패");
					}
				});
			});
})
function readURL(changeInput) {
	// 	console.log(id);
	if (changeInput.files && changeInput.files[0]) {
		var reader = new FileReader();
		reader.readAsDataURL(changeInput.files[0]);
		reader.onload = function(e) {
// 			    	console.log(e.target.result);
// 			    	alert($(changeInput).siblings('img').attr('src'));
			

			$(changeInput).siblings('img').attr('src', reader.result);
		}
	}
}

</script>
<style type="text/css">
figure {
	position: relative;
}

figure>div>.photo-info {
	position: absolute;
	color: white;
	opacity: 0;
	font-weight: bold;
	text-align: center;
	vertical-align: middle;
	top: 50%;
	left: 50%;
	font-size: 16px;
}
.modal {
  text-align: center;
  padding: 0!important;
}

.modal:before {
  content: '';
  display: inline-block;
  height: 100%;
  vertical-align: middle;
  margin-right: -4px;
}

.modal-dialog {
  display: inline-block;
  text-align: left;
  vertical-align: middle;
}

/* Remove margins and padding from the list */
#follower_ul {
  margin: 0;
  padding: 0;
}

/* Style the list items */
#follower_ul > li {
  position: relative;
  padding: 12px 8px 12px 40px;
  list-style-type: none;
  background: #fff;
  font-size: 18px;
  transition: 0.2s;
  
  /* make the list items unselectable */
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}
.thumbnail {
  position: relative;
  width: 200px;
  height: 200px;
  overflow: hidden;
}
.thumbnail img {
  position: absolute;
  left: 50%;
  top: 50%;
  height: 100%;
  width: auto;
  -webkit-transform: translate(-50%,-50%);
      -ms-transform: translate(-50%,-50%);
          transform: translate(-50%,-50%);
}
.thumbnail img.portrait {
  width: 100%;
  height: auto;
}
</style>
</head>
<body>											
	<c:if test="${empty articleList}">
		<input type="hidden" id="article_last_index" value="0">
	</c:if>
	<c:if test="${not empty articleList}">
		<input type="hidden" id="article_last_index"
			value="${articleList.get(articleList.size()-1).article_num}">
	</c:if>

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
					<%-- 					<jsp:include page="${request.getContextPath()}/sidebar.jsp" />  --%>
					<!-- /sidebar -->

					<!-- main right col -->
					<div class="column col-sm-12" id="main">

						<!-- top nav -->
						<jsp:include page="${request.getContextPath()}/topNav.jsp" />
						<!-- /top nav -->

						<div class="padding profile-main">
							<div class="row">
							<div class="profile-container">
									<!-- content -->
									<div class="well col-md-12">
										<div class="row">
											<div class="my_profile_img img-fluid col-md-4">
											<form  class="form center-block" role="form" action="<%=request.getContextPath()%>/changeProfilePhoto.do"
														method="post" enctype="multipart/form-data" id="write_form"
														name="write_form" accept-charset="utf-8" style="display:inline-block;">
												<div class="file_input_div">
												    <img src="<%=request.getContextPath()%>/${memberVO.photo_path}" class="file_input_img_btn" alt="open" />
												    <c:if test="${sessionScope.loginId == memberVO.id}">
												    	<input type="file" name="file" id="file" class="file_input_hidden"/>
													</c:if>
												</div>											
											</form>
												<!-- 	Modal content -->
<!-- 													<div class="modal-content"> -->
<!-- 														<div class="container"> -->
<!-- 															<div class="col-md-6"> -->
<!-- 															    <div class="form-group"> -->
<!-- 															        <label>Upload Image</label> -->
<!-- 															        <div class="input-group"> -->
<!-- 															            <span class="input-group-btn"> -->
<!-- 															                <span class="btn btn-default btn-file"> -->
<!-- 															                    Browse… <input type="file" id="imgInp"> -->
<!-- 															                </span> -->
<!-- 															            </span> -->
<!-- 															            <input type="text" class="form-control" readonly> -->
<!-- 															        </div> -->
<!-- 															        <img id='img-upload'/> -->
<!-- 															    </div> -->
<!-- 															</div> -->
<!-- 														</div> -->
<!-- 													</div> -->
										</div>
										<div class="col-md-8">
											<div class="row"
												style="display: flex; align-items: center; align-self: center; margin-top: 10px;">
												<div
													style="font-size: 30px; margin-right: 30px; float: left; font-family: 나눔고딕">${memberVO.id }</div>
												<!--  수정 : 성훈  -->
												<div class="row"
													style="float: left; display: flex; align-items: center;">
													<c:choose>
														<c:when test="${sessionScope.loginId == memberVO.id}">
															<button class="profile-edit" style="float: left;">
																<a href="<%=request.getContextPath()%>/myPage.do"
																	style="color: black; font-weight: lighter;"> <strong>프로필편집</strong>
																</a>
															</button>
															<a href="#"><img
																src="<%=request.getContextPath()%>/assets/img/profile_settiong.png"
																style="width: 30px; height: 30px; float: left; vertical-align: bottom;"></a>
														</c:when>
														<c:otherwise>
															<c:set var="b" value="0" />
															<c:forEach items="${memberVO.followerList }" var="i">
																<c:if test="${i.id == sessionScope.loginId}">
																	<c:set var="b" value="1" />
																</c:if>
															</c:forEach>

															<c:if test="${b==1}">
																<button class="profile-edit" id="following-btn"
																	style="float: left;">팔로잉</button>
															</c:if>
															<c:if test="${b==0}">
																<button class="profile-edit" id="follow-btn"
																	style="float: left; background-color: #3897f0; color: white; border: none">
																	팔로우</button>
															</c:if>
														</c:otherwise>
													</c:choose>
												</div>
												<!-- 												수정 : 성훈  -->
											</div>
											<div class="row" style="margin-top: 15px;">
												<span class="profile-span-margin-3px">게시물 </span> <strong><span
													class="profile-span-margin-10px" id="span_profile_article">${totalContentCnt}
												</span></strong>
												<button class="profile-span-margin-3px"
													id="span_profile_follower" data-toggle="modal" href="#follower-modal" style="font-size: 16px; background-color: transparent; border-style: none">
													팔로워<strong id="follower-cnt">
														${memberVO.follower_count}</strong>
												</button>
												<button id="btn_profile_follow" data-toggle="modal" href="#follow-modal"
													style="font-size: 16px; background-color: transparent; border-style: none">
													팔로우 <strong id="follow-cnt">
														${memberVO.follow_count}</strong>
												</button>
											</div>
											<div style="font-size: 15px; color: black; margin-top: 15px;">
												<span class="profile-span-margin-3px"
													style="word-break: break-all;">${memberVO.self_info}</span>
											</div>
										</div>
								</div>
								<!-- The Modal -->
								<div id="follower-modal" class="modal fade in">
						        <div class="modal-dialog">
						            <div class="modal-content">
						 
						                <div class="modal-header">
						                    <a class="btn btn-default" data-dismiss="modal" style="float: right;"><span class="glyphicon glyphicon-remove"></span></a>
						                    <h4 class="modal-title">팔로워</h4>
						                </div>
						                <div class="modal-body" style="max-height: 350px; overflow-Y:scroll;">
						                    <ul id="follower_ul">
						                    <c:forEach items="${memberVO.followerList }" var="i">
												  <li>
												  <div style="display: inline;">
												  		<img id="follower-img" src="<%=request.getContextPath()%>/${i.photo_path}">
												  </div>
												  <div style="display: inline; margin-left: 5px">${ i.id}
												  </div>
												 <c:if test="${sessionScope.loginId != i.id}">
												<c:set var="check" value="${i.checkMyFollow}" />
												<c:choose>
												    <c:when test="${check == true}">
												         <div style="display: inline;">
												  		<button class="profile-edit" id="following-btn2" style="float: right; border:groove;" value="${i.id}">
														팔로잉</button>
													</div>
												    </c:when>
												    <c:when test="${check == false}">
												          <div style="display: inline;">
												  		<button class="profile-edit" id="follower-btn2"  value="${i.id}"
														style="float: right; margin: auto; background-color: #3897f0; color: white; border: none; border:groove;">
														팔로우</button>
													</div>
												    </c:when>
												</c:choose>
												</c:if>
												  </li>
											  </c:forEach>
											</ul>
						                </div>
						            </div><!-- /.modal-content -->
						        </div><!-- /.modal-dalog -->
						    </div><!-- /.modal -->
							<!-- EO Modal -->
							
							<!-- The Modal -->
								<div id="follow-modal" class="modal fade in">
						        <div class="modal-dialog">
						            <div class="modal-content">
						 
						                <div class="modal-header">
						                    <a class="btn btn-default" data-dismiss="modal" style="float: right;"><span class="glyphicon glyphicon-remove"></span></a>
						                    <h4 class="modal-title">팔로우</h4>
						                </div>
						                <div class="modal-body" style="max-height: 350px; overflow-Y:scroll;">
						                    <ul id="follower_ul">
						                    <c:forEach items="${memberVO.followList }" var="i">
												  <li>
												  <div style="display: inline;">
												  		<img id="follower-img" src="<%=request.getContextPath()%>/${i.photo_path}">
												  </div>
												  <div style="display: inline; margin-left: 5px">${i.followee}
												  </div>
												  <c:if test="${sessionScope.loginId != i.followee}">
												  <c:set var="check" value="${i.checkMyFollow}" />
												<c:choose>
												    <c:when test="${check == true}">
												         <div style="display: inline;">
												  		<button class="profile-edit" id="following-btn2" style="float: right; border:groove;" value="${i.followee}">
														팔로잉</button>
													</div>
												    </c:when>
												    <c:when test="${check == false}">
												          <div style="display: inline;">
												  		<button class="profile-edit" id="follower-btn2" value="${i.followee}"
														style="float: right; margin: auto; background-color: #3897f0; color: white; border: none; border:groove;">
														팔로우</button>
													</div>
												    </c:when>
												</c:choose>
												</c:if>
												  </li>
											  </c:forEach>
											</ul>
						                </div>
						            </div><!-- /.modal-content -->
						        </div><!-- /.modal-dalog -->
						    </div><!-- /.modal -->
							<!-- EO Modal -->
							
								<!-- </div> -->
								<!--<hr> -->

								<!--<h4 class="text-center"> -->
								<!--	<a href="http://usebootstrap.com/theme/facebook" target="ext">Download -->
								<!--this Template @Bootply</a> -->
								<!--</h4> -->

								<!--<hr> -->
								</div>
							</div>
							<!-- /col-9 -->
						</div>
								<div class="row">
									<div id="gallery" class="gallery"  style="margin-top: 15px; max-width: 1000px; margin: auto">
										<c:choose>
											<c:when test="${not empty articleList}">
													<c:forEach items="${articleList}" var="articleVO">
														<c:if test="${not empty articleVO.getPhotoList()}">
															<c:if test="${not empty articleVO.getPhotoList().get(0).file_origiName}">
																<figure>
																<div data-toggle="modal" data-target=".bs-example-modal-lg">
																	<img id="article_img" name="article_img"
																		src="<%=request.getContextPath()%>/${articleVO.getPhotoList().get(0).file_origiName}"
																		style="z-index: 0;"
																		onclick="openGalleryModal('<%=request.getContextPath()%>', ${articleVO.article_num})">
																	<div class="photo-info" style="display: inline-block;">
																		<img
																			src="<%=request.getContextPath()%>/assets/img/icon/heart-profile.png"
																			style="width: 15px; height: 15px; display: inline-block;">
																		${articleVO.react_count}개
																		<img
																			src="<%=request.getContextPath()%>/assets/img/icon/chat.png"
																			style="width: 15px; height: 15px; display: inline-block; margin-left: 10px">
																		${articleVO.commentCount}개
																	</div>
																</div>
																</figure>
															</c:if>
														</c:if>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<div class="well">
														<p>게시글이 없습니다. <a href="<%=request.getContextPath()%>/initMain.do">타임라인</a>에서 첫 글을 작성해보세요.</p>
													</div>
												</c:otherwise>
											</c:choose>
									</div>
								</div>
						<!-- /padding -->
					</div>
					<!-- /main -->

						<hr>
						<jsp:include page="${request.getContextPat()}/footer.jsp" />
						<hr>
				</div>
			</div>
		</div>
</div>
		<!-- GalleryModal Start -->
		<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="width:100%;">
			<div class="modal-dialog modal-lg" style="width:90%; padding:0px;">
				<div class="modal-content">
				<table id="modal-table" style="width:100%">
					<tr>
						<td class="modal-controller" style="width:5%; bakcground-color:transparent">
							<a href="#" id="modal-left-button" class="glyphicon glyphicon-chevron-left" onclick=""></a>
						</td>
						<td style="width:70%">
								<div class="photo-slide" style="vertical-align: bottom;">
									<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="false" >
				
										<!-- Modal Content Area -->
										<div class="carousel-inner"></div>
				
										<!-- Controls -->
										<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
										<span style="vertical-align: middle; text-align: center;"><</span> 
										</a> <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
											<span>></span>
										</a>
									</div>
								</div>
						</td>
						<td style="width:20%">
							<table>
								<tr>
									<td style="width:100%">
										<div id="modal-user-info">
											<a id="modal-user-link" href="" style="display:flex;">
												<img id="modal-user-picture" src=""  style="width: 50px; height: 50px; border-radius: 50px; ">
												<lable id="modal-user-id"></lable>
											</a>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div id="modal-gallery-content"></div>
										<div style="width:100%; text-align: right;">
											<a class="modal-article-write-time"></a>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<table id="modal-gallery-comment-list" class="comment-area" width="100%">
										<!-- Start Comment  -->

										<!--  EO Comment -->
										</table>
										<hr>
										<textarea placeholder="댓글달기..." style="width:100%; resize:none;"></textarea>
									</td>
								</tr>
							</table>
						</td>
						<td class="modal-controller" style="width:5%; bakcground-color:transparent">
							<a href="#" id="modal-right-button" class="glyphicon glyphicon-chevron-right" onclick=""></a>
						</td>
					</tr>
				</table>
				</div>
			</div>
		</div>
		<!-- EO Gallery Modal -->
	</c:if>

</body>
</html>