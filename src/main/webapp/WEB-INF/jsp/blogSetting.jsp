<%@ page
   contentType="text/html ; charset=UTF-8"
   pageEncoding="UTF-8"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ブログの設定</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="/TeraNavi/js/fileup.js"></script>
    <jsp:include page="/WEB-INF/jsp/googleanalytics.jsp"/>
</head>
<body>
    <%-- ヘッダー部分のHTMLを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>
    <%-- トップのナビゲーションを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/topnav.jsp"/>

    <div class="section">
        <div class="container">
           <div class="row">

                <!-- 2列をサイドメニューに割り当て -->
                <div class="col-md-2 hidden-xs">
                    <jsp:include page="/WEB-INF/jsp/mypagenav.jsp"/>
                    <script>
                      $("#blogSettingTab").attr("class","active");
                      $("#openBlogTab").attr("class","active");
                    </script>

                </div>

                <!--モバイル用のドロップダウンメニュー-->
                <div class="container visible-xs">
                    <div class="dropdown">
                        <button class="btn btn-danger dropdown-toggle" type="button" data-toggle="dropdown">ブログ設定<span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <li id="mypageTab">
                                <a href="/TeraNavi/front/mypage?paramUserId=${sessionScope.loginUser.id}">マイページ</a>
                            </li>
                            <c:choose>
                                <c:when test="${sessionScope.loginUser.blogStatus eq 1}">

                                    <li>
                                        <a href="/TeraNavi/front/showDraftArticleList?writeUserId=${sessionScope.loginUser.id}">下書き一覧</a>
                                    </li>
                                    <li>
                                        <a href="/TeraNavi/front/showBlog?targetURL=blogSetting">ブログ設定</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <a href="/TeraNavi/blogSetting">ブログ開設</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <li>
                                <a href="/TeraNavi/front/commmy?groupBy=group+By+community_members_list.fk_community_id+&where=community_members_list.fk_user_id%3D+%3F+and+communities.community_delete_flag+%3D0+and+community_members_list.community_withdrawal_flag+%3D0&target=create">コミュニティ管理</a>
                            </li>
<!--									<li>
                                <a href="/TeraNavi/front/showDmList">DM</a>
                            </li>-->
                            <br><br>
                            <li>
                                <a href="/TeraNavi/withdraw">退会</a>
                            </li>


                        </ul>
                    </div>
                </div>




                <div calss="col-md-8">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.blogStatus eq 1}">
                            <div class="col-md-1"></div>
                            <h1>ブログ設定<a class="btn btn-danger" href="/TeraNavi/blogDelete" role="button" style="margin-left: 26.5%;">ブログ閉鎖</a></h1>
                            <form id="blogSetting" action="/TeraNavi/front/blogSetting" method="post">
                                <input id="status" type="hidden" name="status" value="1">
                        </c:when>
                        <c:otherwise>
                            <div class="col-md-1"></div>
                            <h1>ブログ開設</h1>
                            <form id="blogCreate" action="front/blogCreate" method="post">
                                <input id="status" type="hidden" name="status" value="0">
                        </c:otherwise>
                    </c:choose>


                           <div class="col-md-1"></div>
                           <div class="col-md-6">


                               <c:choose>
                                   <c:when test="${sessionScope.loginUser.blogStatus eq 1}">
                                       タイトル<input type="text" name="title" class="form-control" id="blogTitle" value="${result.blog.title}"><br>
                                       説明文<textarea rows="3" class="form-control" name="explanation" id="bodyExplanation">${result.blog.explanation}</textarea><br>
                                       <p>ヘッダー画像</p>
                                       <img src="${result.blog.headerPath}" width="555px" height="150px" id="headimg">
                                    </c:when>
                                    <c:otherwise>
                                        タイトル<input type="text" name="title" class="form-control" id="blogTitle" placeholder="例:野球ブログ"><br>
                                        説明文<textarea rows="3" class="form-control" name="explanation" id="bodyExplanation" placeholder="例:このブログは野球について書きます"></textarea><br>
                                        <p>ヘッダー画像</p>
                                        <img src="/TeraNavi/img/NoImage.png" width="555px" height="150px" id="headimg">
                                    </c:otherwise>
                                </c:choose>
                                <input type="file" id="headerFile">
                                <input type="hidden" name="headerPath" id="headerPathHidden" value="${result.blog.headerPath}">
                               <div class="col-md-3">
                                    <button class="btn btn-warning" type="button" id="blogSubmit" data-toggle="modal" style="margin-left:485px;">確認</button>
                                </div>
                            </div>
                       </form>

                   </div>
                   <!-- モーダルウィンドウの中身 -->
                   <div class="fade modal text-justify" id="blog-modal">
                       <div class="modal-dialog">
                         <div class="modal-content">
                           <div class="modal-header">
                             <button type="button" class="close pull-right[]" data-dismiss="modal" aria-label="Close">
                               <span aria-hidden="true">×</span>
                             </button>
                             <c:choose>
                                 <c:when test="${sessionScope.loginUser.blogStatus eq 1}">
                                     <h4 class="modal-title">ブログ設定</h4>
                                 </c:when>
                                 <c:otherwise>
                                     <h4 class="modal-title">ブログ開設</h4>
                                 </c:otherwise>
                             </c:choose>
                            </div>

                           <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-10">
                                        <h2>タイトル</h2><h5 id="title"></h5>
                                        <h2>説明文</h2><h5 id="explanation"></h5>
                                        <h2>ヘッダー画像</h2><img src="" class="img-rounded" width="450" height="150" id="blogHeader">
                                    </div>
                                    <div class="col-md-1"></div>
                                </div>
                           </div>

                           <div class="modal-footer">
                               <c:choose>
                                   <c:when test="${sessionScope.loginUser.blogStatus eq 1}">
                                       <button type="submit" class="btn btn-block btn-warning" form="blogSetting">設定する</button>
                                   </c:when>
                                   <c:otherwise>
                                       <button type="submit" class="btn btn-block btn-warning" form="blogCreate">開設する</button>
                                   </c:otherwise>
                               </c:choose>


                               <button type="button" class="btn btn-block btn-warning" data-dismiss="modal">キャンセル</button>
                           </div>
                         </div>
                       </div>
                    </div>

               </div>

           </div><!--end row-->
       </div><!--end container-->
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
				dataType:'json'

			};

		});



        // 画像アップロード関連


        $(document).on("change","#headerFile",function(){
            var file = this.files[0];
            // ブラウザごとの違いをフォローする
            window.URL = window.URL || window.webkitURL ;

            // Blob URLの作成
            src = window.URL.createObjectURL( file ) ;
            $("#headimg").attr("src", src);
            fileUpHeader();
        });

        $("#blogSubmit").on("click", function() {
            $("#title").empty();
            $("#explanation").empty();
            $("#blogHeader").empty();


            $("#title").append($("#blogTitle").val());
            $("#explanation").append($("#bodyExplanation").val());
            $("#blogHeader").attr("src",$("#headimg").attr("src"));

            $("#blog-modal").modal("show");
        });
        function fileUpHeader(){
			var files = document.getElementById("headerFile").files;

			for(var i = 0;i < files.length;i++){
				console.log("for");
				var f = files[i];
				var formData = new FormData();
				formData.append("file",f);
				ajaxSettings.data = formData;
				ajaxSettings.url = "/TeraNavi/upload/header";
				ajaxSettings.success = function(data){
					$("#headerPathHidden").val(data.result);
					$("#headerFile").attr("src",data.result);
				}

 				ajax = $.ajax(ajaxSettings);
			}
		}

        function fileUpIcon(){
			var files = document.getElementById("iconFile").files;

			for(var i = 0;i < files.length;i++){
				console.log("for");
				var f = files[i];
				var formData = new FormData();
				formData.append("file",f);
				ajaxSettings.data = formData;
				ajaxSettings.url = "/TeraNavi/upload";
				ajaxSettings.success = function(data){
					$("#comIconPath").val(data.result);
					$("#icon").attr("src", data.result);
				}

 				ajax = $.ajax(ajaxSettings);
			}

		}

        $(document).on("change","#iconFile",function(){
            var file = this.files[0];
            // ブラウザごとの違いをフォローする
            window.URL = window.URL || window.webkitURL ;

            // Blob URLの作成
            src = window.URL.createObjectURL( file ) ;

            fileUpIcon();
        });

	</script>

</body>
</html>
