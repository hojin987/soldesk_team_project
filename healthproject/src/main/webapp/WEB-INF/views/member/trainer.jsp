<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">trainer - List</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-body">

	<table class="table table-bordered " 
	       style="margin:0 auto; width: 80%; text-align: center;">
	    <tbody>
			<c:forEach items="${pagingCreator.memberList}" var="member" varStatus="loop">
		        <c:if test="${loop.index % 3 == 0}">
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
				<c:forEach items="${member.authorityList}" var="authorityList">
					<c:if test="${authorityList.authority eq 'TRAINER'}">
			        	<td class="moveDetail" data-workout_code="${member.member_id}" style="text-align:left;">
			        	[<c:out value="강사" />] <c:out value="${member.member_name}"/></td>
					</c:if>
				</c:forEach>
		        <c:if test="${(loop.index + 1) % 3 == 0 or loop.last}">
		            </tr> <!-- 행을 닫습니다 -->
		        </c:if>
		        
		    </c:forEach>           

                    </tbody>
                </table><%-- /.table-responsive --%>
                
<form id="frmSendValue">
</form>

          </div><%-- /.panel-body --%>
            
        </div><%-- /.panel --%>
    </div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>
  

</div><%-- /#page-wrapper --%>

<%-- Modal --%>
<div class="modal fade" id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="yourModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" id="yourModal-body">메시지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>



<script>

var frmSendValue = $("#frmSendValue") ;
var result = '<c:out value="${result}" />' ;
//alert("result.length: " + result.length)

//등록페이지 이동
$("#btnToRegister").on("click",function(){
	window.location.href = "${contextPath}/workout/register" ; 
});

//상세페이지 이동
$(".moveDetail").on("click", function(){
	var workout_code = $(this).data("workout_code") ;
	
	frmSendValue.append("<input type='hidden' name='workout_code' value='" + workout_code + "'/>")
	frmSendValue.attr("action", "${contextPath}/workout/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="workout_code"]').remove() ;
});


</script> 

<%@include file="../myinclude/myfooter.jsp" %>    