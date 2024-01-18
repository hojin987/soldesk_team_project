/**
 * productcomment.js: 댓글/답글 데이터 처리용 Ajax Closure Module */
 
 //alert("댓글 클로저 모듈 실행됨");
 
 var pcommentClsr = (function() {
 	
 	//댓글 목록(페이징) - ajax() 함수 사용
 	function getCmtList(productParam, callback, error) {
 	
 		var product_number = productParam.product_number;
 		var pageNum = productParam.pageNum || 1;
 
 		console.log("getCmtList()가 전달받은 product_number: " + product_number);
 		console.log("getCmtList()가 전달받은 pageNum: " + pageNum);
 		
 		//댓글 목록 조회 컨트롤러의 매핑 URL: GET /productComment/{product_number}/page/{pageNum}
        //$.ajax() 함수는, 자바스크립트 객체를 매개값으로 받아 처리
        $.ajax({
            type: 'get' ,
            url: "/healthproject/productComment/" + product_number + "/page/" + pageNum ,
            dataType: 'json' , 
            success: function(productCommentPagingCreator, status, xhr){
                if(callback) {
                    callback(productCommentPagingCreator) ;
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

        var product_number = comment.product_number ;
		console.log("registerCmt()에 전달된 product_number: " + product_number);
		
        $.ajax({
            type: "post" ,
            url: "/healthproject/productComment/" + product_number + "/new" ,
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

        var product_number = reply.product_number ;
        var preply_number = reply.preply_number ;

        $.ajax({
            type: "post" ,
            url: "/healthproject/productComment/" + product_number + "/" + preply_number + "/new" ,
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

        var product_number = read.product_number ;
        var pcomment_number = read.pcomment_number ;
		console.log("getCmtReply() 전달받은 product_number: " + product_number);
		console.log("getCmtReply() 전달받은 pcomment_number: " + pcomment_number);
		console.log("getCmtReply() 함수의 특정 댓글에 조회 ajax 처리 시작......");

        $.get("/healthproject/productComment/" + product_number + "/" + pcomment_number + ".json",
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
    
        var product_number = comment.product_number ;
        var pcomment_number = comment.pcomment_number ;
		console.log("modifyCmtReply() 전달받은 product_number: " + product_number + " 전달받은 pcomment_number: " + pcomment_number);
		console.log("modifyCmtReply() 함수의 특정 댓글 수정 ajax 처리 시작......");
		
        $.ajax({
            type: "put" ,
            url: "/healthproject/productComment/" + product_number + "/" + pcomment_number,
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

        var product_number = comment.product_number ;
        var pcomment_number = comment.pcomment_number ;
        var pcomment_writer = comment.pcomment_writer ;

        $.ajax({
            type: "delete" ,
            url: "/healthproject/productComment/" + product_number + "/" + pcomment_number,
            data: JSON.stringify({product_number: product_number, pcomment_number: pcomment_number, pcomment_writer: pcomment_writer}),
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
    function removeAllComment(product_number, callback, error) {
        
        $.ajax({
            type: "delete" ,
            url: "/healthproject/productComment/" + product_number ,
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
    
 })();  //pcommentClsr-end 
        