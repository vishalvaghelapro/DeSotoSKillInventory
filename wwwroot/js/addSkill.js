﻿$("form").submit(function (e) {
    e.preventDefault();

    // Get form elements
    var name = $("input[name='name']").val();
    var proficiency = $("input[name='proficiency']:checked").val();

    // Validate proficiency selection
    if (!proficiency) {
        // Proficiency not selected, show error message
        $('.invalid-tooltip').show(); // Show all tooltips in case user didn't tab through
        return false; // Prevent form submission
    }

    // Proficiency selected, proceed with form submission logic
    $(".data-table tbody").append("<tr data-name='" + name + "' data-proficiency='" + proficiency + "'><td>" + name + "</td><td>" + proficiency + "</td><td><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td></tr>");

    $("input[name='name']").val('');
    $("input[name='proficiency']").prop('checked', false); // Clear radio button selection

    // Hide tooltips after successful submission (optional)
    $('.invalid-tooltip').hide();
});
$("body").on("click", ".btn-delete", function () {
    $(this).parents("tr").remove();
});

function AddSkill() {
    //var keys = [], arrayObj = [];
    //$("#table thead tr th").each(function () {
    //    keys.push($(this).html());
    //});

    //$("#table tbody tr").each(function () {
    //    var obj = {}, i = 0;
    //    $(this).children("td").each(function () {
    //        obj[keys[i]] = $(this).html();
    //        i++;
    //    })
    //    arrayObj.push(obj);
    //});
    //$('body').append(JSON.stringify({ yourObj: arrayObj }));
    //return;//remove this line


    const tableRows = document.getElementById("myForm").getElementsByTagName("tr");
    let employeeId = sessionStorage.getItem('UserId');
    //console.log(EmployeeId);
    // 2. Create an empty array to store objects:
    const skillData = [];

    // 3. Loop through each table row:
    for (let i = 1; i < tableRows.length; i++) { // Start from index 1 to skip the header row
        const row = tableRows[i];

        // 4. Create an object for each row:
        const skillObject = {
            //EmployeeId,
            SkillName: row.cells[0].textContent, // Assuming "SkillName" is in the first cell (index 0)
            ProficiencyLevel: row.cells[1].textContent
            // Assuming "Proficiency" is in the second cell (index 1)
        };

        // 5. Add the object to the skillData array:

        skillData.push(skillObject);



    }
    var employee = {
        EmployeeId: employeeId,
        // Other employee details
        SkillList: skillData
    };
    $.ajax({
        type: "POST",
        url: '/Employee/AddSkill',
        data: employee,
        contentType: 'application/x-www-form-urlencoded;charset=utf-8;',
        dataType: "json",
        success: function (response) {

        }
    })

}


function updateEmail() {
    const username = document.getElementById("Email").value;
    const domain = "@domain"; // Replace "@domain" with your actual domain name
    const email = username + domain;
    document.getElementById("Email").value = email;
}
$('#Email').bind("cut copy paste", function (e) {
    e.preventDefault();
});
