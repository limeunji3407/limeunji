var ANDROID = "android";
var IOS = "ios";

/**
 * 브릿지 공통소스
 */
/**
 * 스캔시
 * @param memberSeq 사용자KEY
 * @returns
 */
function BridgeOpenScan(memberSeq, imgUrl, lang){
   if (checkMobile() == ANDROID) { 
      window.label.BridgeOpenScan(memberSeq, imgUrl);
   } else if (checkMobile() == IOS) {
       //IOS 일때 처리
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeOpenScan", "memberSeq": memberSeq, "imgUrl":imgUrl, "language":lang} );
   }
}
/**
 * 스캔시 > 콜백
 * @param codeData 스캔결과코드
 * @returns
 */
function BridgeScanRst(codeData, LAT, LNG, APP_ID, DEVICE_ID, rstCode, rstMsg){
	if (checkMobile() == ANDROID) { 
		if (!!navigator.geolocation){
		     navigator.geolocation.getCurrentPosition(function(position){
		        var lat = position.coords.latitude;
		        var lng = position.coords.longitude;
		        
		        BridgeScanRstSub(codeData, lat, lng, APP_ID, DEVICE_ID, rstCode, rstMsg)
		         
		     },function(){
		        BridgeScanRstSub(codeData, 0, 0, APP_ID, DEVICE_ID, rstCode, rstMsg)
		     });  
		   }else{
		      BridgeScanRstSub(codeData, 0, 0, APP_ID, DEVICE_ID, rstCode, rstMsg)
		   }
   } else if (checkMobile() == IOS) {
       //IOS 일때 처리
	   BridgeScanRstSub(codeData, LAT, LNG, APP_ID, DEVICE_ID, rstCode, rstMsg)
   }
}

function BridgeScanRstSub(codeData, LAT, LNG, APP_ID, DEVICE_ID, rstCode, rstMsg){
   APP_ID = APP_ID ? APP_ID : "APP_ID__TEMP";
   DEVICE_ID = DEVICE_ID ? DEVICE_ID : "DEVICE_ID_TEMP";
   
    getAddress(LAT, LNG, function (LOCATE, LOCATEZONE){
         if((rstCode == '0000' || !rstCode) && (!rstMsg || rstMsg == 'undefined')){
            //히스토리 내역 저장
            var DEVICE_TYPE = "";
            if (checkMobile() == ANDROID) { 
               DEVICE_TYPE = ANDROID;
            } else if (checkMobile() == IOS) {
                //IOS 일때 처리
               DEVICE_TYPE = IOS;
            }
            var param = {
                  "CODE_DATA":codeData,
                  "TBCheckHstEntity":{
                     "APP_ID":APP_ID,
                     "DEVICE_ID":MEMBER_SEQ,
                     "LAT":LAT,
                     "LNG":LNG,
                     "LOCATE":LOCATE,
                     "LOCATEZONE":LOCATEZONE,
                     "DEVICE_TYPE":DEVICE_TYPE
                  },
                  "REG_USER":MEMBER_SEQ,
                  "TBProductsBasEntity":{
                     "PROD_ID":PROD_ID
                  }
            }
            ajaxCallPost("/api/original/history", param, 
               function(res){
                  if(res.success){
                     
                     
                     //2차인증이 된 상품에 또 2차인증시도를 타인이함
                     if(res.result.result_code == '505'){
                        
                        var param = {
                              "CODE_DATA":codeData,
                              "PROD_ID":PROD_ID
                        }
                        ajaxCallPost("/sendpush", param, 
                              function(res){
                                 location.href="/original/auth/copy?code_data="+codeData+"&prod_id="+PROD_ID;
                              },function(){
                                 location.href="/original/auth/copy?code_data="+codeData+"&prod_id="+PROD_ID;
                              }
                        );
                     }else{
                        //검증
                        var param = {
                              "CODE_DATA":codeData,
                              "TBProductsBasEntity":{
                                 "PROD_ID":PROD_ID
                              }
                        }
                        ajaxCallPost("/api/original/check", param, 
                           function(res){
                              if(res.success){
                                 
                                 //복제품 검증
                                 var param = {
                                       "CODE_DATA":codeData,
                                       "TBCheckHstEntity":{
                                          "APP_ID":APP_ID,
                                          "DEVICE_ID":MEMBER_SEQ,
                                          "LAT":LAT,
                                          "LNG":LNG
                                       },
                                       "REG_USER":MEMBER_SEQ,
                                       "TBProductsBasEntity":{
                                          "PROD_ID":PROD_ID
                                       }
                                 }
                                 ajaxCallPost("/api/original/check/copy", param, 
                                    function(res){
                                       if(res.success){
                                          location.href="/original/auth/ok?auth_hist_seq="+res.data.TBCheckHst.auth_HIST_SEQ;
                                       }else{
                                          location.href="/original/auth/copy?code_data="+codeData+"&prod_id="+PROD_ID;
                                       }
                                    },function(){}
                                 );
                              }else{
                                 location.href="/original/auth/no?rstMsg="+scanArResultMsg;
                              }
                           },function(){
                              location.href="/original/auth/no?rstMsg="+scanArResultMsg;
                           }
                        );
                     }
                     
                     
                     
                     
                     
                  }else{
                     location.href="/original/auth/no?rstMsg="+scanArResultMsg;
                  }
               },function(){
                  location.href="/original/auth/no?rstMsg="+scanArResultMsg;
               }
            );
         }else{
            location.href="/original/auth/no?rstMsg="+rstMsg;
         }
      });
}
function BridgeOpenAr(memberSeq, imgUrl, videoUrl, lang){
   if (checkMobile() == ANDROID) { 
      window.label.BridgeOpenAr(memberSeq, imgUrl, videoUrl);
   } else if (checkMobile() == IOS) {
       //IOS 일때 처리
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeOpenAr", "memberSeq": memberSeq, "imgUrl":imgUrl, "videoUrl":videoUrl, "language":lang} );
   }
}
/**
 * 웹브라우저 오픈
 * 웹 > 앱
 * @param url
 * @returns
 */
//android



function checkMobile(){
 

   var mobile = (/iphone|ipad|ipod|android/i.test(navigator.userAgent.toLowerCase()));
   
   if (mobile) { 
      var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
 
      if ( varUA.indexOf(ANDROID) > -1) {
         return ANDROID;
      } else if ( varUA.indexOf("iphone") > -1||varUA.indexOf("ipad") > -1||varUA.indexOf("ipod") > -1 ) {
         //IOS
         return IOS;
      }
   }
}


function BridgeOpenWebBrowser(url){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeOpenWebBrowser(url);
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeOpenWebBrowser", "url": url} );
   }
}


/**
 * 뒤로가기
 * 앱 > 웹
 * @param url
 * @returns
 */
function BridgeBackBtn(){
   
   if(document.location.pathname == '/app/index'){
      
      
      if($(".article-contents").css("left") == '0px'){
         $(".article-background").removeClass("open");
         $(".article-contents").removeClass("open");
      }else{
         popupFunc.openPopupAlert2(alarm, closeText, ok, cancel, 
                  function(){
                  BridgeExitApp();
                  },
                  function(){
                  }
               )
      }
      
   }else{
      history.back(-1);
   }
}

/**
 * 자동로그인 여부
 * @returns
 */
function BridgeGetIsAutoLogin(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeGetIsAutoLogin();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeGetIsAutoLogin"} );
   }
}


/**
 * 자동로그인 여부콜백
 * @returns
 */

function BridgeGetIsAutoLoginRst(isAutoLogin){ //Y or N
   alert(isAutoLogin)
   if(isAutoLogin == 'Y'){
      //BridgeGetPhone()
   }
}

/**
 * 핸드폰 요청
 * @returns
 */
function BridgeGetPhone(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeGetPhone();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeGetPhone"} );
   }
}

/**
 * 핸드폰 요청 콜백
 * @param phone
 * @returns
 */
function BridgeSetPhone(콜){
   var param = {
         "phone":phone
   }
   ajaxCallPost("/api/auto/login", param, 
      function(res){
         settingSession();
      },
      function(e){
      }
   );
}

/**
 * 자동로그인 여부 전달
 * @param isAutoLogin
 * @returns
 */
function BridgeSetIsAutoLogin(isAutoLogin){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeSetIsAutoLogin(isAutoLogin);
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeSetIsAutoLogin", "isAutoLogin":isAutoLogin} );
   }
}

/**
 * 푸시토큰 가져오기
 * @returns
 */
function BridgeGetPushToken(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeGetPushToken();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeGetPushToken"} );
   }
}
/**
 * 푸시토큰 받기
 * @param pushToken
 * @returns
 */
function BridgeSetPushToken(pushToken){
}


/**
 * 앱에 계정 요청
 * guestPhone
 * memerPhone
 */
function BridgeUserLogin(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeUserLogin();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeUserLogin"} );
   }
}
/**
 * 앱에 계정 요청 콜백
 * @returns
 */
function BridgeUserLoginRst(phone, push_token){
   var param = {
         "phone":phone,
         "push_token":push_token
   }
   ajaxCallPost("/api/auto/login", param, 
      function(res){
         if(res.success){
            var resBe = res;
            
            /**
             * 최종로그인 정보 업데이트
             * @param e
             * @returns
             */
            param = {
               "member_seq":res.data.loginData.member_seq,
               "phone_type":checkMobile()
            }
            ajaxCallPost("/api/last/login/update", param, 
               function(res){
                  settingSession(resBe.data.loginData);
               },
               function(e){
               }
            );
            
            
            
            
         }else{
            BridgeCreateGuest(push_token);
         }
         
      },
      function(e){
      }
   );
}
/**
 * 비회원 계정 생성
 * @returns
 */
function BridgeCreateGuest(push_token){
   var param = {
         "push_token":push_token
   }
   ajaxCallPost("/api/join/guest", param, 
      function(res){
         if(res.success){
            BridgeSetUserLogin(res.data.loginVo.phone, "N")
         }else{
            alert("에러3")
         }
      },
      function(e){
      }
   );
}
/**
 * 계정 앱으로 전달
 * @returns
 */
function BridgeSetUserLogin(phone, isMember){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeSetUserLogin(phone, isMember);
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeSetUserLogin", "phone":phone, "isMember":isMember} );
   }
}
/**
 * 앱으로 전달 콜백
 * @returns
 */
function BridgeSetUserLoginRst(isMember){
   if(isMember == 'N'){
      BridgeUserLogin();
   }
}

/**
 * 로그아웃 계정삭제 / 회원계정 단말기에서 삭제
 * @returns
 */
function BridgeLogout(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeLogout();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeLogout"} );
   }
}

/**
 * 팝업 오픈
 * @returns
 */
function BridgeOpenWebPopup(title, content){
   popupFunc.openPopupAlert(title, content, function(){
   })
}

/**
 * 튜토리얼 이미지 열기
 * @returns
 */
function BridgeOpenTutorial(lang){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeOpenTutorial();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeOpenTutorial","language":lang} );
   }
}


/**
 * 앱종료
 * @returns
 */
function BridgeExitApp(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeExitApp();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeExitApp"} );
   }
}

/**
 * 소리권한 브릿지
 * @returns
 */
function BridgeSound(is_data){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeSound(is_data);
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeSound", "is_data":is_data} );
   }
}

/**
 * 소리권한 브릿지요청
 * @returns
 */
function BridgeSoundYn(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeSoundYn();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeSoundYn"} );
   }
}
function BridgeSoundYnRst(is_data){
   commonSettingData(memberSeq, 'is_sound', is_data);
}

/**
 * gps 브릿지
 * @returns
 */
function BridgeGps(is_data){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeGps(is_data);
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeGps", "is_data":is_data} );
   }
}

/**
 * gps 브릿지요청
 * @returns
 */
function BridgeGpsYn(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeGpsYn();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeGpsYn"} );
   }
}
function BridgeGpsYnRst(is_data){
   commonSettingData(memberSeq, 'is_gps', is_data);
}

/**
 * push 브릿지
 * @returns
 */
function BridgePush(is_data){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgePush(is_data);
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgePush", "is_data":is_data} );
   }
}

/**
 * push 브릿지요청
 * @returns
 */
function BridgePushYn(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgePushYn();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgePushYn"} );
   }
}
function BridgePushYnRst(is_data){
   commonSettingData(memberSeq, 'is_alarm', is_data);
}

/**
 * 자동로그인 브릿지
 * @returns
 */
function BridgeAutoLogin(is_data){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeAutoLogin(is_data);
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeAutoLogin", "is_data":is_data} );
   }
}

/**
 * 자동로그인 브릿지요청
 * @returns
 */
function BridgeAutoLoginYn(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeAutoLoginYn();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeAutoLoginYn"} );
   }
}
function BridgeAutoLoginYnRst(is_data){
   commonSettingData(memberSeq, 'is_login', is_data);
}

/**
 * 앱자동 업데이트 브릿지
 * @returns
 */
function BridgeAutoUpdate(is_data){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeAutoUpdate(is_data);
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeAutoUpdate", "is_data":is_data} );
   }
}

/**
 * 앱자동 업데이트 브릿지요청
 * @returns
 */
function BridgeAutoUpdateYn(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeAutoUpdateYn();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeAutoUpdateYn"} );
   }
}
function BridgeAutoUpdateYnRst(is_data){
   commonSettingData(memberSeq, 'is_labelupdate', is_data);
}

/**
 * 메인에서 권한 앱 호출해서 db의 값 최신화 함수
 * @param memberSeq
 * @param data_column
 * @param is_data
 * @returns
 */
function commonSettingData(memberSeq, data_column, is_data){

   var param = {
      "member_seq":memberSeq,
      "column_name":data_column,
      "is_target" : is_data
   }
   
   ajaxCallPost("/api/member/setting", param, 
         function(res){
            if(res.success){
            }
         },
         function(e){
         }
      );
}
/**
 * 앱버전 브릿지요청
 * @returns
 */
function BridgeAppVersion(){
   var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
   if (checkMobile() == ANDROID) { 
      window.label.BridgeAppVersion();
   } else if (checkMobile() == IOS) {
      webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeAppVersion"} );
   }
}
function BridgeAppVersionRst(version){
   $("#appVersion").text(version);
}

/**
 * 앱설정열기
 * @returns
 */
function BridgeOpenSetting(){
	var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
	if (checkMobile() == ANDROID) { 
		window.label.BridgeOpenSetting();
	} else if (checkMobile() == IOS) {
		webkit.messageHandlers.callbackHandler.postMessage( {"command": "BridgeOpenSetting"} );
	}
}