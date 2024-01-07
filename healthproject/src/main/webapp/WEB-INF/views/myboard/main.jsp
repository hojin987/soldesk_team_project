<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">메인 홈페이지</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            
                        </div>
                        <!-- /.panel-heading -->
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
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            공지사항
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성날짜</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>1번게시글제목</td>
                                            <td>서호진</td>
                                            <td>2023/12/30</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>2번게시글제목</td>
                                            <td>김영석</td>
                                            <td>2023/12/31</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>3번게시글제목</td>
                                            <td>문영훈</td>
                                            <td>2024/01/01</td>
                                        </tr>
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
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            자유게시판
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
                                            <th>작성날짜</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>1번게시글제목</td>
                                            <td>서호진</td>
                                            <td>2023/12/30</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>2번게시글제목</td>
                                            <td>김영석</td>
                                            <td>2023/12/31</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>3번게시글제목</td>
                                            <td>문영훈</td>
                                            <td>2024/01/01</td>
                                        </tr>
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
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            회원정보
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>로그인</th>
                                            <th>회원가입</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>목표를 입력해보세요</td>
                                        </tr>
                                    </tbody>
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
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            회원권
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>정기권이름</th>
                                            <th>가격</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>회원권 3개월</td>
                                            <td>90,000원</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>회원권 6개월</td>
                                            <td>170,000원</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>회원권 12개월</td>
                                            <td>320,000원</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>pt 10회권</td>
                                            <td>150,000원</td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>pt 20회권</td>
                                            <td>280,000원</td>
                                        </tr>
                                        <tr>
                                            <td>6</td>
                                            <td>pt 30회권</td>
                                            <td>420,000원</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-4 -->
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            장비&식품 SHOP
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive table-bordered">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>상품이름</th>
                                            <th>가격</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>프로틴파우더(초코맛) 1.2kg</td>
                                            <td>58,000원</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>프로틴파우더(바닐라맛) 1.2kg</td>
                                            <td>58,000원</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>훈제 닭가슴살 10개</td>
                                            <td>22,000원</td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>헬스 스트랩</td>
                                            <td>17,000원</td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>헬스 벨트</td>
                                            <td>35,000원</td>
                                        </tr>
                                        <tr>
                                            <td>6</td>
                                            <td>무릎 보호대</td>
                                            <td>19,000원</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-4 -->
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            오늘의 추천운동
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>목표를 설정해보세요</th>
                                        </tr>
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
            <!-- /.row -->
            
        </div>
        <!-- /#page-wrapper -->


<%@include file="../myinclude/myfooter.jsp" %>    