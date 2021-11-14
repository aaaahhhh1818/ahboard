<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>

<!-- Page content-->
<div class="container-fluid">
    <h1>BOARD REGISTER</h1>

    <div class="card-body">
        <form id="form1" action="/board/register" method="post">
            <div class="input-group mb-3">
                <span class="input-group-text">Title</span>
                <input type="text" name="title" class="form-control" placeholder="Title">
            </div>

            <div class="input-group mb-3">
                <span class="input-group-text">Writer</span>
                <input type="text" name="writer" class="form-control" placeholder="Writer">
            </div>

            <div class="input-group">
                <span class="input-group-text">Content</span>
                <textarea class="form-control" aria-label="With textarea" name="content" rows="4"></textarea>
            </div>

            <div class="temp">

            </div>

            <div class="card-footer">
                <div class="float-end">
                    <button type="submit" id="submitBtn" class="btn btn-primary">SUBMIT</button>
                </div>
            </div>
        </form>
    </div>

    <!--파일업로드-->
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

    </div>


</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>

    const uploadResultDiv = document.querySelector(".uploadResult")

    document.querySelector("#uploadBtn").addEventListener("click", (e) => {

        const formData = new FormData()
        const fileInput = document.querySelector("input[name='uploadFiles']")

        for (let i = 0; i < fileInput.files.length; i++) {

            formData.append("uploadFiles", fileInput.files[i])

        }

        console.dir(formData)

        const headerObj = {headers: {'Content-Type': 'multipart/form-data'}}

        axios.post("/upload", formData, headerObj).then((response) => {
            const arr = response.data
            console.log(arr)
            let str = ""
            for (let i = 0; i < arr.length; i++) {

                const {uuid, fileName, uploadPath, image, thumbnail, fileLink} = {...arr[i]}

                if (image) {
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <img src="/viewFile?file=\${thumbnail}"/><span>\${fileName}</span>
                            <button onclick="javascript:removeFile('\${fileLink}',this)">x</button></div>`
                } else {
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <a href="/downFile?file=\${fileLink}">\${fileName}</a><button onclick="javascript:removeFile('\${fileLink}',this)">x</button></div>`
                }

            }//enf for
            uploadResultDiv.innerHTML += str

        })


    }, false)

    function removeFile(fileLink, ele) {
        console.log(fileLink)
        axios.post("/removeFile", {fileName: fileLink}).then(response => {
            const targetDiv = ele.parentElement
            targetDiv.remove()
        })
    }

    const form1 = document.querySelector("#form1")

    document.querySelector("#submitBtn").addEventListener("click", (e) => {
        e.stopPropagation()
        e.preventDefault()

        const fileDivArr = uploadResultDiv.querySelectorAll("div")

        if (!fileDivArr) {
            form1.submit()
            return
        }

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
        form1.submit()
    }, false)

</script>

<%@ include file="../includes/footer.jsp" %>