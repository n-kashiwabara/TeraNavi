<%@ page
   contentType="text/html ; charset=UTF-8"
   pageEncoding="UTF-8"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>

    <meta charset="UTF-8">

    <title>マイページ</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

</head>
<body>
    <%-- ヘッダー部分のHTMLを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>

    <div class="container">
       <div class="row">
           <h1>ユーザ基本設定</h1><br><br>


		   <form action="front/basic" method="post">
			   ユーザ名 <input type="text" name="userName" value="${sessionScope.loginUser.userName}"><br>
			   ふりがな <input type="text" name="nameKana" value="${sessionScope.loginUser.nameKana}"><br>
			   性別の表示非表示 ・表示<input type="radio" name="sexVisibleFlag" value="0" checked="true"> ・非表示<input type="radio" name="sexVisibleFlag" value="1"><br>
			   メールアドレス <input type="text" name="mailAddress" value="${sessionScope.loginUser.mailAddress}"><br>

			   <div id="head">
			   		ヘッダ画像 <input type="file" id="accountHeaderFile" onchange="fileUpHeader()">
					<input id="headPhoto" type="hidden" name="headerPath" value="${sessionScope.loginUser.headerPath}"><br>
			   </div>

			   <div id="icon">
			   		ユーザアイコン <input type="file" id="accountIconFile" onchange="fileUpIcon()">
					<input id="iconPhoto" type="hidden" name="iconPath" value="${sessionScope.loginUser.iconPath}"><br>
			   </div>

			   自己紹介
			   <textarea name="profile" rows="8" cols="40">${sessionScope.loginUser.profile}</textarea>

			   <input type="submit" value="変更">
		   </form>



       </div><!--end row-->
    </div><!--end container-->


    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>

	<script>
		var ajaxSettings;
		var ajax;
		$(function(){

			ajaxSettings = {
				type:'post',
				url:'/TeraNavi/upload',
				processData:false,
				contentType:false,
				cache:false,
				dataType:'json'
			}
			
			

		});

		function fileUpIcon(){
			var files = document.getElementById("accountIconFile").files;

			for(var i = 0;i < files.length;i++){
				var f = files[i];
				var formData = new FormData();
				formData.append("file",f);
				ajaxSettings.data = formData;
				ajaxSettings.url = "/TeraNavi/upload";
				ajaxSettings.success = function(data){
					$("#iconPhoto").val(data.result);
				}
				
 				ajax = $.ajax(ajaxSettings);
			}
			
		}
		
		function fileUpHeader(){
			var files = document.getElementById("accountHeaderFile").files;

			for(var i = 0;i < files.length;i++){
				console.log("for");
				var f = files[i];
				var formData = new FormData();
				formData.append("file",f);
				ajaxSettings.data = formData;
				ajaxSettings.url = "/TeraNavi/upload/header";
				ajaxSettings.success = function(data){
					$("#headPhoto").val(data.result);
				}
				
 				ajax = $.ajax(ajaxSettings);
			}
		}

		

	</script>
</body>
</html>
