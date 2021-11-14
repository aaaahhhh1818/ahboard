<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>

<!-- Page content-->
<div class="container-fluid">
    <h1>BOARD MODIFY</h1>

    <div class="card-body">

        <form id="form1"> <%--실제로 날라가는애--%>
            <input type="hidden" name="page" value="${pageRequestDTO.page}">
            <input type="hidden" name="size" value="${pageRequestDTO.size}">

            <c:if test="${pageRequestDTO.type != null}">
                <input type="hidden" name="type" value="${pageRequestDTO.type}">
                <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
            </c:if>

            <div class="input-group mb-3">
                <span class="input-group-text">BNO</span>
                <input type="text" name="bno" class="form-control" value="<c:out value="${boardDTO.bno}"></c:out>"
                       readonly>
            </div>

            <div class="input-group mb-3">
                <span class="input-group-text">Title</span>
                <input type="text" name="title" class="form-control" value="<c:out value="${boardDTO.title}"></c:out>">
            </div>

            <div class="input-group mb-3">
                <span class="input-group-text">Writer</span>
                <input type="text" name="writer" class="form-control"
                       value="<c:out value="${boardDTO.writer}"></c:out>">
            </div>

            <div class="input-group">
                <span class="input-group-text">Content</span>
                <textarea class="form-control" aria-label="With textarea" name="content" rows="4">
                <c:out value="${boardDTO.content}"></c:out>
            </textarea>
            </div>

            <div class="temp">

            </div>

            <div class="my-4">
                <div class="float-end">
                    <button type="submit" class="btn btn-primary btnList">LIST</button>
                    <button type="button" class="btn btn-warning btnMod">MODIFY</button>
                </div>
            </div>
        </form>

        <!--파일목록-->
        <div class="card-header">File Input</div>
        <div class="card-body">
            <div class="custom-file">
                <input type="file" name="uploadFiles" id="exampleInputFile" multiple>
            </div>
            <div class="input-group-append">
                <span class="btn btn-primary" id="uploadBtn">Upload</span>
            </div>
        </div>

        <div class="uploadResult">
            <c:forEach items="${boardDTO.files}" var="attach">
                <div data-uuid="${attach.uuid}" data-filename="${attach.fileName}" data-uploadpath="${attach.uploadPath}" data-image="${attach.image}">
                    <c:if test="${attach.image}">
                        <img src="/viewFile?file=${attach.getThumbnail()}">
                    </c:if>
                    <span>${attach.fileName}</span>
                    <button onclick="javascript:removeDiv(this)">x</button>
                </div>
            </c:forEach>
        </div>

    </div>
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

    const form = document.querySelector("#form1")
    const actionForm = document.querySelector("#actionForm")

    document.querySelector(".btnList").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        actionForm.submit();
    },false)

    document.querySelector(".btnMod").addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()

        const fileDivArr = uploadResultDiv.querySelectorAll("div") //배열의 크기가 첨부파일 개수임

        if(fileDivArr && fileDivArr.length > 0) { //div 값이 있을 때만 의미있는 코드 !

            let str = ""
            for (let i = 0; i < fileDivArr.length; i++) {
                const target = fileDivArr[i]
                const uuid = target.getAttribute("data-uuid")
                const fileName = target.getAttribute("data-filename")
                const uploadPath = target.getAttribute("data-uploadpath")
                const image = target.getAttribute("data-image")

                str += `<input type='hidden' name='files[\${i}].uuid' value='\${uuid}'>`
                str += `<input type='hidden' name='files[\${i}].fileName' value='\${fileName}'>`
                str += `<input type='hidden' name='files[\${i}].uploadPath' value='\${uploadPath}'>`
                str += `<input type='hidden' name='files[\${i}].image' value='\${image}'>`
            }
            document.querySelector(".temp").innerHTML = str
        }//end if


        //얘네는 첨부파일 없어도 존재 해야함
        form.setAttribute("action","/board/modify")
        form.setAttribute("method","post")

        form.submit()

    },false)

</script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>

    const uploadResultDiv = document.querySelector(".uploadResult")

    document.querySelector("#uploadBtn").addEventListener("click", (e) => {

        const formData = new FormData()
        const fileInput = document.querySelector("input[name='uploadFiles']")

        for(let i = 0; i < fileInput.files.length; i++) {
            formData.append("uploadFiles", fileInput.files[i])
        }

        console.dir(formData)

        const headerObj = { headers: {'Content-Type': 'multipart/form-data'}} //헤더 정보 보내는거

        axios.post("/upload", formData, headerObj).then((response) => {
            const arr = response.data
            console.log(arr)
            let str = ""
            for(let i = 0; i < arr.length; i++) {

                const {uuid, fileName, uploadPath, image, thumbnail, fileLink} = {...arr[i]} //스프레드 연산자 써서 값 꺼냄

                if(image) {
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <img src="/viewFile?file=\${thumbnail}"/><span>\${fileName}</span>
                            <button onclick="javascript:removeDiv(this)">x</button></div>`
                }else {
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <a href="/downFile?file=\${fileLink}">\${fileName}</a><button onclick="javascript:removeDiv(this)">x</button></div>`
                }

            }//enf for
            uploadResultDiv.innerHTML += str
        })
    }, false)

    function removeDiv(ele) {
        ele.parentElement.remove()
    }

</script>