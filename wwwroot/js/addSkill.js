$("form").submit(function (e) {
    e.preventDefault();
    var name = $("input[name='name']").val();
    var proficiency = $("input[name='proficiency']:checked").val();

    $(".data-table tbody").append("<tr data-name='" + name + "' data-proficiency='" + proficiency + "'><td>" + name + "</td><td>" + proficiency + "</td><td><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td></tr>");

    $("input[name='name']").val('');
    $("input[name='proficiency']").val();
});

$("body").on("click", ".btn-delete", function () {
    $(this).parents("tr").remove();
});
