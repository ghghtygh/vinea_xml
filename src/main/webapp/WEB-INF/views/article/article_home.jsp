<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>

<!--  StyleSheet_부트스트랩 사용 -->
<script
   src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
   src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<link href="<c:url value='/resources/css/bootstrap.css' />"
   rel="stylesheet">
<link href="<c:url value='/resources/css/_bootswatch.scss' />"
   rel="stylesheet">
<link href="<c:url value='/resources/css/_variables.scss' />"
   rel="stylesheet">

<script>
   $(document)
         .ready(
               function() {

                  /** 알림창 닫기 **/
                  $("#btn_alert_hide").on("click", function(e) {

                     e.preventDefault();
                     $("#div_alert").hide();

                  });

                  /** XML 데이터 파일 추가 창 열기_BootStrap Modal 활용  **/
                  $("#btn_insertXML").on("click", function(e) {

                     e.preventDefault();

                     $("#div_alert").hide();

                     clear_input();

                     $("#insertXML").modal();
                  });

                  /** insertXML: 파싱 후, xml(논문데이터) DB 저장  **/
                  $("#btn_saveXml").click(function(e) {

                     e.preventDefault();

                     var arti_title = $("input[name=arti_title]").val();

                     if (arti_title == "") {

                        $("#alert_subject").html("XML 데이터 정보가 없습니다");
                        $("#alert_content").html("올바르게 파싱되었는지 확인해주세요");

                        $("#div_alert").show();

                        clear_input();

                        return;
                     }

                     var result = confirm("파싱된 내용을 저장하시겠습니까?");

                     if (result) {

                        var formObj = $("#frm");
                        formObj.attr("action", "/article/insert");
                        formObj.attr("method", "post");
                        formObj.submit();
                     }

                  });

                  /** insertXml: ArtiParser.java에서 파싱코드 가져와서 xml(논문)데이터 파싱 **/
                  $("#btn_chk")
                        .click(
                              function() {

                                 var filePath = $("#filePath").val();

                                 clear_input();

                                 if (filePath == "") {

                                    $("#alert_subject").html(
                                          "XML 경로 미입력");
                                    $("#alert_content").html(
                                          "XML 경로를 입력하지 않았습니다");
                                    $("#div_alert").show();
                                    return;
                                 }
                                 $("#div_alert").hide();

                                 $
                                       .ajax({
                                          async : true,
                                          url : "${pageContext.request.contextPath}/article/check",
                                          type : 'POST',
                                          data : {
                                             "filePath" : filePath
                                          },
                                          dataType : "json",

                                          success : function(data) {

                                             if (data == null) {
                                                return;
                                             }
                                             $(
                                                   "input[name=arti_id]")
                                                   .val(
                                                         data['arti_id']);
                                             $(
                                                   "input[name=arti_uid]")
                                                   .val(
                                                         data['arti_uid']);
                                             $(
                                                   "input[name=arti_title]")
                                                   .val(
                                                         data['arti_title']);
                                             $(
                                                   "input[name=arti_source_title]")
                                                   .val(
                                                         data['arti_source_title']);
                                             $(
                                                   "input[name=arti_year]")
                                                   .val(
                                                         data['arti_year']);
                                             $(
                                                   "input[name=arti_date]")
                                                   .val(
                                                         data['arti_date']);
                                             $(
                                                   "input[name=arti_vol]")
                                                   .val(
                                                         data['arti_vol']);
                                             $(
                                                   "input[name=arti_issue]")
                                                   .val(
                                                         data['arti_issue']);
                                             $(
                                                   "input[name=arti_sup]")
                                                   .val(
                                                         data['arti_sup']);
                                             $(
                                                   "input[name=arti_doi]")
                                                   .val(
                                                         data['arti_doi']);
                                             $(
                                                   "input[name=arti_ab]")
                                                   .val(
                                                         data['arti_ab']);
                                             $(
                                                   "input[name=arti_issn]")
                                                   .val(
                                                         data['arti_issn']);
                                             $(
                                                   "input[name=arti_eissn]")
                                                   .val(
                                                         data['arti_eissn']);
                                             $(
                                                   "input[name=arti_cite_cnt]")
                                                   .val(
                                                         data['arti_cite_cnt']);
                                             $(
                                                   "input[name=arti_page_cnt]")
                                                   .val(
                                                         data['arti_page_cnt']);
                                             $(
                                                   "input[name=arti_bp]")
                                                   .val(
                                                         data['arti_bp']);
                                             $(
                                                   "input[name=arti_ep]")
                                                   .val(
                                                         data['arti_ep']);
                                             $(
                                                   "input[name=arti_oa]")
                                                   .val(
                                                         data['arti_oa']);

                                             $("#arti_id")
                                                   .html(
                                                         '논문번호 : '
                                                               + data['arti_id']);
                                             $("#arti_uid")
                                                   .html(
                                                         'WOS_UID : '
                                                               + data['arti_uid']);
                                             $("#arti_title")
                                                   .html(
                                                         '논문제목 : '
                                                               + data['arti_title']);
                                             $(
                                                   "#arti_source_title")
                                                   .html(
                                                         '학술지명 : '
                                                               + data['arti_source_title']);
                                             $("#arti_year")
                                                   .html(
                                                         '발행년도 : '
                                                               + data['arti_year']);
                                             $("#arti_date")
                                                   .html(
                                                         '발행일자 : '
                                                               + data['arti_date']);
                                             $("#arti_vol")
                                                   .html(
                                                         '권 번호 : '
                                                               + data['arti_vol']);
                                             $("#arti_issue")
                                                   .html(
                                                         '호 번호 : '
                                                               + data['arti_issue']);
                                             $("#arti_doi")
                                                   .html(
                                                         'DOI : '
                                                               + data['arti_doi']);
                                             $("#arti_ab")
                                                   .html(
                                                         '초록 : '
                                                               + data['arti_ab']);
                                             $("#arti_issn")
                                                   .html(
                                                         'ISSN : '
                                                               + data['arti_issn']);
                                             $("#arti_eissn")
                                                   .html(
                                                         'EISSN : '
                                                               + data['arti_eissn']);
                                             $("#arti_cite_cnt")
                                                   .html(
                                                         '참고문헌수 : '
                                                               + data['arti_cite_cnt']);
                                             $("#arti_page_cnt")
                                                   .html(
                                                         '페이지수 : '
                                                               + data['arti_page_cnt']);
                                             $("#arti_bp")
                                                   .html(
                                                         '시작 페이지 : '
                                                               + data['arti_bp']);
                                             $("#arti_ep")
                                                   .html(
                                                         '종료 페이지 : '
                                                               + data['arti_ep']);
                                             $("#arti_oa")
                                                   .html(
                                                         '자료열람여부 : '
                                                               + data['arti_oa']);

                                          },
                                          error : function(
                                                request, error) {
                                          }
                                       });
                              });

               });

   /** 페이지 이동  **/
   function fn_paging(nowPage) {

      var url = "/article?page=" + nowPage;

      location.href = url;

   }

   function clear_input() {

      $("input[name=arti_id]").val("");
      $("input[name=arti_uid]").val("");
      $("input[name=arti_title]").val("");
      $("input[name=arti_source_title]").val("");
      $("input[name=arti_year]").val("");
      $("input[name=arti_date]").val("");
      $("input[name=arti_vol]").val("");
      $("input[name=arti_issue]").val("");
      $("input[name=arti_sup]").val("");
      $("input[name=arti_doi]").val("");
      $("input[name=arti_ab]").val("");
      $("input[name=arti_issn]").val("");
      $("input[name=arti_eissn]").val("");
      $("input[name=arti_cite_cnt]").val("");
      $("input[name=arti_page_cnt]").val("");
      $("input[name=arti_bp]").val("");
      $("input[name=arti_ep]").val("");
      $("input[name=arti_oa]").val("");

      $("#arti_id").html('');
      $("#arti_uid").html('');
      $("#arti_title").html('');
      $("#arti_source_title").html('');
      $("#arti_year").html('');
      $("#arti_date").html('');
      $("#arti_vol").html('');
      $("#arti_issue").html('');
      $("#arti_sup").html('');
      $("#arti_doi").html('');
      $("#arti_ab").html('');
      $("#arti_issn").html('');
      $("#arti_eissn").html('');
      $("#arti_cite_cnt").html('');
      $("#arti_page_cnt").html('');
      $("#arti_bp").html('');
      $("#arti_ep").html('');
      $("#arti_oa").html('');
   }
</script>

<style>
.modal-backdrop {
   position: fixed;
   top: 0;
   right: 0;
   bottom: 0;
   left: 0;
   z-index: 1030;
   background-color: #333333;
}

input:read-only {
   border: 0px;
   width: 100%;
}
</style>

</head>
<body>
   <form id="frm" method="get" enctype="multipart/form-data">

      <!--  input 'hidden'에 값을 담아 전송하여 DB에 저장 -->
      <input type="hidden" name="arti_id" value="" /> <input type="hidden"
         name="arti_uid" value="" /> <input type="hidden" name="arti_title"
         value="" /> <input type="hidden" name="arti_source_title" value="" />
      <input type="hidden" name="arti_year" value="" /> <input
         type="hidden" name="arti_date" value="" /> <input type="hidden"
         name="arti_vol" value="" /> <input type="hidden" name="arti_issue"
         value="" /> <input type="hidden" name="arti_sup" value="" /> <input
         type="hidden" name="arti_doi" value="" /> <input type="hidden"
         name="arti_ab" value="" /> <input type="hidden" name="arti_issn"
         value="" /> <input type="hidden" name="arti_eissn" value="" /> <input
         type="hidden" name="arti_cite_cnt" value="" /> <input type="hidden"
         name="arti_page_cnt" value="" /> <input type="hidden" name="arti_bp"
         value="" /> <input type="hidden" name="arti_ep" value="" /> <input
         type="hidden" name="arti_oa" value="" />

      <div id="wrap">

         <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
               <a class="navbar-brand" href="/article">Article DataParsing</a>
            </div>
         </nav>

         <div class="container">
            <div style="min-height: 500px;">
               <div style="margin: 30px;">&nbsp;</div>
               <div style="margin: 30px;">
                  <div class="input-group mb-3"></div>
               </div>
               <div id="contents">

                  <div>
                     <table class="table table-hover">
                        <tbody>
                           <!--  논문 목록이 비어있을때, 없을때를 구분하여 화면에 출력을 다르게 한다 -->
                           <c:choose>
                              <c:when test="${not empty xmlList}">
                                 <c:forEach items="${xmlList}" var="ArtiVO">
                                    <tr>
                                       <td>
                                          <p>${ArtiVO.arti_id}</p>
                                       </td>
                                       <td>
                                          <blockquote class="blockquote" style="font-size: 120%;">

                                             <!-- 논문 제목 클릭시, 논문상세페이지로 이동 -->
                                             <a class="mb-0" style="color: black;"
                                                href='article/article_detail?arti_id=${ArtiVO.arti_id}'>
                                                ${ArtiVO.arti_title} </a>

                                             <footer class="blockquote text-center"
                                                style="font-size: 90%;">
                                                <!--  저자정보 추가예정, 학회정보 추가예정, 권(호), 시작~끝페이지, 발행일자, 연구분야 추가예정 -->
                                                | ${ArtiVO.arti_source_title} |
                                                <c:if test="${ArtiVO.arti_issue != ''}">
                                             ${ArtiVO.arti_vol}(${ArtiVO.arti_issue}) 
                                             </c:if>
                                                <c:if test="${ArtiVO.arti_issue == ''}">
                                             ${ArtiVO.arti_vol} 
                                             </c:if>
                                             <c:if test="${ArtiVO.arti_bp != '' && ArtiVO.arti_ep != ''}">
                                                | 
                                              pp.${ArtiVO.arti_bp}~${ArtiVO.arti_ep}
                                              |
                                             </c:if> 
                                                | <c:set var="tmp_list" value="${fn:split(ArtiVO.arti_date,'-')}"/>
                                                <c:forEach var="tmp" items="${tmp_list}" varStatus="g">
                                                   <c:if test="${g.count == 2}">${ArtiVO.arti_year}.${tmp}</c:if>
                                                </c:forEach>
                                             </footer>
                                          </blockquote>
                                       </td>
                                    </tr>
                                 </c:forEach>
                              </c:when>
                              <c:otherwise>
                                 <tr>
                                    <td style="text-align: center">등록된 논문이 없습니다</td>
                                 </tr>
                              </c:otherwise>
                           </c:choose>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
            <!--  페이징 처리 -->
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
                              <a href="#" class="btn btn-primary"
                                 onClick="fn_paging('${pager.prevPage}')">&laquo;</a>
                           </c:when>
                           <c:otherwise>
                              <a class="btn btn-primary disabled">&laquo;</a>
                           </c:otherwise>
                        </c:choose>

                        <c:forEach begin="${pager.startPage}" end="${pager.endPage}"
                           var="pageNum">

                           <c:choose>

                              <c:when test="${pageNum eq pager.nowPage}">
                                 <a href="#" class="btn btn-primary active"
                                    onClick="fn_paging('${pageNum}')">${pageNum }</a>

                              </c:when>

                              <c:otherwise>
                                 <a href="#" class="btn btn-primary"
                                    onClick="fn_paging('${pageNum}')">${pageNum}</a>

                              </c:otherwise>

                           </c:choose>

                        </c:forEach>


                        <c:choose>
                           <c:when
                              test="${pager.nowPage ne pager.pageCnt && pager.pageCnt > 0 }">

                              <a class="btn btn-primary" href="#"
                                 onClick="fn_paging('${pager.nextPage}')">&raquo;</a>


                           </c:when>
                           <c:otherwise>

                              <a class="btn btn-primary disabled">&raquo;</a>

                           </c:otherwise>
                        </c:choose>
                        <c:choose>
                           <c:when test="${pager.nowPage ne pager.pageCnt }">

                              <a class="btn btn-primary" href="#"
                                 onClick="fn_paging('${pager.pageCnt}')">끝</a>


                           </c:when>
                           <c:otherwise>

                              <a class="btn btn-primary disabled">끝</a>

                           </c:otherwise>
                        </c:choose>

                     </div>
                  </div>
                  <div>
                     <div style="position: relative; float: right; z-index: 10;">
                        <button id="btn_insertXML" class="btn btn-primary">파싱</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </form>

   <div id="insertXML" class="modal">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title">XML 데이터 추가</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               <div class="container">
                  <div>
                     <p>XML 파일의 경로를 입력해주세요</p>
                  </div>
                  <div class="input-group mb-2" style="width: 100%;">
                     <input type="text" id="filePath" name="filePath"
                        class="form-control">

                     <button id="btn_chk" class="btn btn-secondary">파싱</button>
                  </div>
                  <div id="div_alert" class="alert alert-dismissible alert-primary"
                     style="display: none;">
                     <button type="button" class="close" id="btn_alert_hide"
                        style="color: white;">&times;</button>
                     <strong id="alert_subject">경로를 입력하지 않았습니다</strong><br>
                     <p id="alert_content">XML 파일의 경로를 입력해주세요</p>
                  </div>

                  <div id="arti_id"></div>
                  <div id="arti_uid"></div>
                  <div id="arti_title"></div>
                  <div id="arti_source_title"></div>
                  <div id="arti_year"></div>
                  <div id="arti_date"></div>
                  <div id="arti_vol"></div>
                  <div id="arti_issue"></div>
                  <div id="arti_sup"></div>
                  <div id="arti_doi"></div>
                  <div id="arti_ab"></div>
                  <div id="arti_issn"></div>
                  <div id="arti_eissn"></div>
                  <div id="arti_cite_cnt"></div>
                  <div id="arti_page_cnt"></div>
                  <div id="arti_bp"></div>
                  <div id="arti_ep"></div>
                  <div id="arti_oa"></div>

               </div>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-primary" id="btn_saveXml">저장</button>
               <button type="button" class="btn btn-secondary"
                  data-dismiss="modal">취소</button>
            </div>
         </div>
      </div>
   </div>
</body>
</html>