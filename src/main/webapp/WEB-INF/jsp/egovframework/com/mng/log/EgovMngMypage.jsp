<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_admin_checkIp" var="g_admin_checkIp" /> 
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>iGOV SMS SYSTEM</title>
</head>
<body>

<script type="text/javascript" language="javascript" defer="defer"> 

/* 파슬리추가 */
$(document).ready(function(){ 

    $('.bs-callout-info').toggleClass('hidden', true);
    $('.bs-callout-warning').toggleClass('hidden', true);
   
});   


function validateForm() {
	
	$('#myPageUpdate-form').parsley().validate();
    if (!$('#myPageUpdate-form').parsley().isValid()) {
    	return;
    }
    
	var user_id = $("#user_id").val(); //
	var user_pw = $("#password").val(); //text
	var newPw = $("#newpassword").val();
	var user_name = $("#user_name").val(); //text
	var cellphone = $("#cellphone1 option:selected").val()+$("#cellphone2").val()+$("#cellphone3").val(); //text
	var ip = $("#ip").val();
	
	//alert(reg_user_name);
	var obj = {
			"emplyrId": user_id,
           	"password": user_pw,
           	"newPw": newPw,
           	"emplyrNm": user_name,
           	"moblphonNo": cellphone,
           	"ip": ip
	};
	
	alert(JSON.stringify(obj));
   	$.ajax({
       	url: "<c:url value='/usr/updateUser.do' />",
       	type: "POST",
           data: obj,
           dataType: "json",
           beforeSend:function(){
               $('.wrap-loading').removeClass('display-none');
       		$('#newstaffbtn').attr('disabled', false);
           },
		complete:function(){
               $('.wrap-loading').addClass('display-none');
       		$('#newstaffbtn').attr('disabled', false);
        },
       	success: function(jsondata){  
     	   
            alert(jsondata["data"]);
            
            if(jsondata["data"]==0){
                //로딩
                toastr.success("성공적으로 수정 되었습니다.");
                $('#newstaffbtn').attr('disabled', false);
           		//close popup
           		location.href  ="/mng/mypage"
          	  
            }else if(jsondata["data"]==2){
          	  alert("현재 패스워드가 틀렸습니다.");
            }else{
          	  alert("양식을 다시 확인하길 바랍니다.");
            }
       	},
       	error: function(request,status,error){
       		  
       		alert("code:" + request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
           	$('#result').text(jsondata);
           	//alert("serialize err");
       		$('#newstaffbtn').attr('disabled', false);
       	}
   	});
}
</script>
         <!--contents-->
         <div class="con-inner">
            <!--타이틀-->
            <h1 class="con-title">
               <ul>
                  <li>마이페이지</li>
                  <li class="icon_home"></li>
                  <li><span class="dot"></span>마이페이지</li>
               </ul>
            </h1>
      <div id="result"></div>
            <!-- 파슬리 추가 -->
      <!-- <div class="bs-callout bs-callout-warning hidden">
        <h4>미완성!</h4>
        <p>이 양식은 유효하지 않은 것 같습니다 :( :(</p>
      </div>
      
      <div class="bs-callout bs-callout-info hidden">
        <h4>완성!</h4>
        <p>입력정보가 올바릅니다</p>
      </div> -->
      <!-- 파슬리추가 끝 -->
            <!-- 입력폼-->
            <form id="myPageUpdate-form" data-parsley-validate="">
            <div class="margin-auto margin-top-30 margin-bottom-100 width-730px  padding-rl-65 padding-tb-25 background-f7fafc border-box box-shadow">
               <table class="width-100">
                  <tr>
                     <th class="width-125px">아이디</th>
                     <td><input type="text" id="user_id" name="" placeholder="아이디를 입력해주세요." value="${ EmplurId }" class="width-260px padding-left-20 border-box margin-right-10"  readonly/></td>
                  </tr>
                   <tr>
                     <th>현재 패스워드</th>
                     <td><input type="text" id="password" name="" placeholder="비밀번호를 입력해주세요." data-parsley-required="true" class="width-260px padding-left-20 border-box margin-right-10" /></td>
                  </tr>
                   <tr>
                     <th>새 패스워드</th>
                     <td><input type="text" id="newpassword" name="" id="newpassword1"  placeholder="비밀번호를 입력해주세요." class="width-260px padding-left-20 border-box margin-right-10" /><span class="font-12px inline-block">(영문, 숫자, 특수문자 조합 8~16자)</span></td>
                  </tr>
                   <tr>
                     <th>새 패스워드 확인</th>
                     <td><input type="text" name="" id="newpassword2" placeholder="비밀번호를 다시 입력해주세요." class="width-260px padding-left-20 border-box" /></td>
                  </tr>
                   <tr>
                     <th>이름</th>
                     <td><input type="text" id="user_name" name="user_name" placeholder="이름을 입력해주세요." value="${ EmplyrNm }" class="width-260px padding-left-20 border-box" readonly /></td>
                  </tr>
                   
                   <tr>
                     <th>휴대전화</th>
                     <td>
                        <select title="" id="cellphone1" name="cellphone1" value="${ cellphone1 }" class="select_white width-90px inline-block " required="" data-parsley-required="true" data-parsley-trigger="change">
                           <option>번호를 선택해주세요</option>
                           <option <c:if test="${cellphone1 eq '010'}">selected</c:if>>010</option>
                           <option <c:if test="${cellphone1 eq '011'}">selected</c:if>>011</option>
                           <option <c:if test="${cellphone1 eq '016'}">selected</c:if>>016</option>
                        </select>
                        <input type="text" id="cellphone2" name="cellphone2" placeholder="" value="${ cellphone2 }" class="inline-block width-90px padding-left-20 border-box margin-left-10 margin-right-10" data-parsley-type="digits" data-parsley-maxlength="4"  required="" data-parsley-required="true" data-parsley-trigger="change" />
                        <input type="text" id="cellphone3" name="cellphone3" placeholder="" value="${ cellphone3 }" class="inline-block width-90px padding-left-20 border-box" data-parsley-type="digits" data-parsley-maxlength="4" required="" data-parsley-required="true" data-parsley-trigger="change" />
                     </td>
                  </tr>
                   <c:if test="${g_admin_checkIp eq 'Y'}" >
                   <tr>
                     <th>접속허용IP</th>
                     <td><input type="text" id="ip" name="" placeholder="두개 이상의 ip사용시 , 로 구분해주세요." value="${ ip }" class="width-300px padding-left-20 border-box" /></td>
                  </tr>
                  </c:if>
               </table>

               <!--버튼-->
               <div class="btn-center">
                  <!-- <a class="background-8bc5ff font-fff" onClick="javascript:document.myForm.submit();" id="upBtn"><in저장</a> -->
                  <input class="background-8bc5ff font-fff" type="submit" onclick="validateForm()" value="저장"></input>
                  <a class="background-efefef font-6f6f6f">취소</a>
               </div>
            </div>
            </form>
         </div>
      </div>

</body>
</html>