/**
 * noticecomment.js: 댓글/답글 데이터 처리용 Ajax Closure Module */
 
 //alert("댓글 클로저 모듈 실행됨");

var ncommentClsr = (function() {

	var csrfToken, csrfHeader;
	
	function init(csrfTokenValue, csrfHeaderValue){
		csrfToken = csrfTokenValue;
		csrfHeader = csrfHeaderValue;
	}
	
 	//댓글 목록(페이징) - ajax() 함수 사용
 	function getCmtList(noticeParam, callback, error) {
 	
 		var npost_number = noticeParam.npost_number;
 		var pageNum = noticeParam.pageNum || 1;
 
 		console.log("getCmtList()가 전달받은 npost_number: " + npost_number);
 		console.log("getCmtList()가 전달받은 pageNum: " + pageNum);
 		
 		//댓글 목록 조회 컨트롤러의 매핑 URL: GET /noticeComment/{npost_number}/page/{pageNum}
        //$.ajax() 함수는, 자바스크립트 객체를 매개값으로 받아 처리
        $.ajax({
            type: 'get' ,
            url: "/healthproject/noticeComment/" + npost_number + "/page/" + pageNum ,
            dataType: 'json' , 
            success: function(noticeCommentPagingCreator, status, xhr){
                if(callback) {
                    callback(noticeCommentPagingCreator) ;
                }
            } ,

            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                }
            }

        });//ajax-end

    } //getCmtList-end
    
     //게시물에 대한 댓글 등록
    function registerCmt(comment, callback, error){
        var npost_number = comment.npost_number ;
		
        $.ajax({
            type: "post" ,
            url: "/healthproject/noticeComment/" + npost_number + "/new" ,
            data: JSON.stringify(comment),
            contentType: "application/json; charset=utf-8" ,
            beforeSend: function(xhr) {
            	xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(result, status) {
                if(callback) {
                    callback(result) ;
                }
            },
			
			error: function(xhr, status, err){
				if(error){
					error(err);
				}
			}
        }); //ajax-end
    }//registerCmt-end
	
	//답글 등록
    function registerReply(reply, callback, error){

        var npost_number = reply.npost_number ;
        var nreply_number = reply.nreply_number ;

        $.ajax({
            type: "post" ,
            url: "/healthproject/noticeComment/" + npost_number + "/" + nreply_number + "/new" ,
            data: JSON.stringify(reply) ,
            contentType: "application/json; charset=utf-8" ,
            dataType: 'text' ,
            success: function(result, status, xhr) {
                if(callback) {
                    callback(result) ;
                }
            } ,
            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                }
            }
        });//ajax-end
    } //registerReply-end
    
     //댓글 조회
    function getCmtReply(npost_number_and_ncomment_number, callback, error) {

        var npost_number = npost_number_and_ncomment_number.npost_number ;
        var ncomment_number = npost_number_and_ncomment_number.ncomment_number ;

        $.get( "/healthproject/noticeComment/" + npost_number + "/" + ncomment_number + ".json",
				function(result) {
                if(callback) {
                    callback(result) ;
                }
            }).fail(function(xhr, status, err) {
                if(error) {
                    error();
                }
            });
    }//getCmtReply-end

	//댓글 수정
    function modifyCmtReply(comment, callback, error) {
        var npost_number = comment.npost_number ;
        var ncomment_number = comment.ncomment_number ;

        $.ajax({
            type: "put" ,
            url: "/healthproject/noticeComment/" + npost_number + "/" + ncomment_number ,
            data: JSON.stringify(comment) ,
            contentType: "application/json; charset=utf-8" ,
            dataType: "text" ,
            success: function(result, status, xhr) {
                if(callback) {
                    callback(result) ;
                }
            } ,
            error: function(xhr, status, err) {
                if(error){
                    error(err) ;
                }
            }
        }) ; //ajax-end
    }//modifyCmtReply-end
    
    //댓글 삭제
    function removeCmtReply(comment, callback, error) {

        var npost_number = comment.npost_number ;
        var ncomment_number = comment.ncomment_number ;
        var ncomment_writer = comment.ncomment_writer ;

        $.ajax({
            type: "delete" ,
            url: "/healthproject/noticeComment/" + npost_number + "/" + ncomment_number,
            data: JSON.stringify({npost_number: npost_number, ncomment_number: ncomment_number, ncomment_writer: ncomment_writer}),
            contentType: "application/json;charset=utf-8",
            success: function(result, status, xhr) {
                if(callback) {
                    callback(result) ;
                }
            } ,
            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                }
            } 
        });
    } //removeCmtReply-end

	//모든 댓글 삭제
    function removeAllComment(npost_number, callback, error) {
        
        $.ajax({
            type: "delete" ,
            url: "/healthproject/noticeComment/" + npost_number ,
            dataType: "text" ,
            success: function(result, status, xhr) {
                if(callback) {
                    callback(result) ;
                }
            } ,
            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                }
            } 
        });
    } //removeAllComment-end
    
    
    //날짜시간 표시형식 변경 (서버와 상관없음)
    //JSON 날짜시간을 그대로 표시하면 1594169682000 (Long 타입 정수값) 이렇게 표시됩니다.
    //일반적인 날짜 시간 형식으로 표시하는 함수를 구현
    function dateTimeFmt(datetimeValue) {
        
        var Date = new Date(datetimeValue) ;
//        console.log("Date: " + Date) ;

        var DateTime = "" ;

        var yyyy = Date.getFullYear() ;
        var mm = Date.getMonth() + 1 ;  //1~12,  getMonth() is zero-based
        var dd = Date.getDate() ;
        var hh = Date.getHours() ;
        var mi = Date.getMinutes() ;
        var ss = Date.getSeconds() ;
        //2023/01/07 07:05:02
        DateTime =     [yyyy, "/",
                       (dd > 9 ? '' : "0") + dd , " " ,
                       (hh > 9 ? '' : "0") + hh , ":" ,
                       (mi > 9 ? '' : "0") + mi , ":" ,
                       (ss > 9 ? '' : "0") + ss ].join('') ;
        return DateTime                         

    } //dateTimeFmt-end
    
    return{
    	init : init,
    	getCmtList : getCmtList,
    	registerCmt : registerCmt,
    	registerReply : registerReply,
    	getCmtReply : getCmtReply,
    	modifyCmtReply : modifyCmtReply,
    	removeCmtReply : removeCmtReply,
    	removeAllComment : removeAllComment,
    	dateTimeFmt : dateTimeFmt
    };
    
 })();  //ncommentClsr-end 
        