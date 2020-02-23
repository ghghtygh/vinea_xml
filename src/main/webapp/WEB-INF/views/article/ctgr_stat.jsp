<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>현황분석 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- JQUERY, JAVASCRIPT -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!--  CSS -->
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link href="/resources/css/_bootswatch.scss" rel="stylesheet">
<link href="/resources/css/_variables.scss" rel="stylesheet">

<!-- Chart.js 사용(라인, 바, 플롯, 레이더 등 사용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
<script>
   /** JQUERY 사용 **/
   
   
   $(document).ready(function() {
      
      $("#${tab_option}").addClass("active");
      $("a[name='${tab_option}']").addClass("active");
      $('#ctgrselect option[value="${ctgr_option}"]').attr("selected",true);
      $('#cnt2 option[value="${sort_option}"]').attr("selected",true);
      
      
      createChart();
      
      $('a[data-toggle="tab"]').on('hidden.bs.tab', function(e){
         
         $("#div_canvas_ctgr").html("");
         
         $("#div_canvas_ctgr").html("<canvas id='canvas_ctgr'></canvas>");
         
         createChart();
         
      });
      
      var th_option_html = $('#cnt2 option[value="${sort_option}"]').html();
      //console.log(th_option_html);
      
      if(th_option_html=="분야명"){
         $("#th_option").html("논문");
      }else{
         $("#th_option").html(th_option_html);
      }
      /** 연구분야 옵션 선택 **/
      $('#ctgrselect').change(function() {
         
         
         //console.log($(".tab-pane.active").attr('id'));
         
         var formObj = $("#frm");
         
         var input_tab = document.createElement("input");
         $(input_tab).attr("type","hidden");
         $(input_tab).attr("name","tab_option");
         $(input_tab).attr("value",$(".tab-pane.active").attr('id'));
         formObj.append(input_tab);
         
         formObj.attr("action", "/article/ctgrstat");
         formObj.attr("method", "get");
         formObj.submit();
      });

      /** 연구분야별 데이터 통계 정렬 기준 **/
      $('#cnt2').change(function() {
         
         var formObj = $("#frm");
         
         var input_tab = document.createElement("input");
         $(input_tab).attr("type","hidden");
         $(input_tab).attr("name","tab_option");
         $(input_tab).attr("value",$(".tab-pane.active").attr('id'));
         formObj.append(input_tab);
         
         formObj.attr("action", "/article/ctgrstat");
         formObj.attr("method", "get");
         formObj.submit();
         
      });
      

   });
   
   /** 페이지 이동  **/
   function fn_paging(nowPage) {

      var formObj = $("#frm");
      
      var input_page = document.createElement("input");
      $(input_page).attr("type","hidden");
      $(input_page).attr("name","page");
      $(input_page).attr("value",nowPage);
      formObj.append(input_page);
      
      formObj.attr("action", "/article/ctgrstat");
      formObj.attr("method", "get");
      formObj.submit();

   }
</script>
<style>
/** 연구분야별 데이터 통계 연구분야 선택 SelectBox **/
#ctgrselect {
   position: relative;
   width: 250px;
   border: 1px solid #999;
   z-index
   =1;
}
/** 연구분야별 데이터 통계 정렬기준 SelectBox **/
#cnt2 {
   position: relative;
   width: 170px;
   border: 1px solid #999;
   z-index
   =1;
}
/** 주제별 상위 통계 분류기준 SelectBox **/
#cnt3 {
   position: relative;
   width: 170px;
   border: 1px solid #999;
   z-index
   =1;
}
/** 주제별 상위통계 연구분야 선택 SelectBox **/
#ctgrselect2 {
   position: relative;
   width: 250px;
   border: 1px solid #999;
   z-index
   =1;
}
/** 처음 들어갔을 때, 표시 되지 않는 layer **/
.layer2, .artiStat, .jrnlStat, .refrStat {
   display: none;
}

#section, #article, #aside {
   display: block;
   width: 400px;
   text-align: left;
}

#section {
   float: left;
   width: 280px;
   height: 60px;
}

#article {
   width: 500px;
}

#aside {
   float: left;
   margin-top: 20px;
   margin-left: 300px;
   width: 800px;
   height: 450px;
}
</style>
</head>
<body>
   <form id="frm">
      <div class="wrapper d-flex align-items-stretch">
         <!-- 전체 메뉴 사이드바 -->
         <nav id="sidebar">
            <div class="p-4 pt-5">
               <a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
               <ul class="list-unstyled components mb-5">
                  <li><a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">메인</a>
                     <ul class="collapse list-unstyled" id="homeSubmenu">
                        <li><a href="/article">논문보기</a></li>
                     </ul></li>
                  <!-- 분야별 현황 페이지에서는 '현황>분야별 현황'을 선택상태로 둠 -->
                  <li class="active"><a href="#pageSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">현황</a>
                     <ul class="list-unstyled collapse show in" id="pageSubmenu" aria-expanded="true">
                        <li><a href="/article/yearstat">연도별 현황</a></li>
                        <li><a href="/article/orgnstat">소속기관별 현황</a></li>
                        <li class="active"><a href="/article/ctgrstat">분야별 현황</a></li>
                        <li><a href="/article/kwrdstat">키워드 현황</a></li>
                     </ul></li>
               </ul>
               <div class="footer">
                  <p>
                     <script>
                     document.write(new Date().getFullYear());
                  </script>
                     About XML Parsing <i class="icon-heart" aria-hidden="true"></i>
                  </p>
                  <p>
                     made with by JuHyeon&Minjin <a href="https://github.com/ghghtygh/vinea_xml.git" style="font-size: 12px" target="_blank"> https://github.com/ghghtygh/vinea_xml.git </a>
               </div>
            </div>
         </nav>
         <!-- 메뉴에서 분야별 현황 눌렀을때 결과 페이지  -->
         <div id="content" class="p-4 p-md-5">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
               <div class="container-fluid">
                  <button type="button" id="sidebarCollapse" class="btn btn-primary">
                     <i class="fa fa-bars"></i> <span class="sr-only">Toggle Menu</span>
                  </button>
                  <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                     <i class="fa fa-bars"></i>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarSupportedContent">
                     <ul class="nav navbar-nav ml-auto">
                        <li class="nav-item active"><a class="nav-link" href="/article">Home</a></li>
                     </ul>
                  </div>
               </div>
            </nav>
            <section>
               <article>
                  <!-- tab 정의 -->
                  <ul class="nav nav-tabs">
                     <li class="nav-item"><a class="nav-link" href="#ctgr1" name="ctgr1" data-toggle="tab">연구분야별 통계</a></li>
                     <li class="nav-item"><a class="nav-link" href="#ctgr2" name="ctgr2" data-toggle="tab">연구분야별 상위통계</a></li>
                  </ul>
                  <div class="tab-content">
                     <p style="font-size: 20px; font-weight: bold; color: #000069">연구분야별 데이터 통계</p>
                     <div class="row">
                        <div class="col-lg-12">
                           <ol class="breadcrumb">
                              <!-- 연구분야별로 검색 -->
                              <li class="breadcrumb-item">
                                 <p style="font-size: 15px; font-weight: bold; margin-right: 10px; margin-left: 15px">연구분야</p>
                              </li>
                              <select class="form-control" id="ctgrselect" name="ctgr_option">
                                 <option value="1">전체</option>
                                 <option value="2">Science & Technology</option>
                                 <option value="3">Arts & Humanities</option>
                                 <option value="4">Social Sciences</option>
                              </select>
                              <!-- 정렬 기준 선택 -->
                              <li class="breadcrumb-item">
                                 <p style="font-size: 15px; font-weight: bold; margin-left: 20px; margin-right: 10px;">정렬</p>
                              </li>
                              <select class="form-control" name="sort_option" id="cnt2">
                                 <option value="1">분야명</option>
                                 <option value="2">저자</option>
                                 <option value="3">논문</option>
                                 <option value="4">학술지</option>
                                 <option value="5">참고문헌</option>
                              </select>
                              <p style="margin-left: 15px"></p>
                              <!-- <button class="btn btn-primary" type="button">검색</button>
                                  -->
                           </ol>
                        </div>
                     </div>
                     <!-- 첫번째 tab에 들어갈 내용(시작) -->
                     <!-- tab 정의 부분에서의 href 속성과 동일하게 id를 각각 지정 -->
                     <div class="tab-pane" id="ctgr1">
                        <!-- 연구분야별 데이터 통계 : 테이블 -->
                        <div id="ctgr_stat1" style="margin-top: 20px">

                           <!-- 연구분야별 데이터 통계: 전체 -->
                           <div class="row">
                              <div class="col-lg-12">
                                 <div class="layer1">
                                    <table style="text-align: center;" class="table table-hover">
                                       <thead>
                                       <colgroup>
                                          <col width="10%" />

                                          <col width="20%" />
                                          <col width="*" />

                                          <col width="10%" />
                                          <col width="10%" />
                                          <col width="10%" />
                                          <col width="10%" />
                                       </colgroup>
                                       </thead>
                                       <tbody>
                                          <!-- 전체 분야별 데이터 통계 들어갈 부분 -->
                                          <th style="border-top: 2px solid #000069">순번</th>
                                          <th style="border-top: 2px solid #000069; text-align: left;">분야명</th>
                                          <th style="border-top: 2px solid #000069; text-align: left;">주제명</th>
                                          <th style="border-top: 2px solid #000069">저자 수</th>
                                          <th style="border-top: 2px solid #000069">논문 수</th>
                                          <th style="border-top: 2px solid #000069">학술지 수</th>
                                          <th style="border-top: 2px solid #000069">참고문헌 수</th>

                                          <!-- 데이터 -->
                                          <c:choose>
                                             <c:when test="${not empty ctgrList}">
                                                <c:forEach items="${ctgrList }" var="vo" varStatus="g">
                                                   <tr>
                                                      <td style="border-top: 1px solid #b4b4b4">${vo.num}</td>
                                                      <td style="border-top: 1px solid #b4b4b4; text-align: left;">${vo.ctgr_nm}</td>
                                                      <td style="border-top: 1px solid #b4b4b4; text-align: left;">${vo.subj_nm}</td>
                                                      <td style="border-top: 1px solid #b4b4b4">${vo.auth_cnt}</td>
                                                      <td style="border-top: 1px solid #b4b4b4">${vo.arti_cnt}</td>
                                                      <td style="border-top: 1px solid #b4b4b4">${vo.jrnl_cnt}</td>
                                                      <td style="border-top: 1px solid #b4b4b4">${vo.refr_cnt}</td>
                                                      </td>
                                                </c:forEach>
                                             </c:when>
                                             <c:otherwise>
                                                <tr>
                                                   <td colspan="5" style="border-top: 1px solid #b4b4b4; border-bottom: 1px solid #b4b4b4; text-align: center">등록된 논문이 없습니다</td>
                                                </tr>
                                             </c:otherwise>
                                          </c:choose>

                                          <!-- 
                                       <tr>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">분야명 데이터</a>
                                          </td>
                                          <td style="border-top: 1px solid #b4b4b4">0</td>
                                          <td style="border-top: 1px solid #b4b4b4">0</td>
                                          <td style="border-top: 1px solid #b4b4b4">0</td>
                                          <td style="border-top: 1px solid #b4b4b4">0</td>
                                       </tr>
                                        -->
                                       </tbody>
                                    </table>
                                 </div>
                                 <!-- 연구분야별 데이터 통계: 분야별 -->
                                 <div class="layer2">
                                    <table style="text-align: center;" class="table table-hover">
                                       <tbody>
                                          <!-- 분야별 데이터 통계 들어갈 부분 -->
                                          <th style="border-top: 2px solid #000069">분야명</th>
                                          <th style="border-top: 2px solid #000069">주제명</th>
                                          <th style="border-top: 2px solid #000069">저자</th>
                                          <th style="border-top: 2px solid #000069">논문 수</th>
                                          <th style="border-top: 2px solid #000069">학술지</th>
                                          <th style="border-top: 2px solid #000069">참고문헌</th>
                                          <tr>
                                             <td style="border-top: 1px solid #b4b4b4">
                                                <a href="#">분야명 데이터</a>
                                             </td>
                                             <td style="border-top: 1px solid #b4b4b4">
                                                <a href="#">주제명 데이터</a>
                                             </td>
                                             <td style="border-top: 1px solid #b4b4b4">0</td>
                                             <td style="border-top: 1px solid #b4b4b4">0</td>
                                             <td style="border-top: 1px solid #b4b4b4">0</td>
                                             <td style="border-top: 1px solid #b4b4b4">0</td>
                                          </tr>
                                       </tbody>
                                    </table>
                                 </div>
                              </div>

                              <!-- 페이징 처리(시작) -->
                              <div style="width: 100%;">
                                 <div align="right" style="position: relative;">
                                    <div style="position: absolute; text-align: center; width: 100%;">
                                       <div class="btn-group mr-2">
                                          <c:choose>
                                             <c:when test="${pager.nowPage ne 1 }">
                                                <a href='#' class="btn btn-primary" onClick="fn_paging(1)">처음</a>
                                             </c:when>
                                             <c:otherwise>
                                                <a class="btn btn-primary disabled">처음</a>
                                             </c:otherwise>
                                          </c:choose>
                                          <c:choose>
                                             <c:when test="${pager.nowPage ne 1 }">
                                                <a href="#" class="btn btn-primary" onClick="fn_paging('${pager.prevPage}')">&laquo;</a>
                                             </c:when>
                                             <c:otherwise>
                                                <a class="btn btn-primary disabled">&laquo;</a>
                                             </c:otherwise>
                                          </c:choose>
                                          <c:forEach begin="${pager.startPage}" end="${pager.endPage}" var="pageNum">
                                             <c:choose>
                                                <c:when test="${pageNum eq pager.nowPage}">
                                                   <a href="#" class="btn btn-primary active" onClick="fn_paging('${pageNum}')">${pageNum }</a>
                                                </c:when>
                                                <c:otherwise>
                                                   <a href="#" class="btn btn-primary" onClick="fn_paging('${pageNum}')">${pageNum}</a>
                                                </c:otherwise>
                                             </c:choose>
                                          </c:forEach>
                                          <c:choose>
                                             <c:when test="${pager.nowPage ne pager.pageCnt && pager.pageCnt > 0 }">
                                                <a class="btn btn-primary" href="#" onClick="fn_paging('${pager.nextPage}')">&raquo;</a>
                                             </c:when>
                                             <c:otherwise>
                                                <a class="btn btn-primary disabled">&raquo;</a>
                                             </c:otherwise>
                                          </c:choose>
                                          <c:choose>
                                             <c:when test="${pager.nowPage ne pager.pageCnt }">

                                                <a class="btn btn-primary" href="#" onClick="fn_paging('${pager.pageCnt}')">끝</a>


                                             </c:when>
                                             <c:otherwise>

                                                <a class="btn btn-primary disabled">끝</a>

                                             </c:otherwise>
                                          </c:choose>

                                       </div>
                                    </div>
                                    <div>
                                       <div style="position: relative; float: right; z-index: 10;"></div>
                                    </div>
                                 </div>
                              </div>
                              <!-- / 페이징처리 -->



                           </div>
                        </div>
                     </div>
                     <!-- 첫번째 tab에 들어갈 내용(끝) -->
                     <!-- 두번째 tab에 들어갈 내용(시작) -->
                     <div class="tab-pane" id="ctgr2">
                        <!-- 연구분야의 주제별 상위 통계 : 테이블, 차트 -->
                        <!-- 연구분야의 주제별 상위 통계: 테이블 부분 -->
                        <!-- 저자수 통계 -->
                        <div class="row">
                           <div class="col-lg-5">
                              <table style="text-align: center;" class="table table-hover">
                                 <tbody>
                                    <th style="border-top: 2px solid #000069">분야명</th>
                                    <th style="border-top: 2px solid #000069">주제명</th>
                                    <th style="border-top: 2px solid #000069" id="th_option">저자</th>
                                    <c:choose>
                                       <c:when test="${not empty ctgrList}">
                                          <c:forEach items="${ctgrList }" var="vo" varStatus="g" end="10">
                                             <tr>

                                                <td style="border-top: 1px solid #b4b4b4">${vo.ctgr_nm}</td>
                                                <td style="border-top: 1px solid #b4b4b4">${vo.subj_nm }</td>
                                                <td style="border-top: 1px solid #b4b4b4">
                                                   <c:choose>
                                                      <c:when test='${sort_option==1 }'>
                                                         ${vo.arti_cnt}
                                                         </c:when>
                                                      <c:when test='${sort_option==2 }'>
                                                         ${vo.auth_cnt}
                                                         </c:when>
                                                      <c:when test='${sort_option==3 }'>
                                                         ${vo.arti_cnt}
                                                         </c:when>
                                                      <c:when test='${sort_option==4 }'>
                                                         ${vo.jrnl_cnt}
                                                         </c:when>
                                                      <c:when test='${sort_option==5 }'>
                                                         ${vo.refr_cnt}
                                                         </c:when>
                                                      <c:otherwise>
                                                         ${vo.arti_cnt}
                                                         </c:otherwise>
                                                   </c:choose>

                                                </td>

                                             </tr>
                                          </c:forEach>

                                       </c:when>
                                       <c:otherwise>
                                          <tr>
                                             <td colspan="5" style="border-top: 1px solid #b4b4b4; border-bottom: 1px solid #b4b4b4; text-align: center">등록된 논문이 없습니다</td>
                                          </tr>
                                       </c:otherwise>

                                    </c:choose>
                                 </tbody>
                              </table>
                              <!-- 논문수 통계 -->
                              <div class="artiStat">
                                 <table style="text-align: center;" class="table table-hover">
                                    <tbody>
                                       <th style="border-top: 2px solid #000069">분야명</th>
                                       <th style="border-top: 2px solid #000069">주제명</th>
                                       <th style="border-top: 2px solid #000069">논문 수</th>
                                       <tr>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">분야명 데이터</a>
                                          </td>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">주제명 데이터</a>
                                          </td>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">0</a>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </div>
                              <!-- 학술지수 통계 -->
                              <div class="jrnlStat">
                                 <table style="text-align: center;" class="table table-hover">
                                    <tbody>
                                       <th style="border-top: 2px solid #000069">분야명</th>
                                       <th style="border-top: 2px solid #000069">주제명</th>
                                       <th style="border-top: 2px solid #000069">학술지</th>


                                       <tr>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">분야명 데이터</a>
                                          </td>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">주제명 데이터</a>
                                          </td>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">0</a>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </div>
                              <!-- 참고문헌 수 통계 -->
                              <div class="refrStat">
                                 <table style="text-align: center;" class="table table-hover">
                                    <tbody>
                                       <th style="border-top: 2px solid #000069">분야명</th>
                                       <th style="border-top: 2px solid #000069">주제명</th>
                                       <th style="border-top: 2px solid #000069">참고문헌</th>
                                       <tr>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">분야명 데이터</a>
                                          </td>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">주제명 데이터</a>
                                          </td>
                                          <td style="border-top: 1px solid #b4b4b4">
                                             <a href="#">0</a>
                                          </td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                           <!-- 연구분야의 주제별 상위 통계를 보여줄 차트 캔버스 정의 -->
                           <div class="col-lg-7" id="div_canvas_ctgr">
                              <canvas id="canvas_ctgr"></canvas>
                           </div>
                        </div>
                        <script>
                           /** 위에 정의한 canvas 아이디를 가져와 차트를 정의 **/
                           var ctx = document.getElementById("canvas_ctgr").getContext("2d");
                           /** 차트의 크기 정의 **/
                              ctx.canvas.width = 800;
                              ctx.canvas.height = 400;
                              
                              //var chartLabels = [];
                              var artiCnt = [];
                              var authCnt = [];
                              var jrnlCnt = [];
                              var refrCnt = [];
                              
                              ////진행중....
                              /*
                              $.getJSON("/article/subjcnt", function(data){   
                              $.each(data, function(inx, obj){   
                                 chartLabels.push(obj.subj_nm);
                                 artiCnt.push(obj.arti_cnt);
                                 authCnt.push(obj.auth_cnt);
                                 jrnlCnt.push(obj.jrnl_cnt);
                                 refrCnt.push(obj.refr_cnt);
                              });   
                              
                                 createChart();
                              });
                              */
                                                                  
                              function createChart()
                              {
                                var so = "${sort_option}";
                                var m_data = [];
                                var chartLabels = [];
                                var ctgrList = [];
                                <c:choose>
                                   <c:when test="${not empty ctgrList}">
                                      <c:forEach items="${ctgrList }" var="vo" varStatus="g">
                                         
                                         chartLabels.push("${vo.subj_nm}");
                                         
                                         if(so==1){
                                            m_data.push("${vo.arti_cnt}");
                                         }else if(so==2){
                                            m_data.push("${vo.auth_cnt}");
                                         }else if(so==3){
                                            m_data.push("${vo.arti_cnt}");
                                         }else if(so==4){
                                            m_data.push("${vo.jrnl_cnt}");
                                         }else if(so==5){
                                            m_data.push("${vo.refr_cnt}");
                                         }else{
                                            
                                         }
                                      </c:forEach>
                                   </c:when>
                                </c:choose>
                                 
                                 
                                 var chart = new Chart(document.getElementById("canvas_ctgr"), {
                                             type : 'bar',
                                                   data : {
                                                      /** 해당 연구분야의 주제명 **/
                                                      labels : chartLabels,
                                                      /** 실제 데이터가 들어갈 부분 **/
                                                      datasets : [
                                                            {
                                                               /** 분류 기준(라벨) **/
                                                              // label : "저자수",
                                                               type : "line",
                                                               borderColor : "#8e5ea2",
                                                               /** 실제 통계 수치 **/
                                                               //data : artiCnt,
                                                               data:m_data,
                                                               fill : false
                                                            },
                                                            {
                                                               //label : "저자수",
                                                               type : "bar",
                                                               backgroundColor : "rgba(102,153,255,0.5)",
                                                               data : m_data
                                                            } ]
                                                   },
                                                   options : {
                                                      responsive : true,
                                                      scales : {
                                                         yAxes : [ {
                                                            stacked : true,
                                                            ticks : {}
                                                         } ],
                                                         xAxes : [ {
                                                            stacked : true,
                                                            ticks : {}
                                                         } ]
                                                      },
                                                      showValue : {
                                                         fontSize : 15,
                                                         fontStyle : 'Helvetica'
                                                      },
                                                      animation : {
                                                       easing:'easeOutCubic'  
                                                      },
                                                      legend : {
                                                         display : false
                                                      }
                                                   }
                                                });
                             }
                              
                              
                                /** 현재 차트를 정의  **/
                                var currentChart;   
                                
                                function updateChart() {
                                   /** 차트가 업데이트 될때 에는 현재 차트를 지움 **/
                                    if (currentChart) {
                                       currentChart.destroy();
                                     }
                  
                                   /** 위에 정의한 SelectBox의 id를 가지고 옵션의 value값을 차트를 결정하는 기준으로 둠 **/
                                     var determineChart = "1"//$("#cnt2").val();
                                   /** 선택한 option에 따른 차트를 params라는 변수에 정의 **/
                                   var params = dataMap[determineChart];
                                   /** 차트를 생성 **/
                                   currentChart = new Chart(ctx)[params.method](params.data, {});
                                }   
                        </script>
                     </div>
                  </div>
               </article>
            </section>
         </div>
      </div>
   </form>
   <!-- JQUERY, 필요한 JAVASCRIPT 파일 -->
   <script src="/resources/js/jquery.min.js"></script>
   <script src="/resources/js/popper.js"></script>
   <script src="/resources/js/bootstrap.min.js"></script>
   <script src="/resources/js/main.js"></script>
</body>
</html>