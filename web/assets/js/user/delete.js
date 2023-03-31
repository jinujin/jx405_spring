
let deleteUser = (id) => {
    // let id = new URLSearchParams(window.location.search).get("id");
    let data = {
        "id": id
    }
    Swal.fire({
        title : '회원 탈퇴를 하시겠습니까?',
        showCancelButton : true,
        confirmButtonText: "탈퇴",
        cancelButtonText: "취소",
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire({
                title: '기존 비밀번호',
                input: 'password',
                inputLabel: '기존 비밀번호를 입력해주세요.',
                inputPlaceholder: '기존 비밀번호',
                inputAttributes: {
                    maxlength: 30,
                    autocapitalize: 'off',
                    autocorrect: 'off'
                }
            }).then((oldPassword) => {
                data["oldPassword"] = oldPassword.value;
                $.ajax({
                    url:"/user/delete"+id,
                    method: "get",
                    data : data,
                    success: function (message) {
                        let result = (JSON).parse(message);
                        if (result.status == "success") {
                            console.log(result.nextPath);
                            Swal.fire({
                                title: result.content,
                                text: result.message,
                                icon: result.status
                            }).then(() => {
                                location.href = result.nextPath;
                            });
                        } else {
                            console.log(result.nextPath);
                            Swal.fire({
                                title: result.content,
                                text: result.message,
                                icon: result.status
                            }).then(() => {
                                location.href = result.nextPath;
                            });
                        }
                    }
                });
            });

        }
    })




}