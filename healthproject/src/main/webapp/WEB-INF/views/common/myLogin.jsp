<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

    
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Login</title>

    <!-- Bootstrap Core CSS -->
    <link href="${contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${contextPath}/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${contextPath}/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${contextPath}/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default" style="margin-top: 10%;">
                    <div class="panel-heading">
                        <h2 class="panel-title">Please Sign In</h2>
                    </div>
                    <div class="panel-body">
                        <form role="form" method="post" action="${contextPath }/myLoginProcess">
                        	<fieldset>
                        		<h6 class="text-muted"><c:out value="${error }"/></h6>
                        		<h6 class="text-muted"><c:out value="${logout }"/></h6>
                        	</fieldset>
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="아이디를 입력하세요." 
                                           name="username" id="username" type="text" required autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="암호를 입력하세요." 
                                           name="password" id="password" type="password" required>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="remember-me" type="checkbox" >자동로그인(Remember Me)
                                    </label>
                                </div>
                                <div>
                                	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
                                </div>
                                <!-- Change this to a button or input when using this as a form --><!-- 
                                <a href="index.html" class="btn btn-lg btn-success btn-block">Login</a> -->
                                <div>
                                	<button type="submit" class="btn btn-lg btn-success btn-block">Sign in</button>
                                </div>
                            </fieldset>
                            <fieldset>
                            	<hr>
                            	<h6 class="text-muted text-center"><c:out value="${normal }"/></h6>
                            
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="${contextPath}/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="${contextPath}/resources/dist/js/sb-admin-2.js"></script>

</body>


</html>
    