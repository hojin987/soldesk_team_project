/**
 * freecomment.js: 댓글/답글 데이터 처리용 Ajax Closure Module */
 
 //alert("댓글 클로저 모듈 실행됨");
 
 var fcommentClsr = (function() {
 
	var csrfToken, csrfHeader;
	
	function init(csrfTokenValue, csrfHeaderValue){
		csrfToken = csrfTokenValue;
		csrfHeader = csrfHeaderValue;
	}
 	
 	//댓글 목록(페이징) - ajax() 함수 사용
 	function getCmtList(freeParam, callback, error) {
 	
 		var fpost_number = freeParam.fpost_number;
 		var pageNum = freeParam.pageNum || 1;
 
 		console.log("getCmtList()가 전달받은 fpost_number: " + fpost_number);
 		console.log("getCmtList()가 전달받은 pageNum: " + pageNum);
 		
 		//댓글 목록 조회 컨트롤러의 매핑 URL: GET /freeComment/{fpost_number}/page/{pageNum}
        //$.ajax() 함수는, 자바스크립트 객체를 매개값으로 받아 처리
        $.ajax({
            type: 'get' ,
            url: "/healthproject/freeComment/" + fpost_number + "/page/" + pageNum ,
            dataType: 'json' , 
            success: function(freeCommentPagingCreator, status, xhr){
                if(callback) {
                    callback(freeCommentPagingCreator) ;
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

        var fpost_number = comment.fpost_number ;
		console.log("registerCmt()에 전달된 fpost_number: " + fpost_number);
		
        $.ajax({
            type: "post" ,
            url: "/healthproject/freeComment/" + fpost_number + "/new" ,
            data: JSON.stringify(comment) ,
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

        var fpost_number = reply.fpost_number ;
        var freply_number = reply.freply_number ;

        $.ajax({
            type: "post" ,
            url: "/healthproject/freeComment/" + fpost_number + "/" + freply_number + "/new" ,
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

        var fpost_number = read.fpost_number ;
        var fcomment_number = read.fcomment_number ;
		console.log("getCmtReply() 전달받은 fpost_number: " + fpost_number);
		console.log("getCmtReply() 전달받은 fcomment_number: " + fcomment_number);
		console.log("getCmtReply() 함수의 특정 댓글에 조회 ajax 처리 시작......");

        $.get("/healthproject/freeComment/" + fpost_number + "/" + fcomment_number + ".json",
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
    
        var fpost_number = comment.fpost_number ;
        var fcomment_number = comment.fcomment_number ;
		console.log("modifyCmtReply() 전달받은 fpost_number: " + fpost_number + " 전달받은 fcomment_number: " + fcomment_number);
		console.log("modifyCmtReply() 함수의 특정 댓글 수정 ajax 처리 시작......");
		
        $.ajax({
            type: "put" ,
            url: "/healthproject/freeComment/" + fpost_number + "/" + fcomment_number,
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

        var fpost_number = comment.fpost_number ;
        var fcomment_number = comment.fcomment_number ;
        var fcomment_writer = comment.fcomment_writer ;

        $.ajax({
            type: "delete" ,
            url: "/healthproject/freeComment/" + fpost_number + "/" + fcomment_number,
            data: JSON.stringify({fpost_number: fpost_number, fcomment_number: fcomment_number, fcomment_writer: fcomment_writer}),
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
    function removeAllComment(fpost_number, callback, error) {
        
        $.ajax({
            type: "delete" ,
            url: "/healthproject/freeComment/" + fpost_number ,
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
    
 })();  //fcommentClsr-end 
        