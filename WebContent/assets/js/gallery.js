function openGalleryModal(myContextPath, article_num){
	alert(article_num);
	var urlContext = myContextPath+'/article.do/'+article_num;
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
			var myContext = myContextPath;
		 //	 			for( i in photoList){
		 //	 				var photoListInfo = photoList[i];
		 //	 				for( j in photoListInfo){
		 //	 					alert([i]+" "+[j]+" "+photoListInfo[j]);
		 //	 				}
		 //	 			}
			newModalContents =
				'<div class="item active">'
				+'<img class="img-responsive" src="'+ myContextPath +'/'+photoList[0].file_origiName +'" alt="...">'
				+'<div class="carousel-caption">One Image</div>'
				+'</div>';
			for(var i = 1 ; i < photoList.length ; i++){
				newModalContents +=
					'<div class="item">'
					+'<img class="img-responsive" src="'+ myContextPath +'/'+photoList[i].file_origiName +'" alt="...">'
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