
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>コミュニティ作成</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>


	<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
    rel="stylesheet" type="text/css">

</head>
<body>
    <%-- ヘッダー部分のHTMLを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>

	<!--
 
    <div class="container">
       <div class="row">
           <h1>コミュニティ作成ページ</h1>
           <form action="front/createcomm" method="post">
                コミュニティ名<input type="text" name="commName"><br>
               説明文 <input type="text" name="commProfile"><br>
                コミュニティアイコン<input type="file" name="body" onchange="onDrop(event)"><br>
                <input class="tbody" type="hidden" name="commIcon">
               ヘッダ画像 <input type="file" name="date" onchange="onDrop(event)"><br>
               <input class="tbody" type="hidden" name="commHeader">
                   <input type="hidden" name="userId" value="${sessionScope.loginUser.id}">
               <input type="submit" value="登録">
           </form>
       </div>
    </div>
	
	-->
	
	
	
	
	<div class="section">
      <div class="container">
        <div class="row">
          <div class="col-xs-10 col-xs-offset-1">
			<form role="form" action="/TeraNavi/front/createcomm" method="post" id="commForm">
              <div class="form-group">
                <label class="control-label" for="name">コミュニティ名</label>
                <input class="form-control" id="name" name="commName">
              </div>
              <div class="form-group">
                <label class="control-label" for="profile">紹介文</label>
                <textarea class="form-control" id="profile" rows="4" name="commProfile"></textarea>
              </div>アイコン
              <div class="col-md-12 text-left">
                <img src="http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png"
                width="50px" height="50px">
              </div>
              <br>
              <button type="submit" class="btn btn-default">ファイルを選択</button>
              <input id="icon" type="hidden" name="commIcon">
			  <br>
              <br>ヘッダ画像
              <br>
              <div class="col-md-12 text-left">
                <img src="http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png"
                width="50px" height="50px">
              </div>
              <button type="submit" class="btn btn-default">ファイルを選択</button>
              <br>
              <br>
              <br>
			  <input id="header" type="hidden" name="commHeader">
			  
			  <input type="hidden" name="userId" value="${sessionScope.loginUser.id}">
              <div class="text-center">
                <button type="button" class="btn btn-primary" id="csubmit"  data-toggle="modal" data-target="#myModal">コミュニティを作成</button>
				
				
				<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">クリックするとモーダルウィンドウが開きます。</button> -->
                <!--モーダルがあったところ-->
              </div>
            </form>

            <!-- モーダルウィンドウの中身 -->
            <div class="fade modal text-justify" id="myModal">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">確認画面</h4>
                  </div>
                  <div class="modal-body">
                    <img src="cat34.jpg" width="350" height="60" id="mHeader"><br>
                    <div class="col-xs-1"></div>
                    <div class="col-xs-10">
                      <h1 id="mTitle"></h1>
                      <h2 id="mProfile"></h2>
                      <p></p>
                      <!-- アイコン -->
                      <div class="col-xs-4">
                        <img src="http://pingendo.github.io/pingendo-bootstrap/assets/user_placeholder.png"
                        class="center-block img-circle img-responsive" width="150" height="150" id="mIcon">設定したアイコン
                      </div>

                    </div>
                  </div>
                  <div class="modal-footer">
					  <button type="submit" class="btn btn-block btn-primary" form="commForm">OK</button>
					  <button type="submit" class="btn btn-block btn-primary" data-dismiss="modal">閉じる</button>
                  </div>
                </div>
              </div>
            </div>
            <!-- モーダル閉じるやつだよ -->

          </div>
        </div>
      </div>
    </div>
	

    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>
	<script>
		var ajaxSettings;
		var ajax;
		$(function(){

			ajaxSettings = {
				type:'post',
				url:'upload',
				processData:false,
				contentType:false,
				cache:false,
				dataType:'json',
				success:function(data){
					console.log("success");
					var text = $(".tbody").val();
					$(".tbody").val(text+"<br>"+data.result);
				}
			}
			
			$("#csubmit").on("click",function(){
				$("#mHeader").attr("src",$("#header").val());
				$("#mTitle").append($("#name").val());
				$("#mProfile").append($("#profile").val());
				$("#mIcon").attr("src",$("#icon").val());
				console.log("Modal Open");
			});

		});

		function onDrop(event){
			var files = event.dataTransfer.files;

			console.log("オンドロップ");

			for(var i = 0;i < files.length;i++){
				console.log("for");
				var f = files[i];
				var formData = new FormData();
				formData.append("file",f);
				ajaxSettings.data = formData;
				ajax = $.ajax(ajaxSettings);
			}

			event.preventDefault();
		}

		function onDragOver(event){
			event.preventDefault();
		}


	</script>
</body>
</html>
