<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>

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
   $(function() {

      $("p.title span:gt(0)").css({
         "font-size" : "0.8em",
         "font-weight" : "normal"
      });

      function sectionToggle() {
         var target = $(this).parents(".box").find(".innerBox");
         var image = $(this).find("img");
         var imgName = image.attr("src");
         if (target.hasClass("open")) {
            target.slideUp(200);
            target.removeClass("open");
            image.attr(
                  "src",
                  imgName.replace("/resources/image/up.png",
                        "/resources/image/down.png")).attr("alt",
                  "open");
         } else {
            target.slideDown(200);
            target.addClass("open");
            image.attr(
                  "src",
                  imgName.replace("/resources/image/down.png",
                        "/resources/image/up.png"))
                  .attr("alt", "close");
         }

      }

      $(".articleBody h2").click(sectionToggle).keydown(function(e) {
         if (e.which == 13 || e.keyCode == 13)
            sectionToggle();
      });

      $("a.expOverseaOpen").click(
            function() {
               var target = $(this).closet("p").next("p.expOversea");
               var image = $(this).find("img");
               var imgName = image.attr("src");
               if (target.hasClass("open")) {
                  target.slideUp(200);
                  target.removeClass("open");
                  image.attr(
                        "src",
                        imgName.replace("/resources/image/up.png",
                              "/resources/image/down.png")).attr(
                        "alt", "open");
               } else {
                  target.slideDown(200);
                  target.addClass("open")
                  image.attr(
                        "src",
                        imgName.replace("/resources/image/down.png",
                              "/resources/image/up.png")).attr("alt",
                        "close");
               }

            });
   });
</script>



</head>
<form>
   <body>

      <div id="wrap">

         <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
               <a class="navbar-brand" href="/article">Article DataParsing</a>
            </div>
         </nav>

         <div class="container">
            <div style="min-height: 500px">
               <div style="margin: 30px;">&nbsp;</div>
               <div style="margin: 30px;">
                  <div class="input-group mb-3"></div>
               </div>
               <div id="contents">

                  <p style="font-size: 35px; font-weight: bold">${ArtiVO.arti_title}</p>
                  <hr style="border-bottom: 0.5px dotted #b4b4b4">
                  <p style="font-size: 13px">
                     학술지명: <a href="#">${ArtiVO.arti_source_title}</a>
                  </p>
                  <p style="font-size: 13px">
                     발행정보: <a href="#">${ArtiVO.arti_year},vol.${ArtiVO.arti_vol}
                        <c:if test="${ArtiVO.arti_issue !=''}">, no.${ArtiVO.arti_issue}</c:if>
                        <c:if test="${ArtiVO.arti_bp != '' && ArtiVO.arti_ep != ''}">, pp.${ArtiVO.arti_bp}~${ArtiVO.arti_ep}</c:if>
                        ,(${ArtiVO.arti_page_cnt} pages)
                     </a>
                  </p>
                  <p style="font-size: 13px">
                     DOI: <a href="#">${ArtiVO.arti_doi}</a>
                  </p>
                  <p style="font-size: 13px">
                     발행기관:
                     <c:forEach var="pub" items="${ArtiVO.list_publ}" varStatus="a">
                        <a href="#"> ${pub.publ_dply} </a>
                     </c:forEach>
                  </p>
                  <p style="font-size: 13px">
                     <c:if test="${ArtiVO.arti_ctgr_name != ''}">
                     연구분야: <a href="#"> ${ArtiVO.arti_ctgr_name} </a>
                     
                     <c:if test="${not empty ArtiVO.arti_ctgr_subh}">></c:if>
                     
                     <c:set var="tmp_list" value="${fn:split(ArtiVO.arti_ctgr_subh,'|') }" />
                            
                           <c:forEach var="tmp" items="${tmp_list}" varStatus="g">
                          <a href="#"> ${tmp} </a> 
                  <c:if test="${g.count !=fn:length(tmp_list) }">,</c:if>
                           </c:forEach> > <c:set var="tmp_list"
                              value="${fn:split(ArtiVO.arti_ctgr_subj,'|') }" /> <c:forEach
                              var="tmp" items="${tmp_list}" varStatus="g">
                          <a href="#"> ${tmp} </a> 
                  <c:if test="${g.count !=fn:length(tmp_list) }">,</c:if>
                           </c:forEach>
                     </c:if>
                  </p>
                  <hr style="border-bottom: 0.5px dotted #b4b4b4">
                  
                  <h2 style="font-size: 14px; font-weight: bold"></h2>
                  <p style="font-size: 13px">
                  
                  	
                     <c:forEach var="auth" items="${ArtiVO.list_auth}" varStatus="a">
                        <a href="#"> ${auth.auth_full} <c:if
                              test="${auth.auth_repr == 'Y' and a.count == 1}">(제 1, 교신)</c:if>
                           <c:if test="${auth.auth_repr != 'Y' and a.count == 1}">(제 1)</c:if>
                           <c:if test="${auth.auth_repr == 'Y' and a.count > 1}">(교신)</c:if>
                           <c:if test="${auth.auth_repr != 'Y' and a.count > 1}">(참여)</c:if>
                        </a>&nbsp;
                     </c:forEach>
                     <br>
                     <c:forEach var="orgn" items="${ArtiVO.list_orgn}" varStatus="o">
                            ${orgn.orgn_name}
                            <c:if test="${o.count != fn:length(ArtiVO.list_orgn)}">/</c:if>
                     </c:forEach>
                  </p>
                  <hr style="border-bottom: 0.5px dotted #b4b4b4">

                  <div class="articleBody">
                     <div class="box">
                        <h2 style="font-size: 14px; font-weight: bold">
                           초록 &emsp; &emsp; &emsp; &emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <img
                              src="/resources/image/up.png" alt="close">
                        </h2>
                        <div class="innerBox open" style="display: block;">
                           <p style="white-space: pre-line;">${ArtiVO.arti_ab}</p>
                        </div>
                     </div>
                     <hr style="border-bottom: 0.5px dotted #b4b4b4">
                     <div class="box">
                        <h2 style="font-size: 14px; font-weight: bold">
                           키워드 &emsp; &emsp; &emsp; &emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <img
                              src="/resources/image/up.png" alt="close">
                        </h2>
                        <div class="innerBox open" style="display: block;">
                           <div>
                              <c:if test="${empty ArtiVO.list_kwrd}">
                                 <p style="text-align: center; font-size: 13px">데이터가 없습니다</p>
                              </c:if>
                              <c:forEach var="kw" items="${ArtiVO.list_kwrd}" varStatus="k">
                                 <a href="#" style="font-size: 13px"> ${kw.kwrd_name} <c:if
                                       test="${k.count !=fn:length(ArtiVO.list_kwrd) }">,</c:if>

                                 </a>&nbsp;
                           </c:forEach>
                           </div>
                        </div>
                     </div>
                     <hr style="border-bottom: 0.5px dotted #b4b4b4">
                     <div class="box">
                        <h2 style="font-size: 14px; font-weight: bold">
                           참고문헌<a href="#">(${ArtiVO.arti_cite_cnt})</a> &emsp; &emsp;
                           &emsp; &emsp; &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
                           &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&emsp;&emsp;&emsp;&emsp;&emsp;
                           &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&emsp;&emsp;&emsp;
                           &emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp; <img
                              src="/resources/image/down.png" alt="open">
                        </h2>
                        <div class="innerBox" style="display: none;">
                           <div>
                              <p style="font-size: 13px;">
                                 <c:if test="${empty ArtiVO.list_refr}">
                                    <p style="text-align: center; font-size: 13px">데이터가 없습니다</p>
                                 </c:if>
                                 <c:forEach var="refr" items="${ArtiVO.list_refr}"
                                    varStatus="rf">
                               ${rf.count}. &nbsp; ${refr.refr_auth} / ${refr.refr_year} / ${refr.refr_title} 
                                       <c:if
                                       test="${refr.refr_issue == '' and refr.refr_vol != ''}">
                                   / ${refr.refr_vol} : 
                                    </c:if>
                                    <c:if
                                       test="${refr.refr_issue != '' and refr.refr_vol != ''}">
                                   / ${refr.refr_vol} (${refr.refr_issue}) :
                                   </c:if>
                                    <c:if
                                       test="${refr.refr_page == '' and refr.refr_orgn != ''}">
                                      ${refr.refr_orgn}
                                 </c:if>
                                    <c:if test="${refr.refr_page != ''}">
                                    ${refr.refr_page} / ${refr.refr_orgn}
                                 </c:if>
                                    <br>
                                 </c:forEach>
                              </p>
                           </div>
                        </div>
                        <hr style="border-bottom: 0.5px dotted #b4b4b4">
                     </div>

                  </div>

                  <footer> </footer>

                  <div align="left" style="margin-top: 15px; margin-bottom: 8px">
                     <button type="submit" class="btn btn-primary disabled"
                        formaction="/" formmethod="get">돌아가기</button>
                  </div>



               </div>
            </div>
         </div>
      </div>
   </body>

   <form>
</html>