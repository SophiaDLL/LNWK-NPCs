let pedData = {
    name: undefined,
    ped: undefined,
    model: undefined,
    animation: undefined,
    gender: undefined 
};

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
    console.log('modal-btn clicked')
    const selectedOption = $(this).text();
    console.log(selectedOption);
    const buttonId = $(this).attr("data-button-id");

    $("#" + buttonId).text("Selected: " + selectedOption);

    $(this).text("Selected: " + selectedOption);

    $(this).closest('.feature-modal').hide();
});

function buttonclicked(option, btn, modal) {
    $("#" + btn).text("Selected: " + option);
    $("#" + modal).hide();

    switch(btn) {
        case "animation-type-btn":
            if (option === "Idle A") {
                pedData.animation = {
                    name: "Idle A", 
                    dictionary: "anim@mp_player_intcelebrationmale@idle_a"
                };
            } else if (option === "Idle B") {
                pedData.animation = {
                    name: "Idle B", 
                    dictionary: "anim@mp_player_intcelebrationmale@idle_b"
                };
            }
            break;
        case "gender-btn":
            pedData.gender = option;
            break;
        case "ped-model-btn":
            pedData.model = option;
            break;
        case "ped-type-btn":
            pedData.ped = option
            break;
    }
}

function submitPed() {
    pedData.name = $("#name").val();
    fetch(`https://${GetParentResourceName()}/spawnPed`, {
        method: 'POST',
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: JSON.stringify(pedData)
    }).then(resp => resp.json())
      .then(response => {
          console.log('Ped Spawned:', response);
          closeMenu(); 
      })
      .catch(err => {
          console.error('Error spawning ped:', err);
          closeMenu();
      });
}
