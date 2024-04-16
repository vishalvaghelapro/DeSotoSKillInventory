$("form").submit(function (e) {
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
    var objData = {};
    var rows = document.querySelectorAll('tr');
    for (var i = 1; i < rows.length; i++) {
        var cells = rows[i].querySelectorAll('td');
        var skillName = cells[0].textContent.trim();
        var proficiencyLevel = cells[1].textContent.trim();
        objData[skillName] = proficiencyLevel;
    }
    console.log(objData);
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
