<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>

<!-- Page content-->
<div class="container-fluid">
    <h1>BOARD READ</h1>

    <form action="/board/remove" method="post" class="deleteForm">
        <div class="card-body">
            <div class="input-group mb-3">
                <span class="input-group-text">BNO</span>
                <input type="text" name="bno" class="form-control" value="<c:out value="${boardDTO.bno}"></c:out>"
                       readonly>
            </div>

            <div class="input-group mb-3">
                <span class="input-group-text">Title</span>
                <input type="text" name="title" class="form-control" value="<c:out value="${boardDTO.title}"></c:out>"
                       readonly>
            </div>

            <div class="input-group mb-3">
                <span class="input-group-text">Writer</span>
                <input type="text" name="writer" class="form-control" value="<c:out value="${boardDTO.writer}"></c:out>"
                       readonly>
            </div>

            <div class="input-group">
                <span class="input-group-text">Content</span>
                <textarea class="form-control" aria-label="With textarea" name="content" rows="4" disabled>
                <c:out value="${boardDTO.content}"></c:out>
            </textarea>
            </div>

            <div class="my-4">
                <div class="float-end">
                    <button type="submit" class="btn btn-primary btnList">LIST</button>
                    <button type="button" class="btn btn-warning btnMod">MODIFY</button>
                    <button type="submit" class="btn btn-danger btnDel">DELETE</button>
                </div>
            </div>

            <!--파일목록-->
            <div>
                <c:forEach items="${boardDTO.files}" var="attach">
                    <div>
                        <c:if test="${attach.image}">
                            <img src="/viewFile?file=${attach.getThumbnail()}">
                        </c:if>
                        <span>${attach.fileName}</span>
                    </div>
                </c:forEach>
            </div>

        </div>
    </form>
</div>
</div>

<form id="actionForm" action="/board/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<%@ include file="../includes/footer.jsp" %>

<script>

    const actionForm = document.querySelector("#actionForm")
    const form = document.querySelector(".deleteForm")

    document.querySelector(".btnList").addEventListener("click", () => {
        actionForm.submit()
    }, false)

    document.querySelector(".btnMod").addEventListener("click", () => {

        const bno = '${boardDTO.bno}'

        actionForm.setAttribute("action", "/board/modify")
        actionForm.innerHTML += `<input type='hidden' name='bno' value='\${bno}'>`
        actionForm.submit()

    }, false)

    document.querySelector(".btnDel").addEventListener("click", (e) => {

        form.setAttribute("action", "/board/remove")
        form.innerHTML += `<input type='hidden' name='bno' value='\${bno}'>`
        form.submit()

    }, false)

</script>