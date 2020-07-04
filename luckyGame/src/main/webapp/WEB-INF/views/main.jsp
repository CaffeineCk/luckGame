<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>나의 행운 테스트</title>
        <link rel="icon" type="image/x-icon" href="/static/assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/static/css/styles.css?t=2" rel="stylesheet" />
        <!-- slick -->
        <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>      
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="/">Good Luck</a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                  	 랭킹
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="/ranking">명예의 전당</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <header class="masthead">
            <div class="container d-flex h-100 align-items-center">
                <div class="mx-auto text-center">
               	 <div id="roadview" style="width:100%;height:300px;"></div>
                    <h2 class="text-white-50 my-0 text-uppercase">재미로 하는 행운 테스트</h2>
                    <h3 class="text-white-50 mx-auto mt-2 mb-5">닉네임을 입력해주세요.</h3>
                    <input class="form-control flex-fill mr-0 mr-sm-2 mb-3 mb-sm-0" id="nickname"placeholder="닉네임" autocomplete="off" maxlength = "6">
                    </br>
                    <a class="btn btn-primary js-scroll-trigger" id = "startBtn">Start</a>
                </div>
            </div>
        </header>
        <!-- About-->
        
      
        <!-- Contact-->
        <section class="contact-section bg-black">
            <div class="container">
                <div class="row">                  
                    <div class="col-md-4 mb-3 mb-md-0">
                        <div class="card py-4 h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-envelope text-primary mb-2"></i>
                                <h4 class="text-uppercase m-0">Email</h4>
                                <hr class="my-4" />
                                <div class="small text-black-50"><a href="#!">caffeinecookies@gmail.com</a></div>
                            </div>
                        </div>
                    </div>                   
                </div>             
            </div>
        </section>
        <!-- Footer-->
        <footer class="footer bg-black small text-center text-white-50"><div class="container">Copyright © cafeck</div></footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Core theme JS-->
        <script src="/static/js/scripts.js"></script>
        <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
        <script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
        let nickname;
        let playerId;
        let nowStage = 1;
        let stageInfoForKakao;
        
        $( document ).ready(function(){			

        });
        
		$("#startBtn").click(function(){
			nickname = $("#nickname").val();

			if(nickname == '') {
				alert('닉네임을 입력해주세요');
				return false;
				}
			getNextUserId();
			startRound(nowStage);
		})
		
		$(document).on("click",".btn.btn-primary.js-scroll-trigger.game-box",function(){
				var selectNum = (this.id).replace(/[^0-9]/g,'');
				var numtest = getRandomNum(nowStage);
				if(nowStage < 20) {
					if (numtest != selectNum) {
						startRound(++nowStage);
					} else {
						fail(nowStage);
					}
				} else {
					if (getRandomNum(nowStage) == selectNum) {
						startRound(++nowStage);
					} else {
						fail(nowStage);
					}
				}
				
			}
		)
		
		$(document).on("click","#retryBtn",function(){

				if(nickname != undefined) {
					nowStage = 1;
					startRound(nowStage);
				} else {
					alert('닉네임이 없습니다. 처음으로 돌아갑니다.');
					window.location.reload();
				}
			}
		)
		
		function startRound(stage){			
			$(".mx-auto.text-center").empty();
		
			var btn = "<a class='btn btn-primary js-scroll-trigger game-box type"
			var btn2 = "' id = 'btn_";
			var btn3 = "'style='margin-bottom: 20px;' >SELECT</a>&emsp;"
			var prevPos = getPossibility(stage-1);
			var nowPos = getPossibility(stage);
			$(".mx-auto.text-center").hide().append("<h3 class='text-white-50 mx-auto mt-2 mb-5'>현재까지확률(누적) : " + prevPos + '%</br>도전 확률(누적):' +  nowPos + "%</h3>")	
			$(".mx-auto.text-center").hide().append("<h3 class='text-white-50 mx-auto mt-2 mb-5'>선택 해주세요</h3>")					
			
			
			if (stage < 10) {							
				for(var i = 1; i <= 11 - stage ; i++) {
					$(".mx-auto.text-center").hide().append(btn + stage + btn2 + i + btn3).fadeIn("slow").show();					
				}				
			} else if (stage < 20) {
				for(var i = 1; i <= 2; i++) {
					$(".mx-auto.text-center").hide().append(btn + stage + btn2 + i + btn3).fadeIn("slow").show();					
				}

			} else if (stage < 30) {
				for(var i = 1; i <= 3; i++) {
					$(".mx-auto.text-center").hide().append(btn + stage + btn2 + i + btn3).fadeIn("slow").show();					
				}
			}
					
		}

		function fail(stage){	
			var player = {};
			var playerRankInfo;
			player.playerId = playerId;
			player.stage = stage - 1;
			player.nickname = nickname;
			player.possibility = getPossibility(stage - 1);
			
			 $.ajax({
                 url: "/save",
                 type: "POST",
                 cache: false,
                 dataType: "json",
                 data: JSON.stringify(player),
                 async : false,
                 contentType: "application/json; charset=utf-8;",
                 success: function(data){                                               
                	 playerRankInfo = data;
                	 stageInfoForKakao = data.stageDescription;             
                 },
                 error: function (request, status, error){        

                 }
               });
			
			$(".mx-auto.text-center").empty();
			
			$(".mx-auto.text-center").hide().append("<h3 class='text-white-50 mx-auto mt-2 mb-5'></br></br>" +  getPossibility(stage - 1) + "% 확률도전에 성공했습니다</br></h3>")	
			
			$(".mx-auto.text-center").hide().append("<img src = '/static/assets/roundImg/round_" + stage + ".jpg' style='max-width: 60%; height: auto;'/><br><br>")	;

			$(".mx-auto.text-center").hide().append("<h3 class='text-white-50 mx-auto mt-2 mb-5'>" +  playerRankInfo.stageDescription + "</br></br> 당신의 순위는 총 <span style='color:white; font-weight: bold;'> " +playerRankInfo.TOTALCNT +"명</span> 중  <span style='color:white; font-weight: bold;'>" + playerRankInfo.PLAYERRANK + "</span>위 </br> 상위 <span style='color:red; font-weight: bold;'>" + playerRankInfo.PERCENTAGE + "</span>입니다.</h3>")	
			
			var btn = "<a class='btn btn-primary js-scroll-trigger' id = 'retryBtn' style='margin-right: 20px;'>Retry</a>"
			var btn2 = "<a class='btn btn-primary js-scroll-trigger' id = 'rankingBtn' href='/ranking'>Ranking</a>"
			var kakaoBtn = "<img src = /static/assets/img/kakao.png onClick='shareKakaotalk()' style='width:50;height:auto'  value='KAKOA Talk으로 공유하기'/></br></br>"
			$(".mx-auto.text-center").hide().append(kakaoBtn).fadeIn("slow").show();
			$(".mx-auto.text-center").hide().append(btn).fadeIn("slow").show();
			$(".mx-auto.text-center").hide().append(btn2).fadeIn("slow").show();
			
			
		}

		function getRandomNum(stage) {
			if (stage < 10) {
				return Math.floor((Math.random() * ((11 - stage) - 2)) + 1)
			} else if (stage < 20) {
				return Math.floor((Math.random() * 2) + 1);
			} else if (stage < 30) {
				return Math.floor((Math.random() * 3) + 1);
			} 
			
		    return false;
		}

		function getPossibility(stage){
			if (stage < 10) {
				return (10-stage) * 10;
			} else if (stage < 20) {
				return (getPossibility(stage-1) / 2).toFixed(4);
			} else if (stage < 30) {
				return (getPossibility(stage-1) / 3).toFixed(6);
			} 

			return false;			
		}

		function getNextUserId(){
			 $.ajax({
                 url: "/getId",
                 type: "POST",
                 cache: false,
                 dataType: "json",
                 success: function(data){                                               
                    console.log(data);
                    playerId = data;
                 },
                 error: function (request, status, error){        

                 }
               });
			}

		function shareKakaotalk() {
	        Kakao.init("699c9e5815d5237fe6132f3601449f85");      // 사용할 앱의 JavaScript 키를 설정
	        Kakao.Link.sendDefault({
	              objectType:"feed"
	            , content : {
	                  title:"나의 행운은 몇 퍼센트?"   // 콘텐츠의 타이틀
	                , description:stageInfoForKakao + "를 돌파하였습니다!!"  // 콘텐츠 상세설명
	                , imageUrl:"http://1.239.208.223:9998/static/assets/roundImg/round_" + nowStage +".jpg"  // 썸네일 이미지
	                , link : {
	                      mobileWebUrl:"http://1.239.208.223:9998/"   // 모바일 카카오톡에서 사용하는 웹 링크 URL
	                    , webUrl:"http://1.239.208.223:9998//" // PC버전 카카오톡에서 사용하는 웹 링크 URL
	                }
	            }
	            , social : {
	                  likeCount:0       // LIKE 개수
	                , commentCount:0    // 댓글 개수
	                , sharedCount:0     // 공유 회수
	            }
	            , buttons : [
	                {
	                      title:"나도 도전"    // 버튼 제목
	                    , link : {
	                        mobileWebUrl:"http://1.239.208.223:9998//"   // 모바일 카카오톡에서 사용하는 웹 링크 URL
	                      , webUrl:"http://1.239.208.223:9998//" // PC버전 카카오톡에서 사용하는 웹 링크 URL
	                    }
	                }
	            ]
	        });
	    }
		
        </script>
    </body>
</html>
