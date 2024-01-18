/**
 * questioncomment.js: 댓글/답글 데이터 처리용 Ajax Closure Module */
 
 //alert("댓글 클로저 모듈 실행됨");
 
 var qcommentClsr = (function() {
 	
 	//댓글 목록(페이징) - ajax() 함수 사용
 	function getCmtList(questionParam, callback, error) {
 	
 		var qpost_number = questionParam.qpost_number;
 		var pageNum = questionParam.pageNum || 1;
 
 		console.log("getCmtList()가 전달받은 qpost_number: " + qpost_number);
 		console.log("getCmtList()가 전달받은 pageNum: " + pageNum);
 		
 		//댓글 목록 조회 컨트롤러의 매핑 URL: GET /questionComment/{qpost_number}/page/{pageNum}
        //$.ajax() 함수는, 자바스크립트 객체를 매개값으로 받아 처리
        $.ajax({
            type: 'get' ,
            url: "/healthproject/questionComment/" + qpost_number + "/page/" + pageNum ,
            dataType: 'json' , 
            success: function(questionCommentPagingCreator, status, xhr){
                if(callback) {
                    callback(questionCommentPagingCreator) ;
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

        var qpost_number = comment.qpost_number ;
		console.log("registerCmt()에 전달된 qpost_number: " + qpost_number);
		
        $.ajax({
            type: "post" ,
            url: "/healthproject/questionComment/" + qpost_number + "/new" ,
            data: JSON.stringify(comment) ,
            contentType: "application/json; charset=utf-8" ,
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

        var qpost_number = reply.qpost_number ;
        var qreply_number = reply.qreply_number ;

        $.ajax({
            type: "post" ,
            url: "/healthproject/questionComment/" + qpost_number + "/" + qreply_number + "/new" ,
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
    function getCmtReply(read, callback, error) {

        var qpost_number = read.qpost_number ;
        var qcomment_number = read.qcomment_number ;
		console.log("getCmtReply() 전달받은 qpost_number: " + qpost_number);
		console.log("getCmtReply() 전달받은 qcomment_number: " + qcomment_number);
		console.log("getCmtReply() 함수의 특정 댓글에 조회 ajax 처리 시작......");

        $.get("/healthproject/questionComment/" + qpost_number + "/" + qcomment_number + ".json",
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
    
        var qpost_number = comment.qpost_number ;
        var qcomment_number = comment.qcomment_number ;
		console.log("modifyCmtReply() 전달받은 qpost_number: " + qpost_number + " 전달받은 qcomment_number: " + qcomment_number);
		console.log("modifyCmtReply() 함수의 특정 댓글 수정 ajax 처리 시작......");
		
        $.ajax({
            type: "put" ,
            url: "/healthproject/questionComment/" + qpost_number + "/" + qcomment_number,
            data: JSON.stringify(comment),
            contentType: "application/json; charset=utf-8",
            dataType: "text",
            success: function(modResult, status, xhr) {
                if(callback) {
                    callback(modResult) ;
                }
            },
            error: function(xhr, status, err) {
                if(error){
                    error(err) ;
                }
            }
        }); //ajax-end
    }//modifyCmtReply-end
    
    //댓글 삭제
    function removeCmtReply(comment, callback, error) {

        var qpost_number = comment.qpost_number ;
        var qcomment_number = comment.qcomment_number ;
        var qcomment_writer = comment.qcomment_writer ;

        $.ajax({
            type: "delete" ,
            url: "/healthproject/questionComment/" + qpost_number + "/" + qcomment_number,
            data: JSON.stringify({qpost_number: qpost_number, qcomment_number: qcomment_number, qcomment_writer: qcomment_writer}),
            contentType: "application/json;charset=utf-8",
            success: function(removeResult, status, xhr) {
                if(callback) {
                    callback(removeResult) ;
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
    function removeAllComment(qpost_number, callback, error) {
        
        $.ajax({
            type: "delete" ,
            url: "/healthproject/questionComment/" + qpost_number ,
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
    	getCmtList : getCmtList,
    	registerCmt : registerCmt,
    	registerReply : registerReply,
    	getCmtReply : getCmtReply,
    	modifyCmtReply : modifyCmtReply,
    	removeCmtReply : removeCmtReply,
    	removeAllComment : removeAllComment,
    	dateTimeFmt : dateTimeFmt
    };
    
 })();  //qcommentClsr-end 
        