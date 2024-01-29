<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %> 

<div class="row" style="display: flex; justify-content: center;">
    <div class="col-md-6">
        <div class="login-panel panel panel-default" style="margin-top: 5%;">
            <div class="panel-heading">
                <h2 class="panel-title">ID 로그인</h2>
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
                        <div>
                        	<button type="submit" class="btn btn-lg btn-dark btn-block">로그인</button>
                        </div>
                    </fieldset>
                    <fieldset>
                    	<hr>
                    	<div style="text-align:right;">
                     	<%-- <a href="${contextPath}/member/modifyPw">비밀번호 찾기</a>&nbsp;|&nbsp; --%>
                     	<a href="${contextPath}/member/memberRegister">회원가입</a>
                    	</div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../myinclude/myfooter.jsp" %> 

</html>
    