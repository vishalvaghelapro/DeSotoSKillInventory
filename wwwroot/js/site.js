
$(document).ready(function () {
    $("#Email").on("blur", function () {
        var email = $(this).val();
        var regex = /^.*@desototechnologies.com$/;

        if (!regex.test(email)) {
            $(this).addClass("invalid");
            $(this).next().text("Please enter a valid email ending with @desotoTechnologies.com");
            $("#myForm button").prop("disabled", true); // Disable submit button
        } else {
            $(this).removeClass("invalid");
            $(this).next().text("Submit");
            $("#myForm button").prop("disabled", false); // Enable submit button
        }
    });
});

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
          
                    $("#emailerror").text(response.message || "Email Already exist"); // Set error message
               
            }
            // Redirect based on login status

        },
        error: function () {
            //$("#subitFormButton").text("Submit");
            alert("Please fill required ");
        }
    });

}

$(document).ready(function () {
  

    // Add validation for email format
    $("#Email").keyup(function () {
        var email = $(this).val();
        var regex = /^([a-zA-Z0-9_\-\.]+)@desotoTechnologies\.com$/;
        if (!regex.test(email)) {
            $(this).siblings(".invalid-tooltip").text("Please enter a valid email address ending with @desotoTechnologies.com");
        } else {
            $(this).siblings(".invalid-tooltip").text("");
        }
    });
});
