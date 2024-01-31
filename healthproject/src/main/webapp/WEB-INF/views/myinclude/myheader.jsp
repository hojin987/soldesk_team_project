<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Soldesk GYM</title>

    <!-- Bootstrap Core CSS -->
    <link href="${contextPath }/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${contextPath }/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS --><%-- 
    <link href="${contextPath }/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet"> --%>

    <!-- DataTables Responsive CSS --><%-- 
    <link href="${contextPath }/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet"> --%>

    <!-- Custom CSS -->
    <link href="${contextPath }/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${contextPath }/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${contextPath }/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="${contextPath }/resources/vendor/metisMenu/metisMenu.min.js"></script>
	
	<!-- style CSS -->
	<link href="${contextPath }/resources/vendor/bootstrap/css/style.css" rel="stylesheet">
	
	<!-- animsition css -->
	<link rel="stylesheet" type="text/css" href="${contextPath }/resources/vendor/bootstrap/css/animsition.min.css">
	
    <!-- DataTables JavaScript --><%-- 
    <script src="${contextPath }/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath }/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="${contextPath }/resources/vendor/datatables-responsive/dataTables.responsive.js"></script> --%>

    <!-- Custom Theme JavaScript -->
    <script src="${contextPath }/resources/dist/js/sb-admin-2.js"></script>

	<!-- favicon.ico 404 Error 해결 -->  
	<link rel="shortcut icon" href="${contextPath}/resources/images/icon.ico" type="image/x-icon">
	
	<style>
		a { font-size: 15px;
			text-decoration: none; /* 링크의 밑줄 제거 */
		    color: black; /* 링크 색상 지정 */;}
		 
		.horizontal-menu {
		    display: flex; /* Flexbox를 사용하여 가로로 정렬 */
		    list-style: none; /* 리스트 스타일 제거 */
		}
		
		.horizontal-menu li {
		    margin-right: 20px; /* 각 항목 사이의 간격 조절 */
		}
		
		.horizontal-menu a {
		    text-decoration: none; /* 링크의 밑줄 제거 */
		    color: black; /* 링크 색상 지정 */
		}
		 
		body {
	      padding-top: 100px; /* fixed-top 네비게이션 바 때문에 페이지가 위로 밀리지 않도록 여백을 추가합니다. */
	    }
	    
	    .navbar-fixed-top {
	      top: 0;
	    }
	    
	    .navbar {
	      background-color: #f0f0f0; /* 원하는 회색빛 배경 색상으로 설정 */
	      border: 1px solid #ddd; /* 원하는 테두리 색상으로 설정 */
	    }
	</style>
</head>

<body id="me">
	
<div id="wrapper">
	<nav class="navbar navbar-expand-lg navbar-fixed-top">
	<div class="page-header">	
	<div id="sticky-wrapper" class="sticky-wrapper" style="height: 86px;"><div class="header" style="">
            <!-- navigation -->
            <div class="container">
                <div class="row">
                    <div class="col-md-3 col-sm-6 col-xs-6">
                        <div class="logo">
                            <a href="${contextPath}/"><img src="${contextPath}/resources/images/logo.jpg" alt="" style="height:60px;'"></a>
                        </div>
                    </div>
                    <div class="col-md-9 col-sm-12">
                        <div class="navigation pull-right" id="navigation"><div id="menu-button">Menu</div>
                        <sec:authentication property="principal" var="principal"/>
                            <ul class="horizontal-menu">
                                <li class="active"><a href="${contextPath }/" class="animsition-link">메인</a></li>
                                <li class="active"><a href="${contextPath }/member/trainer" class="animsition-link">강사</a></li>
                                <li class="active"><a href="${contextPath }/workout/list" class="animsition-link">운동</a></li>
                                <li class="has-sub"><span class="submenu-button"></span><a class="animsition-link">게시판</a>
                                    <ul>
                                        <li><a href="${contextPath }/noticeBoard/list" class="animsition-link">공지사항</a></li>
                                        <li><a href="${contextPath }/freeBoard/list" class="animsition-link">자유게시판</a></li>
                                        <li><a href="${contextPath }/questionBoard/list" class="animsition-link">1:1 문의</a></li>
                                        <li><a href="${contextPath }/applyBoard/list" class="animsition-link">트레이너 지원</a></li>
                                    </ul>
                                </li>
                                <li><a href="${contextPath }/ticket/list" title="Ticket" class="animsition-link">회원권/PT</a> </li>
                                <sec:authorize access="hasAuthority('ADMIN')">
                                	<li class="active"><a href="${contextPath }/member/list" class="animsition-link">회원목록</a></li>
                                </sec:authorize>
                                <li>
                                
                                <c:choose>
                                	<c:when test="${principal eq 'anonymousUser'}">
                                		<br><button type="button" style="padding-top: 0.25rem; padding-bottom: 0.25rem; padding-left: 0.5rem; padding-right: 0.5rem; font-size: 1.00rem;" 
                                					class="btn btn-secondary btn-sm" onclick="location.href='${contextPath}/myLogin'">로그인</button>&nbsp;&nbsp;
   											<button type="button" style="padding-top: 0.25rem; padding-bottom: 0.25rem; padding-left: 0.5rem; padding-right: 0.5rem; font-size: 1.00rem;" 
													class="btn btn-secondary btn-sm" onclick="location.href='${contextPath}/member/memberRegister'">회원가입</button>
                           			</c:when>
     								<c:otherwise>
	     								${principal.username}님, 반갑습니다.<a href="${contextPath}/member/detail?member_id=${principal.username}">내 정보 확인하기</a></li>
					     				<li><br>&nbsp;&nbsp;
					     				<form role="form" id="frmMyLogout" method="post" action="${contextPath }/myLogoutProcess">
						     				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
						     				<button type="submit"; style="padding-top: 0.25rem; padding-bottom: 0.25rem; padding-left: 0.5rem; padding-right: 0.5rem; font-size: 1.00rem;" 
				     								class="btn btn-secondary btn-sm pull-right">로그아웃</button>
					     				</form>
					     			</c:otherwise>
				    			</c:choose>
				    			</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </nav>
    
</nav>

 