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
<link href="assets/css/bootstrap.css" rel="stylesheet">
<link href="assets/css/profile.css" rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="assets/css/sefo.css" rel="stylesheet">
<script src="https://use.fontawesome.com/804ea8b780.js"></script>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
<script type="text/javascript">
	var article_last_index = ${articleList.get(articleList.size()-1).article_num};
	$(function() {
		$(window).scroll(function() {
			var maxHeight = $(document).height();

			currentScroll = $(window).scrollTop() + $(window).height();
			if (maxHeight <= currentScroll) {
				//ajax 요청
				$.ajax({
					type : 'post', //요청 보내면 doPost가 실행됨
					url : 'profileMoreArticle.do',
					data : {
						'articleNum' : article_last_index
					},
					dataType : 'json',
					success : function (resultData) {
						var loader = '<div id ="loader" class="col-md-3">';
						loader += '<div class="panel panel-default"  style="background-color:rgba(204,204,204,1);">'; 
				        loader += '<div class="adjust">'; 
				        loader += '<div class="loader2"></div>';
				        loader += '</div>';
				        loader += '</div>';
				        loader += '</div>';
				        
				        var addImage = "";
				        $.each(resultData, function(){
				        	article_last_index = this.article_num;
							addImage += '<figure><div><img id="article_img" name ="article_img" src="'+this.photoList[0].file_origiName+'"';
					        addImage += 'style="z-index: 0;"><div class="photo-info">'+this.commentCount+'개</div></div> </figure>';
				        })
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
		
		$(document).on('mouseenter', "#article_img", function(){
			$(this).parent().attr('style', 'background-color:black;')
			$(this).attr('style', 'opacity: 0.6');
			$(this).siblings().attr('style', 'opacity: 1');
		});
		
		$(document).on('mouseleave', "#article_img", function(){
			$(this).parent().attr('style', 'background-color:none')
			$(this).attr('style', 'background-color: none; opacity:1');
			$(this).siblings().attr('style', 'opacity: 0');
		});
	});
</script>
<style type="text/css">
figure {
	position: relative;
}

figure > div > .photo-info {
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
											<img id="profile_img"
												src="assets/img/profile_pictures/test.JPG">
										</div>

										<div class="col-md-8"
											style="margin: auto; width: auto; max-height: 100%;">
											<div class="row"
												style="display: flex; align-items: center; align-self: center; margin-top: 10px;">
												<div
													style="font-size: 30px; margin-right: 25px; float: left;">${memberVO.id }</div>

												<div class="row"
													style="float: left; display: flex; align-items: center;">
													<c:if test="${accessAut} == 'self'">
														<button id="profile-edit" style="float: left;"><a href="myPage.do">프로필편집</a></button>
														<a href="#"><img src="assets/img/profile_settiong.png"
															style="width: 30px; height: 30px; float: left; vertical-align: bottom;"></a>
													</c:if>
													<button id="profile-edit" style="float: left;"><a href="#">채팅하기</a></button>
												</div>
											</div>
											<div class="row" style="margin-top: 10px;">
												<span class="profile-span-margin-3px">게시물 </span> <strong><span
													class="profile-span-margin-10px" id="span_profile_article">${totalContentCnt}
												</span></strong> 
												<button class="profile-span-margin-3px" id="span_profile_follower" style="font-size: 16px; background-color: transparent; border-style: none">팔로워<strong>
													${memberVO.follower_count}</strong></button>
												<button id="btn_profile_follow"
													style="font-size: 16px; background-color: transparent; border-style: none">팔로우
													<strong> ${memberVO.follow_count}</strong></button>
											</div>
											<div
												style="font-size: 15px; color: black; font-weight: bold; margin-top: 10px;">${memberVO.self_info }</div>
										</div>
									</div>
									<div id="gallery" class="gallery" style="margin-top: 15px">
										<c:forEach items="${articleList}" var="articleVO">
											<c:if test="${!empty articleVO.getPhotoList() }">
												<figure>
												<div>
													<img id="article_img" name="article_img"
														src=${articleVO.getPhotoList().get(0).file_origiName }
														style="z-index: 0; " >
													<div class="photo-info" style="">
														<img src="assets/img/icon/chat.png" style="width: 15px; height: 15px; display: inline-block;">
														${articleVO.commentCount }개
													</div>
												</div>
												</figure>
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