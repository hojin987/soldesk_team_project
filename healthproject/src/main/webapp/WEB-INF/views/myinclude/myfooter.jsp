<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
	<div class="footer space-medium">
        <div class="container">
            <div class="row">
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
                    <div class="footer-logo mb30">
                        <img src="${contextPath}/resources/images/logo_white.jpg" alt="" style="height:140px">
                    </div>
                </div>
                <div class="col-lg-offset-1 col-lg-3 col-md-offset-1 col-md-3 col-sm-3 col-xs-12">
                    <div class="footer-widget mb30">
                        <h3 class="footer-title">Contact Info</h3>
                        <ul class="listnone">
                            <li>
                                <address>
                                    서울특별시 종로구 종로12길 15
                                </address>
                            </li>
                            <li>0507-1430-7001 </li>
                            <li>soldeskgym@gmail.com</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-offset-1 col-lg-2 col-md-offset-1 col-md-2 col-sm-3 col-xs-12">
                    <div class="footer-widget mb30">
                        <h3 class="footer-title">운영시간</h3>
                        <ul class="listnone">
                            <li>연중 무휴</li>
                            <li>24시간 오픈</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                    <div class="footer-widget mb30">
                        <h3 class="footer-title">Connect With us</h3>
                        <div class="footer-social"> <a href="#"><i class="fa fa-twitter"></i></a> <a href="#" class="active"><i class="fa fa-facebook"></i> </a>
                            <a href="#"> <i class="fa fa-google-plus"></i> </a>
                            <a href="#"> <i class="fa fa-pinterest"></i> </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <!-- /#wrapper -->

    

    <%-- Page-Level Demo Scripts - Tables - Use for reference --%><%-- 
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
        });
    });
    </script> --%>

</body>

</html>
