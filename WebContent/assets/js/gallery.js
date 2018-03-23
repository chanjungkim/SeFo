	var leftArticleNum;
	var rightArticleNum;
function openGalleryModal(myContextPath, article_num){
//	alert(article_num);
	var urlContext = myContextPath+'/article.do/'+article_num;
//	alert(urlContext);

	
	$.ajax({
		type: 'get',
		url: urlContext,
		data : {
			'article_num' : article_num
		},
		dataType : 'json',
		success : function(articleVO) {
			alert(JSON.stringify(articleVO));
			
			var photoList = articleVO.photoList;
			var myContext = myContextPath;

			newModalContents =
				'<div class="item active">'
				+'<img class="img-responsive" src="'+ myContextPath +'/'+photoList[0].file_origiName +'" alt="...">'
				+'</div>';
			for(var i = 1 ; i < photoList.length ; i++){
				newModalContents +=
					'<div class="item">'
					+'<img class="img-responsive" src="'+ myContextPath +'/'+photoList[i].file_origiName +'" alt="...">'
					+'</div>';
			}

			$('.carousel-inner').empty();
			$('.carousel-inner').append(newModalContents);
			$('#modal-user-link').attr('href', myContextPath+'/profile.do/'+articleVO.id);
			$('#modal-user-picture').attr('src', myContextPath+'/'+articleVO.photo_path);
			$('#modal-user-id').text(articleVO.id);
			$('#modal-gallery-content').text(articleVO.content);
			$('#modal-article-write-time').text(articleVO.write_time);
			
			var commentTags = "";
			for( var i = 0 ; i < articleVO.commentList.length ; i++){
				var commentVO = articleVO.commentList[i];

				commentTags += '<tr id="comment-'+commentVO.comment_num+'" style="margin-bottom: 5px;">'
									+'<td width="45px">'
									+'<a href="'+myContextPath+'/profile.do/'+commentVO.id+'">'
									+'<img class="comment-img" src="'+myContextPath+'/'+commentVO.photo_path+'" style="width:30px; height:30px; border-radius: 50px;">'
									+'</a>'
									+'</td>'
									+'<td>'
									+'<a href="'+myContextPath+'/profile.do/'+commentVO.id+'"><b>'+commentVO.id
									+'</b></a> &nbsp;'+commentVO.content;
				
				if("${sessionScope.loginId}" == commentVO.id){
					commentTags+= '<input id="comment-delete" type="hidden" name="comment_num" 	value="'+commentVO.comment_num+'">'
										+'<a onclick="deleteComment('+commentVO.comment_num+')" style="color: #CCC; font-size: 5px;">X</a>';
				}
				
				commentTags += '<div style="font-size: 5px; color:grey;">'+commentVO.write_time+'</div>'
									+'</td>'
									+'</tr>';
			}
//			alert(articleVO.photo_path);
			
			$('#modal-gallery-comment-list').empty();
			$('#modal-gallery-comment-list').append(commentTags);

			getLeftArticleNum(myContextPath, article_num, articleVO.id);
			getRightArticleNum(myContextPath, article_num, articleVO.id);
			
			$( document ).ajaxStop(function() {
				 
//				alert("All do:"+leftArticleNum+"/"+rightArticleNum);
				
				if(leftArticleNum <= 0){
					$("#modal-left-button").hide();
				}else{				
					$("#modal-left-button").show();
					$("#modal-left-button").attr('onclick', 'openGalleryModal("'+myContextPath+'", '+leftArticleNum+')');
				}
				

				if(rightArticleNum <= 0){
					$("#modal-right-button").hide();				
				}else{
					$("#modal-right-button").show();
					$("#modal-right-button").attr('onclick', 'openGalleryModal("'+myContextPath+'", '+rightArticleNum+')');				
				}
			});
		},
		error : function() {
			alert('Article 가져오기 ajax 요청 실패');
		}
	})
}
function getLeftArticleNum(myContextPath, article_num, id){
//	var leftArticleNum = -1;
	leftArticleNum = -1;
	var urlContext = myContextPath+'/leftArticle.do';

//	alert(urlContext);
	$.ajax({
		type: 'get',
		url: urlContext,
		data : {
			'id' : id,
			'article_num' : article_num
		},
		dataType : 'json',
		success : function(resultData) {
			leftArticleNum = resultData;
//			alert("leftArticleNum: "+resultData)
		},
		error : function() {
			leftArticleNum = -1;
//			alert('leftArticleNum 가져오기 ajax 요청 실패');
		}
	})
	
	
}
function getRightArticleNum(myContextPath, article_num, id){
//	var rightArticleNum = -1;
	rightArticleNum = -1;
	var urlContext = myContextPath+'/rightArticle.do';
	
//	alert(urlContext);
	$.ajax({
		type: 'get',
		url: urlContext,
		data : {
			'id' : id,
			'article_num' : article_num
		},
		dataType : 'json',
		success : function(resultData) {
			rightArticleNum = resultData;
//			alert("rightArticleNum: "+resultData)
		},
		error : function() {
//			alert('leftArticleNum 가져오기 ajax 요청 실패');
			rightArticleNum = -1;
		}
	})
}