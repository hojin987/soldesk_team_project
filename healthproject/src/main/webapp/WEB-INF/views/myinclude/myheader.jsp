<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>My Admin Board</title>

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
</head>

<body id="me">

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${contextPath }/">My Admin Board</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-messages">
                        <li><a id="myLogin" href="${contextPath}/myLogin">
                            <i class="fa fa-sign-in fa-fw"></i> Sign in</a>
                        </li>
                        <li class="divider"></li>
                        <li><a id="myLogout" href="${contextPath}/myLogout">                  
                            <i class="fa fa-sign-out fa-fw"></i> Sign out</a>
                        </li>
                    </ul><!-- /.dropdown-user -->
                </li><!-- /.dropdown -->
            </ul><!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a href="${contextPath }"><i class="fa fa-home fa-fw"></i> Home Page</a>
                        </li>
                        <li>
                            <a href="${contextPath }/myboard/list"><i class="fa fa-table fa-fw"></i> Board List</a>
                        </li>
                        <li>
                            <a href="${contextPath }/myboard/register"><i class="fa fa-edit fa-fw"></i> Board Register</a>
                        </li>
                        <li>
                            <a href="${contextPath }/myboard/detail?bno=1"><i class="fa fa-edit-in fa-fw"></i> 1번 게시물 조회</a>
                        </li>
                        <li>
                            <a href="${contextPath }/myLogin"><i class="fa fa-sign-in fa-fw"></i> Sign in</a>
                        </li>
                        <li>
                            <a href="${contextPath }/myLogout"><i class="fa fa-sign-out fa-fw"></i> Sign out</a>
                        </li>
                        
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

 