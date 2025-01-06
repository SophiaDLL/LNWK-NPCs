window.addEventListener('message', function (event) {
    const data = event.data;

    if (data.update === 'true') {
        document.getElementById('groups-container').style.display = 'block';
        $.post(`https://${GetParentResourceName()}/open`);
    } else {
        document.getElementById('groups-container').style.display = 'none';
        $.post(`https://${GetParentResourceName()}/close`);
    }
});

$(document).on("click", "#close-btn", function () {
    closeMenu();
});

document.onkeyup = function (data) {
    if (data.key == 'Escape') {
        closeMenu();
    }
};

function closeMenu() {
    document.getElementById('groups-container').style.display = 'none';
    $.post(`https://${GetParentResourceName()}/close`);
}

const copyToClipboard = str => {
    console.log('Copying to clipboard: ' + str);
    const el = document.createElement('textarea');
    el.value = str;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
};

$(document).on("click", "#submit-btn", function () {
   console.log("Submit button pressed");
});

$(document).on("click", "#ped-type-btn", function () {
    $('#ped-type-modal').show();
});

$(document).on("click", "#ped-model-btn", function () {
    $('#ped-model-modal').show();
});

$(document).on("click", "#gender-btn", function () {
    $('#gender-modal').show();
});

$(document).on("click", "#animation-type-btn", function () {
    $('#animation-type-modal').show();
});

$(document).on("click", ".close-modal", function () {
    $(this).closest('.feature-modal').hide();
});

$(".modal-btn").on("click", function () {
    const selectedOption = $(this).text();
    const buttonId = $(this).attr("data-button-id");

    $("#" + buttonId).text("Selected: " + selectedOption);

    $(this).closest('.feature-modal').hide();
});

// Close the panel when the Submit button is clicked
$(document).on("click", "#submit-btn", function () {
    closeMenu();
});
