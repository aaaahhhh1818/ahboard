<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>

<!-- Page content-->
<div class="container-fluid">
    <h1>BOARD LIST</h1>

    <button type="button" class="btn btn-outline-primary"><a href="/board/register">register</a></button>

    <div class="card-body">

        <!-- 검색처리 -->
        <form action="/board/list" method="get">
            <div class="float-end">
                <input type="hidden" name="page" value="1">
                <input type="hidden" name="size" value="${pageMaker.size}">
                <div class="form-group">
                    <select name="type" class="custom-select">
                        <option value="">---</option>
                        <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                        <option value="TC" ${pageRequestDTO.type=="TC"?"selected":""}>제목&내용</option>
                        <option value="W" ${pageRequestDTO.type=="W"?"selected":""}>작성자</option>
                        <option value="C" ${pageRequestDTO.type=="C"?"selected":""}>내용</option>
                        <option value="TCW" ${pageRequestDTO.type=="TCW"?"selected":""}>제목&내용&작성자</option>
                    </select>
                </div>
                <input type="text" name="keyword" value="${pageRequestDTO.keyword}">
                <span class="input-group-append"><button type="submit" class="btn btn-primary">Search</button></span>
            </div>
        </form>

        <!--게시물목록-->
        <table class="table">
            <thead>
            <tr>
                <th scope="col">BNO</th>
                <th scope="col">TITLE</th>
                <th scope="col">WRITER</th>
                <th scope="col">REGDATE</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${dtoList}" var="dto">
                <tr>
                    <td><c:out value="${dto.bno}"></c:out></td>
                    <td><a href="javascript:moveRead(${dto.bno})"><c:out value="${dto.title}"></c:out></a></td>
                    <td><c:out value="${dto.writer}"></c:out></td>
                    <td><c:out value="${dto.regDate}"></c:out></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!--페이징-->
    <div class="d-flex justify-content-center">
        <ul class="pagination">
            <c:if test="${pageMaker.prev}">
                <li class="page-item"><a class="page-link"
                                         href="javascript:movePage(${pageMaker.start -1})"> 《 </a>
                </li>
            </c:if>

            <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="num">
                <li class="page-item ${pageMaker.page ==num?'active':''}"><a class="page-link"
                                                                             href="javascript:movePage(${num})">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next}">
                <li class="page-item"><a class="page-link"
                                         href="javascript:movePage(${pageMaker.end +1})"> 》 </a>
                </li>
            </c:if>
        </ul>
    </div>

</div>

</div>

<form id="actionForm" action="/board/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<%@ include file="../includes/footer.jsp" %>

<script>

    const actionForm = document.querySelector("#actionForm")

    function movePage(pageNum) {

        actionForm.querySelector("input[name='page']").setAttribute("value", pageNum)

        actionForm.submit()

    }

    function moveRead(bno) {

        actionForm.setAttribute("action", "/board/read")
        actionForm.innerHTML += `<input type='hidden' name='bno' value='\${bno}'>`
        actionForm.submit()

    }

</script>