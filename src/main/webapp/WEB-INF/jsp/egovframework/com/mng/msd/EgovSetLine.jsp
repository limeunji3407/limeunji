<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>iGOV SMS SYSTEM</title>
<script type="text/javaScript" language="javascript" defer="defer"> 
function showLoadingBar() { var maskHeight = $(document).height(); var maskWidth = window.document.body.clientWidth; var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>"; var loadingImg = ''; loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:none; z-index:10000;'>"; loadingImg += " <img src='./img/loading.gif'/>"; loadingImg += "</div>"; $('body').append(mask).append(loadingImg); $('#mask').css({ 'width' : maskWidth , 'height': maskHeight , 'opacity' : '0.3' }); $('#mask').show(); $('#loadingImg').show(); }
function hideLoadingBar() { $('#mask, #loadingImg').hide(); $('#mask, #loadingImg').remove(); }

$(document).ready(function() {
   /* JSON.stringify(form), */
   $('#msgbtn').on('click', function(){ 
      
      $('#msgbtn').attr('disabled', true);
      var sms = $("#sms").val();
      var lms = $("#lms").val();
      var mms = $("#mms").val();
      var noti = $("#noti").val();
      var renoti = $("#renoti").val();
      var frit = $("#frit").val();
      var refri = $("#refri").val();
      var obj = {
               'sms': sms,
               'lms': lms,
               'mms': mms,
               'noti': noti,
               'renoti':renoti,
               'frit':frit,
               'refri':refri
            }
      
      console.log(obj);
    
        $.ajax({
           url: "<c:url value='/mng/insLineCfgStr.do' />",
           type: "POST",
            data: obj,
            dataType: "json",
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
              $('#msgbtn').attr('disabled', false);
            },
         complete:function(){
                $('.wrap-loading').addClass('display-none');
              $('#msgbtn').attr('disabled', false);
            },
           success: function(jsondata){

                   //개별데이타처리                   
                   $.each(jsondata["messageLineConfigVO"], function (index, item) {
                      $("input[type=text][name=" + index + "]").val(item);
                      //var result = ''; 
                      //result += index +' : ' + item; 
                      //$("#result").append(result); 
               });
                   //로딩
                   toastr.success('성공적으로 수정되었습니다'); 

              $('#msgbtn').attr('disabled', false);
               
           },
           error: function(request,status,error){
              console.log("[ajax error]");
              console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
               $('#result').text(jsondata);
               //alert("serialize err");
              $('#msgbtn').attr('disabled', false);
           }
       });
   });
   
   $("#mgovPrice").hide();
   $("#iheartPrice").show();
   
   $('#priceSel').change(function(){
      var state = $('#priceSel option:selected').val();
      if(state == "0"){
         $("#mgovPrice").show();
         $("#iheartPrice").hide();
      }else{
         $("#mgovPrice").hide();
         $("#iheartPrice").show();
      }
   });
   
   $("input").on("propertychange change keyup paste input", function() {
       var currentVal = $(this).val();
       if(currentVal == oldVal) {
           return;
       }
    
       oldVal = currentVal;
       alert("changed!");
   });
    

   $('#priceBtn').on('click', function(){  
      
      $('#priceBtn').attr('disabled', true);      
      
       var psms = $("#psms").val();   
       var plms = $("#plms").val();   
       var pmms = $("#pmms").val();   
       var pnotice = $("#pnotice").val();   
       var pfriend_txt = $("#pfriend_txt").val();   
       var pfriend_img = $("#pfriend_img").val();   
       var psms_g = $("#psms_g").val();
       var plms_g = $("#plms_g").val();
       var pmms_g = $("#pmms_g").val();
       
       if(psms==''){
          psms = $("#psmsm").val()
       }
       
      if(plms==''){
         plms = $("#plmsm").val();
       }
       
      if(pmms==''){
         pmms = $("#pmmsm").val();
      }
      
      if(pnotice==''){
         pnotice = $("#pnoticem").val();   
      }
      
      if(pfriend_txt==''){
         pfriend_txt = $("#pfriend_txtm").val();   
      }
      
      if(pfriend_img==''){
          pfriend_img = $("#pfriend_imgm").val();
      }
      
      if(psms_g==''){
         psms_g = $("#psms_gm").val();
      }
      
      if(plms_g==''){
         plms_g = $("#plms_gm").val();
      }
      
      if(pmms_g==''){
         pmms_g = $("#pmms_gm").val();
      }
      
      var obj = {
         "sms": Number(psms), 
         "lms" : Number(plms),
         "mms" : Number(pmms),
         "notice" : Number(pnotice),
         "friend_txt" : Number(pfriend_txt),
         "friend_img" : Number(pfriend_img),
         "sms_g" : Number(psms_g),
         "lms_g" : Number(plms_g),
         "mms_g" : Number(pmms_g) 
      };
        
      console.log(JSON.stringify(obj));
      //return;
      $.ajax({
           url: "<c:url value='/mng/insLinePriceStr.do' />",
           type: "POST",
            data: obj,
            dataType: "json",
            success: function(jsondata){
               console.log(jsondata["data"]);
               
               if(jsondata["data"]==0){
                   //로딩
                   toastr.success("성공적으로 변경 되었습니다.");
                  
               }else{
                  console.log("변경 할 수 없습니다.");
               }
           },
           error: function(request,status,error){
              console.log("[ajax error]");
              console.log("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           }
       });
   });
});
</script>
</head>
<body>
<div class="wrap-loading display-none">
    <div><img src="<c:url value='/images/egovframework/com/loading.gif' />" /></div>
</div>  
 
   
                     <input type="radio" checked name="standard_tabmenu" id="tabmenu-1">
                     <label for="tabmenu-1">발송라인 및 단가설정</label>
                     <div class="tabCon">
                        <div class="width-100 padding-top-60 margin-bottom-100">
                           <div class="width-100  padding-rl-100 padding-tb-40 background-f7fafc border-box box-shadow">
                              <h3 class="form_tit">발송라인 선택</h3>
                              <div id="result"></div>
                              <div id="after"></div>
                        <div class="container" style="padding-top: 50px;"> 
                        
 

                              <table class="width-100 margin-top-20 margin-bottom-40">
                                 <colgroup>
                                    <col style="width:25%" />
                                    <col style="width:25%" />
                                    <col style="width:25%" />
                                    <col style="width:25%" />
                                 </colgroup>
                                 <tr>
                                    <th class="text-center">유형</th>
                                    <th class="text-center">현재설정</th>
                                    <th class="text-center">변경설정</th>
                                    <!-- <th class="text-center"></th> -->
                                 </tr>
                                 <tr>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="단문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="sms" placeholder="" value="<c:out value="${sms}"/>" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <select title="" class="select_white width-100" id="sms">
                                          <option>M-GOV</option>
                                          <option>I-Heart</option>
                                       </select>
                                    </td>
                                    <!-- <td></td> -->
                                 </tr>
                                 <tr>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="lms" placeholder="" value="<c:out value="${lms}"/>" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <select title="" class="select_white width-100" id="lms">
                                          <option>M-GOV</option>
                                          <option>I-Heart</option>
                                       </select>
                                    </td>
                                    <!-- <td></td> -->
                                 </tr>
                                 <tr>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="멀티" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="mms" placeholder="" value="<c:out value="${mms}"/>" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <select title="" class="select_white width-100" id="mms">
                                          <option>M-GOV</option>
                                          <option>I-Heart</option>
                                       </select>
                                    </td>
                                    <!-- <td></td> -->
                                 </tr>
                                 <tr>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="알림톡" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="noti" placeholder="" value="<c:out value="${noti}"/>" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <select title="" class="select_white width-100" id="noti">
                                          <option>I-Heart(알림톡)</option>
                                          <option>I-Heart(알림톡)</option>
                                       </select>
                                    </td>
                                    <!-- <td></td> -->
                                 </tr>
                                 <tr>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="알림톡 재전송" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="renoti" placeholder="" value="<c:out value="${renoti}"/>" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <select title="" class="select_white width-100" id="renoti">
                                          <option>I-Heart</option>
                                          <option>I-Heart(알림톡 재전송)</option>
                                       </select>
                                    </td>
                                    <!-- <td></td> -->
                                 </tr>
                                 <tr>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="친구톡" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="frit" placeholder="" value="<c:out value="${frit}"/>" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <select title="" class="select_white width-100" id="frit">
                                          <option>I-Heart</option>
                                          <option>I-Heart(친구톡)</option>
                                       </select>
                                    </td>
                                    <!-- <td></td> -->
                                 </tr>
                                 <tr>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="친구톡 재전송" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="refri" placeholder="" value="<c:out value="${refri}"/>" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <select title="" class="select_white width-100" id="refri">
                                          <option>I-Heart</option>
                                          <option>I-Heart(친구톡 재전송)</option>
                                       </select>
                                    </td>
                                    <!-- <td></td> -->
                                 </tr>
                              </table>


                              <!--버튼-->
                              <div class="btn-center">
                                 <a class="background-053c72 font-fff" id="msgbtn">저장</a>
                                 <!--a class="background-8bc5ff font-fff">취소</a-->
                              </div>
                              
                              </br></br>
                              
                              

                              <h3 class="form_tit">발송단가 입력</h3>
                              <table class="width-100 margin-top-20 margin-bottom-40">
                              <tr>
                              
                                    <td class="text-center vertical-center padding-right-10 border-box" >
                                       <span class="inline-block margin-bottom-5">라인선택</span><br>
                                       <select name="selectline" title="" class="select_white width-100" id="priceSel">
                                          <option value="1">I-Heart</option>
                                          <option value="0">M-GOV</option>
                                       </select>
                                    </td>
                              </tr>
                              </table>
                              <table class="width-100 margin-top-20 margin-bottom-40" id="iheartPrice">
                              <thead>
                                 <tr>
                                    <th class="text-center">유형</th>
                                    <th class="text-center">현재단가</th>
                                    <th class="text-center">변경단가</th>
                                 </tr>
                                 </thead>
                                 <tbody>
                                 <tr id="tsms">
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="단문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" id="psmsm" name="psms" placeholder="단가를 입력해주세요." value="${psms}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요." value="" id="psms" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 <tr id="tlms">
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" id="plmsm" name="plms" placeholder="단가를 입력해주세요." value="${plms}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요." value="" id="plms" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 <tr id="tmms">
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="멀티" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" id="pmmsm" name="pmms" placeholder="단가를 입력해주세요." value="${pmms}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요." value="" id="pmms"  class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 <tr id="tnotice">
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="알림톡" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" id="pnoticem" name="pnotice" placeholder="단가를 입력해주세요." value="${pnotice}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요." value="" id="pnotice" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 <tr id="tfriendtxt">
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="친구톡 텍스트" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" id="pfriend_txtm" name="pfriend_txt" placeholder="단가를 입력해주세요." value="${pfriend_txt}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요." value="" id="pfriend_txt" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 <tr id="tfriendimg">
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="친구톡 이미지" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" id="pfriend_imgm" name="pfriend_img" placeholder="단가를 입력해주세요." value="${pfriend_img}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요." value="" id="pfriend_img" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 </tbody>
                              </table>
                              <table class="width-100 margin-top-20 margin-bottom-40" id="mgovPrice">
                              <thead>
                                 <tr>
                                    <!-- <th class="text-center"></th> -->
                                    <th class="text-center" style="width:33%">유형</th>
                                    <th class="text-center" style="width:33%">현재단가</th>
                                    <th class="text-center" style="width:34%">변경단가</th>
                                 </tr>
                                 </thead>
                                 <tbody>
                                 <tr id="tsms_g">
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="단문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" id="psms_gm" name="psms_g" placeholder="단가를 입력해주세요." value="${psms_g}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요." value="" id="psms_g" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 <tr id="tlms_g">
                                    <td class="padding-right-10 border-box"><input readonly type="text" name="" placeholder="" value="장문" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input readonly type="text" id="plms_gm" name="plms_g" placeholder="단가를 입력해주세요." value="${plms_g}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요."  id="plms_g" value="" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 <tr id="tmms_g">
                                    <td class="padding-right-10 border-box"><input type="text" name="" placeholder="" value="멀티" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box"><input type="text" id="pmms_gm" name="pmms_g" placeholder="단가를 입력해주세요." value="${pmms_g}" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" /></td>
                                    <td class="padding-right-10 border-box">
                                       <input type="text" name="" placeholder="단가를 입력해주세요."  id="pmms_g" value="" class="width-100 height-50px line-height-50px border-radius-5 background-fff border-box text-center" />
                                    </td>
                                 </tr>
                                 </tbody>
                              </table>
                              <!--버튼-->
                              <div class="btn-center">
                                 <a class="background-053c72 font-fff" id="priceBtn">저장</a>
                                 <!--a class="background-8bc5ff font-fff">취소</a-->
                              </div>
                           </div>
                        </div>
                     </div>

       <!-- popup 엑셀업로드 -->
         <div class="pop_wrap pop_call_excel width-730px background-f7fafc border-radius-5">
         <div class="width-100 font-20px font-000 font-bold text-left margin-bottom-10 padding-bottom-10 border-bottom-e9eced">엑셀 업로드</div>
         <div class="width-100 margin-auto margin-top-20 margin-bottom-20 text-center font-16px font-000">
            <div class="filebox filebox_img bs3-primary text-left margin-bottom-20 padding-left-90">
               엑셀파일 찾기
               <input class="upload-name" value="" disabled="disabled" placeholder="선택된 파일 없음" />
               <label for="ex_filename">찾아보기</label> 
               <input type="file" id="ex_filename" class="upload-hidden" /> 
            </div>
            <ul class="pop_notice" style="padding-left:90px">
               <li>엑셀양식파일 : <a href="#">엑셀양식 다운로드</a></li>
               <li>최대 10만건 까지 등록할 수 있습니다.</li>
               <li>엑셀등록시 휴대폰 번호는 필수값입니다.</li>
               <li>휴대폰 번호는 반드시 0으로 시작해야 합니다.</li>
            </ul>
         </div>
         <!--버튼-->
         <div class="pop_btn-big margin-auto text-center margin-bottom-10">
            <a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">등록하기</a>
            <a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
         </div>
        </div>

</body>
</html>