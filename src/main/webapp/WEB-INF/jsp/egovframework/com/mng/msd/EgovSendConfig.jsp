<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="g_refuse_use" var="g_refuse_use" /> 
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
			<!--contents-->
			<div class="con-inner">
				<!--타이틀-->
				<h1 class="con-title">
					<ul>
						<li>전송기준설정</li>
						<li class="icon_home"></li>
						<li><span class="dot"></span>시스템관리</li>
						<li><span class="dot"></span>전송기준설정</li>
					</ul>
				</h1> 

				<div class="width-1350px height-710px margin-bottom-100">
					<ul class="standard_tabmenu">
						<li id="tab-1" class="btnCon">						
<c:import url="/mng/setline.do"></c:import> 
						</li>
						<li id="tab-2" class="btnCon">					
<c:import url="/mng/setrole.do"></c:import> 
						</li>
						
						
		<c:if test="${g_refuse_use eq 'Y'}" >	
						<li id="tab-3" class="btnCon">					
<c:import url="/mng/receiptrefusal.do"></c:import>
						</li>
		</c:if>				
						
						
					</ul>
				</div>
			</div>

		 <!-- popup 주소록복사 -->
         <div class="pop_wrap pop_address width-730px" style="background:transparent;">
			<div class="width-100">
				<ul class="pop_tabmenu_excel">
					<li id="pop_tab_1" class="btnCon">
						<input type="radio" checked name="pop_tabmenu_excel" id="pop_tabmenu_1">
						<label for="pop_tabmenu_1">주소록 불러오기</label>
						<div class="pop_tabCon">
							<div class="width-100 margin-auto text-center font-16px font-000 padding-20">
							<table cellpadding="0" cellspacing="0" border="0" class="width-100 height-210px margin-auto">
								<tr>
									<td class="width-330px height-200px vertical-top padding-bottom-40">
										<h5 class="font-18px font-normal font-174962 text-left">가져올 그룹/주소 선택</h2>
										<ul class="tabmenu_small">
											<li id="small_tab_1" class="btnCon">
												<input type="radio" checked name="tabmenu_small" id="tabmenu_small_1">
												<label for="tabmenu_small_1">부서</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30">
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_2" class="btnCon">
												<input type="radio" name="tabmenu_small" id="tabmenu_small_2">
												<label for="tabmenu_small_2">직원</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30">
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
														</ul>
													</div>
												</div>
											</li>
											<li id="small_tab_3" class="btnCon">
												<input type="radio" name="tabmenu_small" id="tabmenu_small_3">
												<label for="tabmenu_small_3">공유</label>
												<div class="small_tabCon">
													<div class="width-330px height-100 hidden scroll-y font-12px">
														<ul class="width-100 li-h30">
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
															<li>
																<div class="checkbox-small_2">
																	<input type="checkbox" id="check-1" name="체크" />
																	<label for="check-1"></label>
																</div> 
																<span>김단문<span>01012345678</span></span>
															</li>
														</ul>
													</div>
												</div>
											</li>
										</ul>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="icon_group">그룹</a>
									</td>
									<td rowspan="2" class="vertical-top width-220px">
										<h5 class="font-18px font-normal font-174962 text-left">개인주소록</h2>
										<div class="width-230px hidden scroll-y font-12px border-radius-5 border-e8e8e8" style="height:540px">
											<ul class="width-100 li-h30">
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
											</ul>
										</div>
									</td>
								</tr>
								<tr>
									<td class="width-330px height-220px vertical-top ">
										<h5 class="font-18px font-normal font-174962 text-left">선택그룹 상세보기</h2>
										<div class="width-330px height-220px hidden scroll-y font-12px border-radius-5 border-e8e8e8">
											<ul class="width-100 li-h30">
												<li class="search">
													<select class="select_white_small width-70px">
														<option>이름</option>
													</select>
													<input type="text" name="" />
													<a href="#">입력</a>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
												<li>
													<div class="checkbox-small_2">
														<input type="checkbox" id="check-1" name="체크" />
														<label for="check-1"></label>
													</div> 
													<span>김단문<span>01012345678</span></span>
												</li>
											</ul>
										</div>
									</td>
									<td class="width-100px height-240px vertical-middle text-center">
										<a class="icon_each">개별</a>
									</td>
								</tr>
							</table>
							<div class="margin-top-5 text-right">
								<a class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest ">선택삭제</a>
								<a class="width-80px height-24px line-height-24px text-center border-radius-5 background-053c72 font-12px font-fff box-shadow-smallest margin-left-5">전체삭제</a>
							</div>
							</div>
							<!--버튼-->
							<div class="pop_btn-big margin-auto text-center margin-bottom-10">
								<a class="pop_close margin-right-30 font-053c72 font-bold width-230px background-8bc5ff box-shadow">복사하기</a>
								<a class="pop_close background-efefef width-70px font-053c72 font-normal">취소</a>
							</div>
						</div>
					</li>
				</ul>
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
