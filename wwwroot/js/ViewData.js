$(document).ready(function () {
    getEmpData();
    $.fn.dataTable.ext.errMode = 'throw';
});
function getEmpData(res) {
    $.ajax({
        url: '/Employee/GetEmpData',
        type: 'Get',
        dataType: 'json',
        success: OnSuccess,

    })

}


function OnSuccess(response) {
    var employee = response[0]; // Access the first (and only) employee object
    var skills = employee.skillList;

    $('#empDataTable').DataTable({
        bProcessing: true,
        blenghtChange: true,
        lenghtMenu: [[5, 10, 15, -1], [5, 10, 15, "All"]],
        bfilter: true,
        bSort: true,
        bPaginate: true,
        data: skills,
        buttons: [
            {
                text: 'Create new record',
                action: () => {
                    // Create new record
                    editor.create({
                        title: 'Create new record',
                        buttons: 'Add'
                    });
                }
            }
        ],

        columns: [
            //{
            //    "data": 'employeeSkillId',
              
            //},

            //{
            //    data: null,
     
            //    render: function (data, type, row) {
            //        return employee.employeeId; // Use employee object for ID
            //    }

            //},
            {
                data: null,
                render: function (data, type, row) {
                    return employee.firstName +" "+ employee.lastName
                }

            },
           
            {
                data: null,
                render: function (data, type, row) {
                    return employee.email
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    return employee.department
                }
            },

            {
                data: null,
                render: function (data, type, row) {
                    return employee.role
                }


            },
            {
                "data": 'proficiencyLevel',
            },
            {
                "data": 'skillName',
            },
            {
                data: null,

                render: function (row) {
                    if (sessionStorage.getItem("Role") !== 'RW1wbG95ZWU=') { // Check for 'Employee' role
                        // Use template literals for cleaner string construction
                        return `
                    <a href='#' class='btn btn-primary' onclick="EditBtn(${row.employeeSkillId})";>
                        <i class="bi bi-pen"></i>
                    </a>
                  `;
                    } else {
                        // Hide the form element (assuming it's outside this function's scope)
                        document.getElementById("form").style.display = "none";
                        return ""; // Return nothing for 'Employee' role
                    }
                }
            }, 

            {
                data: null,

                render: function (row) {
                    if (sessionStorage.getItem("Role") !== 'RW1wbG95ZWU=') { // Check for 'Employee' role
                        // Use template literals for cleaner string construction
                        return `
                    <a href='#' id='BtnDelete' class='btn btn-danger' onclick="DeleteBtn(${row.employeeSkillId})">
                      <i class="bi bi-trash"></i>
                    </a>
                  `;
                    } else {
                        // Hide the form element (assuming it's outside this function's scope)
                        document.getElementById("form").style.display = "none";
                        return ""; // Return nothing for 'Employee' role
                    }
                }
            },
        ]
    });

}

function EditBtn(employeeSkillId) {

    $.ajax({
        url: '/Employee/EditEmp?id=' + employeeSkillId,
        type: 'Get',
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (res) {


            $.each(res, function (index, item) {
                $("#EmployeeMadal").modal('show');
                $("#ESId").val(item.employeeSkillId);
                $("#SkillName").val(item.skillName);
                $("input[name='Proficiency'][value='" + item.proficiencyLevel + "']").prop("checked", true);
                $('#UpdateBtn');
            });
        },
        error: function () {
            alert("Couldn't get data for EmployeeSkillID = " + employeeSkillId);
        }
    })
}
function DeleteBtn(employeeSkillId) {

    $.ajax({
        url: '/Employee/DeleteEmp?id=' + employeeSkillId,
        data: {},
        success: function () {
            alert("Record Deleted!");
            window.location.reload();
            getEmpData(res);
        },
        error: function () {
            alert("Data can't be deleted!");
        }

    })

}