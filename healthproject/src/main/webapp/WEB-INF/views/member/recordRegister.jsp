<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Record - Register</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>회원권 등록</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<form role="form" action="${contextPath}/member/recordRegister" method="post" name="frmBoard">
						<div id="experienceContainer">
						    <div class="form-group">
						        <input type="hidden" name="member_id" value="${param.member_id}">
						        <label>경력</label> <input class="form-control" name="trainer_record">
						        <label>경력 취득일</label> <input class="form-control" name="trainer_record_get_date">
						    </div>
						</div>
						
						<button type="button" class="btn btn-default btn-sm" onclick="addExperience()">경력 추가</button>
						
						<button type="submit" class="btn btn-default btn-sm">등록</button>
						<button type="button" class="btn btn-default btn-sm" data-oper="list"
								onclick="location.href='${contextPath}/member/trainer'">취소</button>
								
						<sec:csrfInput/>
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
    var experienceCount = 1; // 초기 <div>의 개수
	
    //강사 경력 입력 추가
    function addExperience() {
        var container = document.getElementById("experienceContainer");
        
        var newDiv = document.createElement("div");
        newDiv.className = "form-group";
        
        var hiddenInput = document.createElement("input");
        hiddenInput.type = "hidden";
        hiddenInput.name = "member_id";
        hiddenInput.value = "${param.member_id}";
        
        var label1 = document.createElement("label");
        label1.appendChild(document.createTextNode("경력"));
        
        var input1 = document.createElement("input");
        input1.className = "form-control";
        input1.name = "trainer_record";
        
        var label2 = document.createElement("label");
        label2.appendChild(document.createTextNode("경력 취득일"));
        
        var input2 = document.createElement("input");
        input2.className = "form-control";
        input2.name = "trainer_record_get_date";
        
        var deleteButton = document.createElement("button");
        deleteButton.type = "button";
        deleteButton.innerHTML = "삭제";
        deleteButton.onclick = function() {
            removeExperience(newDiv);
        };

        newDiv.appendChild(hiddenInput);
        newDiv.appendChild(label1);
        newDiv.appendChild(input1);
        newDiv.appendChild(label2);
        newDiv.appendChild(input2);

        // 새로운 <div>를 추가할 때는 삭제 버튼을 포함
        if (experienceCount > 0) {
            newDiv.appendChild(deleteButton);
        }

        container.appendChild(newDiv);

        experienceCount++;
    }
	
    //추가된 입력란 삭제
    function removeExperience(divToRemove) {
        var container = document.getElementById("experienceContainer");
        container.removeChild(divToRemove);
    }
</script>

<%@include file="../myinclude/myfooter.jsp" %>    