async function submitUpdate() {
    let id = new URLSearchParams(window.location.search).get("id");
    let nickname = $('input[name="nickname"]').val();
    let password = $('input[name="password"]').val();
    let email = $('input[name="email"]').val();

    let data = {
        "nickname": nickname,
        "password": password,
        "email": email,
        "id": id
    };

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
            url: "/member/update",
            method: "post",
            data: data,
            success: function (message) {
                let result = JSON.parse(message);

                if (result.status == 'success') {
                    Swal.fire({title: result.content, text: result.message, icon: "success"}).then(() => {
                        location.href = result.nextPath;

                    });
                } else {
                    Swal.fire({title: result.content, text: result.message, icon: "warning"}).then(() => {
                        location.href = result.nextPath;
                    });
                }
            }
        })
    })

}
