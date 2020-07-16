<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>인덱스를 만들어 보자</title>

    <link href="${pageContext.request.contextPath }/resources/css/bootstrap.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
	
	
</head>
<body>

	<%@ include file="../include/header.jsp" %>
   	<!--게시판-->
    <section>
        <div class="container-fluid">
            <div class="row">
                <!--lg에서 9그리드, xs에서 전체그리드-->   
                <div class="col-lg-9 col-xs-12 board-table">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    <hr>
                    
                    <select onchange="change(this)">
						<option value="10" ${pageVO.amount==10? 'selected':''}>10개 보기</option>
						<option value="15" ${pageVO.amount==15? 'selected':''}>15개 보기</option>
						<option value="20" ${pageVO.amount==20? 'selected':''}>20개 보기</option>
						<option value="50" ${pageVO.amount==50? 'selected':''}>50개 보기</option>
						<option value="100" ${pageVO.amount==100? 'selected':''}>100개 보기</option>					
					</select>
                  
 	         		<span>총 ${pageVO.total}</span>
                    
                    <!--form select를 가져온다 -->
                    <form action="freeList">                    
			    		<div class="search-wrap">			    		   
			    			<span>총${pageVO.total}</span>
	                       <button type="submit" class="btn btn-info search-btn">검색</button>
	                       <input type="text" class="form-control search-input" name="searchName" value="${pageVO.cri.searchName }">
	                       <select class="form-control search-select" name="searchType">
	                            <option value="title" ${pageVO.cri.searchType eq 'title' ? 'selected' : '' }>제목</option>
	                            <option value="content" ${pageVO.cri.searchType eq 'content' ? 'selected' : ''  }>내용</option>
	                            <option value="writer" ${pageVO.cri.searchType eq 'writer' ? 'selected' : ''  }>작성자</option>
	                            <option value="titcont"  ${pageVO.cri.searchType eq 'titcont' ? 'selected' : ''  }>제목+내용</option>
	                       </select>
	                    </div>
	                    
	                    <input type="hidden" name="pageNum" value="1">
	                    <input type="hidden" name="amount" value="${pageVO.cri.amount }">
	                    
		   			 </form>
                   
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th class="board-title">제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="vo" items="${boardList}" >
	                            <tr>
	                                <td>${vo.bno }</td>
	                                <td><a href="freeDetail?bno=${vo.bno}">${vo.title}</a></td>
	                                <td>${vo.writer}</td>
	                                <td><fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	                                <td><fmt:formatDate value="${vo.updatedate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	                            </tr>
                            </c:forEach>
                        </tbody>
                        
                    </table>


                    <!--페이지 네이션을 가져옴-->
		    <form action="freeList" name="pageForm">
                    <div class="text-center">
                    <hr>
<%--                     <ul class="pagination pagination-sm">
                        		<!-- 2. 이전버튼 활성화 여부 -->
								<c:if test="${pageVO.prev }">
									<li><a href="freeList?pageNum=${pageVO.startPage -1 }&amount=${pageVO.amount}">이전</a></li>
								</c:if>	
                        		<!-- 1. 페이지 번호처리 -->
								<c:forEach var="num" begin="${pageVO.startPage }" end="${pageVO.endPage }">
									<li class="${num == pageVO.pageNum ? 'active' : '' }"><a href="freeList?pageNum=${num }&amount=${pageVO.amount}">${num }</a></li>
								</c:forEach>
                        		<!-- 3. 다음버튼 활성화 여부 -->
								<c:if test="${pageVO.next }">
									<li><a href="freeList?pageNum=${pageVO.endPage + 1 }&amount=${pageVO.amount}">다음</a></li>
								</c:if>
                    </ul> --%>
                    
                     <ul class="pagination pagination-sm" id="pagenation">
                        		<!-- 2. 이전버튼 활성화 여부 -->
								<c:if test="${pageVO.prev }">
									<li><a href="#" data-pageNum="${pageVO.startPage-1 }">이전</a></li>
								</c:if>	
                        		<!-- 1. 페이지 번호처리 -->
								<c:forEach var="num" begin="${pageVO.startPage }" end="${pageVO.endPage }">
									<li class="${num == pageVO.pageNum ? 'active' : '' }">
									<a href="#" data-pageNum="${num }">${num }</a></li>
								</c:forEach>
                        		<!-- 3. 다음버튼 활성화 여부 -->
								<c:if test="${pageVO.next }">
									<li><a href="#" data-pageNum="${pageVO.endPage+1 }">다음</a></li>
								</c:if>
                    </ul>
                    <input type="hidden" name="pageNum" value="">
                    <input type="hidden" name="amount" value="10">
                    <input type="hidden" name="searchType" value="">
                    <input type="hidden" name="searchName" value="">
                    
                    <button type="button" class="btn btn-info" onclick="location.href='freeRegist'">글쓰기</button>
                    </div>
		    </form>

                </div>
            </div>
        </div>
	</section>	
<%@ include file="../include/footer.jsp" %>

	
	<script>
		(function(){
			
			//console.log(history.state);
			
			/* '<c:out value="${msg}"></c:out>' */
			if(history.state ===''){
				return;
			}
			
			var msg = '${msg}';
			if(msg!=''){
				alert(msg);
				//(추가할 데이터, 페이지 제목, 변경할 주소) - 기존 기록을 삭제하고 새로운 기록을 추가
				//이렇게 추가된 데이터를 history.state로 확인이 가능
				history.replaceState('',null,null); 
			}
			
		})()
		//페이지 
		
		/* 
		1. 아래 페이지버튼을 A태그에 서 ->폼을 전송하고 
		2. Criteria에 검색 키워드를 추가
		3. 검색폼과, 페이지폼이 동일한 값을 가지고 넘어가도록 hidden 값을 추가		
		4. sql문을 동적쿼리로 변경 ,  total도 동적쿼리로 변경
		5. pageVO에 검색 키워드를 저장토록 처리
		6. 화면에서 페이지폼과 검색폼  select박스 키워드 처리, input 태그 키워드 처리
		7. 페이지를 이동하거나 , 검색버튼을 클릭했을 때 검색 조건이 유지 되도록 처리 
		*/
		
		
		var pagination = document.getElementById("pagenation"); 
		pagination.onclick = function(){
			event.preventDefault(); //버튼의 고유이벤트 속성 중지 	
			
		
			console.log(event.target) // 현재 대상을 알수 있음 
			console.log(event.target.dataset.pagenum) //
						
			var value = event.target.dataset.pagenum; //클릭한 타겟의 데이터셋
			document.pageForm.pageNum.value = value;//폼에 페이지넘버 타겟값 저장 
			document.pageForm.submit();
		}
		
		function change(a){			
			console.log(a.value);
			location.href='freeList?pageNum=1&amount='+a.value; 
		}
		
	</script>
</body>
</html>

