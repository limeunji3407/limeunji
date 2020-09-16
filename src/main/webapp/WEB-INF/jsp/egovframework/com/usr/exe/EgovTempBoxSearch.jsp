<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- 검색설정 -->
	<div class="tabmenu_search">
		<!--제목  셀렉박스-->
		<select name="searchKey" class="select_blank_lightblue width-120px" style="margin-right:10px">
			<option value="title" selected>제목</option>
			<option value="subject">내용</option>
		</select>

		<!--검색-->
		<div class="inline-block width-250px">
			<input type="text" name="searchValue" placeholder="" class="input_blank width-100 padding-left-20 border-box border-8bc5ff" />
		</div>
		<a class="width-40px height-40px line-height-40px margin-left-5 font-14px border-radius-5 background-8bc5ff font-fff text-center font-053c72 box-shadow-blue search-btn">검색</a>
	</div>
	<!-- //검색설정 -->