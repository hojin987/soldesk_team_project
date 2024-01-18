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

    <!-- DataTables JavaScript --><%-- 
    <script src="${contextPath }/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath }/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="${contextPath }/resources/vendor/datatables-responsive/dataTables.responsive.js"></script> --%>

    <!-- Custom Theme JavaScript -->
    <script src="${contextPath }/resources/dist/js/sb-admin-2.js"></script>

	<!-- favicon.ico 404 Error 해결 -->  
	<link rel="shortcut icon" href="${contextPath}/resources/myicon/favicon.ico" type="image/x-icon">
	<!-- favicon 을 사용하지 않도록 설정--><!-- 
	<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon"> -->
	
	<style>
		body{margin: 0 60px;}
		a{font-size: 20px;}
	</style>
</head>

<body id="me">
	
<div id="wrapper">

<!-- Navigation -->
<nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
    <div class="col-lg-12">
    	<table class="table" style="text-align:center;">
    	<tbody>
    	<sec:authentication property="principal" var="principal"/>
    		<tr>
    			<td><a href="${contextPath }/">SOLDESK GYM</a></td>
    			<td><a href="${contextPath }/workout/list">운동정보</a></td>
    			<td><a href="${contextPath }/noticeBoard/list">공지사항</a></td>
    			<td><a href="${contextPath }/freeBoard/list">자유게시판</a></td>
    			<td><a href="${contextPath }/questionBoard/list">1:1문의</a></td>
    			<td><a href="${contextPath }/applyBoard/list">채용공고</a></td>
    			<td><a href="${contextPath }/ticket/list">회원권</a></td>
    			<td><a href="${contextPath }/product/list">GYM쇼핑몰</a></td>
    			<c:choose>
     			<c:when test="${principal eq 'anonymousUser'}">
     				<td>
     					<button type="button" class="btn btn-lignt btn-sm" onclick="location.href='${contextPath}/myLogin'">로그인</button>&nbsp;&nbsp;
     					<button type="button" class="btn btn-light btn-sm" onclick="location.href='${contextPath}/user/memberRegister'">회원가입</button></td>
     			</c:when>
     			<c:otherwise>
     				<td style="font-size:13px;">${principal.username}님, 반갑습니다.<br>
     				<a style="font-size:13px;" href="${contextPath}/product/detail?product_number=product1">내 정보 확인하기</a></td>
     				<%-- <a style="font-size:13px;" href="${contextPath}/member/detail?member_id=${principal.username}">내 정보 확인하기</a></td> --%>
     			</c:otherwise>
    			</c:choose>
    		</tr>
    	</tbody>
    	</table>
        
    </div> <!-- 나중에 드랍다운 처리-->
    
</nav>

 