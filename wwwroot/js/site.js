

function AddEmpData() {

    var objData = {
        FirstName: $('#FName').val(),
        LastName: $('#LName').val(),
        Email: $('#Email').val(),
        Department: $('#DropDepartment').val(),
        roll: $('input[name="Roll"]:checked').val(),
        password: $("#Password").val()
    };
    $.ajax({
        url: '/Employee/AddEmployee',
        type: 'POST',
        data: objData,
        contentType: 'application/x-www-form-urlencoded;charset=utf-8;',
        success: function (res) {
            //$("#subitFormButton").text("Submit");
            //alert('Data Saved');
            if (res == "Error") {

            }
            else if (res == "Success") {
                if (sessionStorage.getItem("token") == null) {
                    alert("Data is Saved");
                    window.location = "/home/Login";
                }
                else {
                    window.location = "/home/EmployeeDetail";
                }
            }
            else if (res == "Error: Email already exists") {

                alert("Email Already Exist"); // Set error message

            }
            // Redirect based on login status

        },
        error: function () {
            //$("#subitFormButton").text("Submit");
            alert("Please fill required ");
        }
    });

}

function Login() {
    var objData = {
        Email: $("#email").val(),
        password: $("#Password").val()
    };
    console.log(objData);
    console.log(objData.admin_id);

    var full_name = objData.admin_id;
    var name = full_name.split(' ');
    var first_name = name[0];
    var last_name = name[1];

    objData.FirstName = first_name;
    objData.LastName = last_name;
    sessionStorage.setItem("FirstName", objData.FirstName),
        sessionStorage.setItem("LastName", objData.LastName),

        $.ajax({
            url: '/Login/AdminLogin',
            type: 'Post',
            data: objData,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8;',
            success: function (res) {

                if (res.objRoll != null & res.oblogin != null) {
                    sessionStorage.setItem("token", res.oblogin),
                        headerToken = res.oblogin;
                    sessionStorage.setItem("Role", res.objRoll),
                        RoleDecrypt();
                    function RoleDecrypt() {
                        var objAuth = {
                            Oblogin: sessionStorage.getItem("token", res.oblogin),
                            ObjRoll: sessionStorage.getItem("Role", res.objRoll),
                        };
                        $.ajax({
                            url: '/Login/RoleDecrypt',
                            type: 'Post',
                            dataType: 'json',
                            data: objAuth,
                            contentType: 'application/x-www-form-urlencoded;charset=utf-8;',
                            success: function (role) {
                                if (role === "Employee") {
                                    $.ajax({
                                        url: '/Home/EmployeeDetails',
                                        type: 'Get',
                                        data: headerToken,
                                        headers: {
                                            'Authorization': 'Bearer ' + headerToken
                                            //"Authorization": "Bearer your_access_token"
                                        },

                                    })

                                    window.location = "/home/EmployeeDetail";
                                    //$("Welcome").val(alert("Login Successed"));

                                }
                                else if (role === "Admin") {
                                    //EmpDetails(res);
                                    location.href = "/home/EmployeeDetail";
                                    //history.pushState(null, null, "/home/EmployeeDetail");
                                    //$("Welcome").val(alert("Login Successed"));
                                }
                                else {
                                    alert("User Doesn't Exit");
                                    isSessionStorageClear();
                                }
                                $("Welcome").val(alert("Login Successed"));
                                window.location = "/home/EmployeeDetail";
                            }
                        });
                    }
                }
                else if (res.objRoll == null & res.oblogin == null) {
                    alert('Login Failed');
                    isSessionStorageClear();
                    sessionStorage.clear();
                }
                else {
                    alert('Something Went Wrong!');
                    isSessionStorageClear();
                }

            },
            error: function () {
                alert("Invalid username or password!");
            }
        });

}
