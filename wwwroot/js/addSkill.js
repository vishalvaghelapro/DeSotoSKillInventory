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



//const emailInput = document.getElementById("email");
//const placeholderDomain = "@desototechnologies.com"; // Placeholder domain text

//// Set initial value with placeholder (optional)
//emailInput.value = "user" + placeholderDomain;

//// Disable text selection (partially prevents editing)
//emailInput.addEventListener("select", (event) => event.preventDefault());
//emailInput.addEventListener("select", (event) => event.preventDefault());

//// Improved input handling
//emailInput.addEventListener("input", () => {
//    const newChar = emailInput.value.slice(-1);

//    // Allowed characters before "@"
//    //onst patern = /^[a-zA-Z0-9._%+-]+@(?!.*\.\.)(?!.*\.$)[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    
//    const allowedCharsBeforeAt = /^[a-zA-Z0-9._%+-]+@(?!.*\.\.)(?!.*\.$)[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // Updated regex for alphabets, numbers, periods, and underscores

//    // Extract and validate the username
//    let username = emailInput.value.slice(0, -placeholderDomain.length); // Extract username without placeholder
//    if (!allowedCharsBeforeAt.test(username)) {
//        // Prevent adding invalid characters (if symbol entered)
//        emailInput.value = username + placeholderDomain; // Restore placeholder
//    }

//    // Handle user input to maintain a valid email format
//    if (newChar === "@") {
//        // Prevent adding "@" as it's already part of the placeholder
//        emailInput.value = emailInput.value.slice(0, -1); // Remove "@"

//        // You can optionally display an error message here
//    } else {
//        // If user types a valid character before "@" or within the domain:
//        if (allowedCharsBeforeAt.test(newChar) ||
//            (emailInput.value.endsWith(placeholderDomain) &&
//                newChar !== "@" &&
//                allowedCharsInDomain.test(newChar))) {
//            // Allow regular typing for username and valid characters in the domain
//        } else {
//            // Prevent invalid characters
//            emailInput.value = emailInput.value.slice(0, -1); // Remove the invalid character
//        }
//    }
//});

//// Updated allowed characters for the domain (excluding period)
//const allowedCharsInDomain = /[a-zA-Z0-9-]/; // Allow letters, numbers and hyphens (-)

//const submitButton = document.getElementById("submitButton");
//submitButton.addEventListener("click", () => {
//    const emailValue = document.getElementById("email").value;
//    console.log("Email entered:", emailValue);
//});

//// Call the fixEmailDomain function after the DOM is loaded
//window.addEventListener("DOMContentLoaded", fixEmailDomain);