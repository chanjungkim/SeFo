<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>Welcome! ${sessionScope.loginId}</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="<%=request.getContextPath()%>/assets/css/bootstrap.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/assets/css/profile.css"
	rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="<%=request.getContextPath()%>/assets/css/sefo.css"
	rel="stylesheet">
<script src="https://use.fontawesome.com/804ea8b780.js"></script>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
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
							addImage += '<figure><div><img id="article_img" name ="article_img" src="' + myContext + '/' + this.photoList[0].file_origiName + '"';
							addImage += 'style="z-index: 0;"><div class="photo-info">' + this.commentCount + '개</div></div> </figure>';
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
		$('#send')on('click',function(){
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
	function openGalleryModal(article_num){
		alert(article_num);
		var urlContext = '<%=request.getContextPath()%>/article.do/'+article_num;
		alert(urlContext);
		
		$.ajax({
			type: 'get',
			url: urlContext,
			data : {
				'article_num' : article_num  
			},
			dataType : 'json',
			success : function(articleVO) {
				var photoList = articleVO.photoList;
				var myContext = "<%=request.getContextPath()%>";
//	 			for( i in photoList){
//	 				var photoListInfo = photoList[i];
//	 				for( j in photoListInfo){
//	 					alert([i]+" "+[j]+" "+photoListInfo[j]);
//	 				}
//	 			}
				newModalContents =
					'<div class="item active">'
					+'<img class="img-responsive" src="'+ myContext +'/'+photoList[0].file_origiName +'" alt="...">'
					+'<div class="carousel-caption">One Image</div>'
					+'</div>';
				for(var i = 1 ; i < photoList.length ; i++){
					newModalContents +=
						'<div class="item">'
						+'<img class="img-responsive" src="'+ myContext +'/'+photoList[i].file_origiName +'" alt="...">'
						+'<div class="carousel-caption"> '+i+' Image</div>'
						+'</div>';
				}
				alert(newModalContents);
				$('.carousel-inner').empty();
				$('.carousel-inner').append(newModalContents);
			},
			error : function() {
				alert('Article 가져오기 ajax 요청 실패');
			}
		})
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

						<div class="padding">
							<div class="profile-container">
								<div>
									<!-- content -->
									<div class="row">
										<div class="my_profile_img col-md-4 img-fluid"
											style="margin: auto; width: auto; max-height: 100%; margin-left: 80px; margin-right: 80px;">
											<button
												style="border-style: none; background-color: transparent; outline: none;"
												class="btn btn-info btn-lg" data-toggle="modal"
												data-target="#myModal">
												<img id="profile_img"
													src="<%=request.getContextPath()%>/${memberVO.photo_path}">
											</button>
											<div id="myModal" class="modal fade" role="dialog">
												<div class="modal-dialog">

													<!-- Modal content-->
													<div class="modal-content">
														<input type="file">
														<input type="submit" id="send" value="전송">
													</div>

												</div>
											</div>
										</div>

										<div class="col-md-8"
											style="margin: auto; width: auto; max-height: 100%;">
											<div class="row"
												style="display: flex; align-items: center; align-self: center; margin-top: 10px;">
												<div
													style="font-size: 30px; margin-right: 30px; float: left; font-family: 나눔고딕">${memberVO.id }</div>
<!-- 												수정 : 성훈  -->
												<div class="row"
													style="float: left; display: flex; align-items: center;">
													<c:choose>
														<c:when test="${sessionScope.loginId == memberVO.id}">
															<button class = "profile-edit" style="float: left;">
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
																<button class = "profile-edit" id="following-btn" style="float: left;">
																	팔로잉
																</button>
															</c:if>
															<c:if test="${b==0}">
																<button class= "profile-edit" id="follow-btn"
																	style="float: left; background-color: #3897f0; color: white; border: none">
																	팔로우
																</button>
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
													id="span_profile_follower"
													style="font-size: 16px; background-color: transparent; border-style: none">
													팔로워<strong id="follower-cnt"> ${memberVO.follower_count}</strong>
												</button>
												<button id="btn_profile_follow"
													style="font-size: 16px; background-color: transparent; border-style: none">
													팔로우 <strong id="follow-cnt"> ${memberVO.follow_count}</strong>
												</button>
											</div>
											<div
												style="font-size: 15px; color: black; margin-top: 15px;">
												<span class="profile-span-margin-3px">${memberVO.self_info}</span>
											</div>
										</div>
									</div>
									<div id="gallery" class="gallery" style="margin-top: 15px">
										<c:forEach items="${articleList}" var="articleVO">
											<c:if test="${not empty articleVO.getPhotoList()}">
												<c:if
													test="${not empty articleVO.getPhotoList().get(0).file_origiName}">
													<figure>
													<div data-toggle="modal" data-target=".bs-example-modal-lg">
														<img id="article_img" name="article_img" src="<%=request.getContextPath()%>/${articleVO.getPhotoList().get(0).file_origiName}"
															style="z-index: 0;" onclick="openGalleryModal(${articleVO.article_num})">
														<div class="photo-info" style="">
															<img src="<%=request.getContextPath()%>/assets/img/icon/chat.png"
																style="width: 15px; height: 15px; display: inline-block;">
															${articleVO.commentCount}개
														</div>
													</div>
													</figure>
												</c:if>
											</c:if>
										</c:forEach>
									</div>
								</div>
								<!-- 									</div> -->
								<hr>
								<jsp:include page="${request.getContextPat()}/footer.jsp" />
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
		
		<!-- GalleryModal Start -->
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					
					<!-- Modal Content Area -->
					<div class="carousel-inner">
					</div>

					<!-- Controls -->
					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left"></span>
					</a> <a class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right"></span>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!-- EO Gallery Modal -->
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/assets/js/bootstrap.js"></script>
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