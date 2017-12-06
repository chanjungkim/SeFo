<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha256-7s5uDGW3AHqw6xtJmNNtr+OBRJUlgkNJEo78P4b0yRw= sha512-nNo+yCHEyn0smMxSswnf/OnX6/KwJuZTlNZBjauKhTK0c+zT+q5JOCx0UFhXQ6rJR9jg6Es8gPuD2uZcYDLqSw=="
	crossorigin="anonymous">
<link href="${request.getContextPath}/assets/css/photo-slide.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="${request.getContextPath}/assets/js/photo-slide.js"></script>
</head>
<body>
	<div class="carouselGallery-grid hidden-xs">
		<div class="row">
			<div class="carouselGallery-col-60">
				<div class="carouselGallery-col-40">
					<div class="carouselGallery-col-2 carouselGallery-carousel"
						data-index="1" data-username="userId" data-imagetext="내용"
						data-location="" data-likes="like 수" data-imagepath="img/1.JPG"
						style="background-image: url(img/3.JPG);">
						<div class="carouselGallery-item">
							<div class="carouselGallery-item-meta">
								<!-- 	            <span class="carouselGallery-item-meta-user"> -->
								<!-- 	                @visitsweden -->
								<!-- 	            </span> -->
								<!-- 	            <span class="carouselGallery-item-meta-likes"> -->
								<!-- 	                <span class="icons icon-heart"></span>4151 -->
								<!-- 	            </span> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>