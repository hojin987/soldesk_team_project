<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">

						<form id="frmSendValue">
						</form>
                        
                        <div class="panel-body">
                        	<h1>광고화면</h1>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            공지사항
                            <button type="button" style="float:right" onclick="location.href='${contextPath}/noticeBoard/list'">+</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th> </th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="noticeBoard" items="${noticeBoard.noticeboardList}" begin="0" end="4">
                                        <tr class="moveNoticeBoardDetail" data-npost_number="${noticeBoard.npost_number}">
                                            <td>공지</td>                                          
                                            <td>${noticeBoard.ntitle }</td>
                                            <td>${noticeBoard.nwriter }</td>
                                            <td>${noticeBoard.nregister_date }</td>
                                        	<td>${noticeBoard.nview_count }</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            자유게시판
                            <button type="button" style="float:right" onclick="location.href='${contextPath}/freeBoard/list'">+</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="freeBoard" items="${freeBoard.freeboardList}" begin="0" end="4">
                                        <tr class="moveFreeBoardDetail" data-fpost_number="${freeBoard.fpost_number}">
                                            <td>${freeBoard.fpost_number }</td>
                                            <td>${freeBoard.ftitle }</td>
                                            <td>${freeBoard.fwriter }</td>
                                            <td>${freeBoard.fregister_date }</td>
                                            <td>${freeBoard.fview_count }</td>
                                        </tr>
                                    </c:forEach>    
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg- -->
            </div><!-- /.row -->

            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            회원권
                            <button type="button" style="float:right" onclick="location.href='${contextPath}/ticket/list'">+</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>정기권</th>
                                            <th>가격</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="ticket" items="${ticket}" begin="0" end="5">
                                        <tr class="moveTicketDetail" data-ticket_number="${ticket.ticket_number}">
                                            <td>${ticket.ticket_content}</td>
                                            <td>${ticket.ticket_price }</td>
                                        </tr>
                                    </c:forEach>    
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
                
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            오늘의 추천운동
                            <button type="button" style="float:right" onclick="location.href='${contextPath}/workout/list'">+</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table>
                                    <thead>
                                   	<c:choose>
					     			<c:when test="${principal eq 'anonymousUser'}">
					     				<tr>
				     						<th>목표를 설정해보세요</th>
				     					</tr>
					     			</c:when>
					     			<c:otherwise>
									    <tr>
									        <th>${principal.username}님의 목표를 응원합니다.</th>
									    </tr>
									    <c:forEach items="${workoutList}" var="workout" varStatus="loop">
									        <c:if test="${loop.index < 3}">
									            <c:if test="${loop.index != 0}">
									                </tr> <!-- 이전 행을 닫습니다 -->
									            </c:if>
									            <tr>
									                <c:forEach begin="0" end="2" var="imageIndex">
									                    <td style="font-size:20px">이미지</td>
									                </c:forEach>
									            </tr>
									            <tr>
									        </c:if>
									
									        <td class="moveDetail" data-workout_code="${workout.workout_code}" style="text-align:left;">
									        [<c:out value="${workout.workout_target}" />] <c:out value="${workout.workout_name}"/></td>
									
									        <c:if test="${(loop.index + 1) % 3 == 0 or loop.last}">
									            </tr> <!-- 행을 닫습니다 -->
									        </c:if>
									    </c:forEach>
									</c:otherwise>
					    			</c:choose>
                                        
                                    </thead>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-4 -->
            </div>
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            장비&식품 SHOP
                            <button type="button" style="float:right" onclick="location.href='${contextPath}/product/list'">+</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive table-bordered">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>상품이름</th>
                                            <th>상품가격</th>
                                            <th>상품재고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${product}" begin="0" end="5">
                                        <tr class="moveProductDetail" data-product_number="${product.product_number}">
                                            <td>${product.product_content}</td>
                                            <td>${product.product_price}</td>
                                            <td>${product.product_stock}</td>
                                        </tr>
                                    </c:forEach>  
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
        
        <!-- /#page-wrapper -->

<script>

var frmSendValue = $("#frmSendValue") ;

$(".moveNoticeBoardDetail").on("click", function(){
	var npost_number = $(this).data("npost_number") ;
	
	frmSendValue.append("<input type='hidden' name='npost_number' value='" + npost_number + "'/>") ;
	frmSendValue.attr("action", "${contextPath}/noticeBoard/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="npost_number"]').remove() ; 
})

$(".moveFreeBoardDetail").on("click", function(){
	var fpost_number = $(this).data("fpost_number") ;
	
	frmSendValue.append("<input type='hidden' name='fpost_number' value='" + fpost_number + "'/>") ;
	frmSendValue.attr("action", "${contextPath}/freeBoard/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="fpost_number"]').remove() ; 
})


$(".moveTicketDetail").on("click", function(){
	var ticket_number = $(this).data("ticket_number") ;
	
	frmSendValue.append("<input type='hidden' name='ticket_number' value='" + ticket_number + "'/>") ;
	frmSendValue.attr("action", "${contextPath}/ticket/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="ticket_number"]').remove() ; 
})


$(".moveProductDetail").on("click", function(){
	var product_number = $(this).data("product_number") ;
	
	frmSendValue.append("<input type='hidden' name='product_number' value='" + product_number + "'/>") ;
	frmSendValue.attr("action", "${contextPath}/product/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="product_number"]').remove() ; 
})




</script>


<%@include file="../myinclude/myfooter.jsp" %>    