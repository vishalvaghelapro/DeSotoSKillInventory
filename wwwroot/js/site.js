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
        type: 'POST', // Ensure it's POST for creating data
        data: objData,
        contentType: 'application/x-www-form-urlencoded;charset=utf-8;',
        success: function (res) {
       77     //$("#subitFormButton").text("Submit");
            //alert('Data Saved');
            if (res == "Error") {

            }
            else if (res == "Success"){
                if (sessionStorage.getItem("token") == null) {
                    alert("Data is Saved");
                    window.location = "/home/Login";
                }
                else {
                    window.location = "/home/EmployeeDetail";
                }
            }

            // Redirect based on login status

        },
        error: function () {
            //$("#subitFormButton").text("Submit");
            alert("Please fill required ");
        }
    });

}


