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

// Function to get player position and heading
function getPlayerPosition() {
    return new Promise((resolve, reject) => {
        // Request the player's position and heading from the client
        fetch(`https://${GetParentResourceName()}/getPlayerPosition`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resolve(data.position); // Return the vector4 data (x, y, z, heading)
                } else {
                    reject('Error retrieving player position');
                }
            })
            .catch(reject);
    });
}

function submitPed() {
    // Get name from input field
    pedData.name = $("#name").val();

    // Send a message to Lua to get player coordinates and heading
    fetch(`https://${GetParentResourceName()}/getPlayerCoords`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' }
    })
    .then(resp => resp.json())
    .then(data => {
        // Add coordinates and heading to pedData
        pedData.coords = {
            x: data.x,
            y: data.y,
            z: data.z,
            h: data.h
        };

        // Send the pedData (which now includes coordinates) to the server to spawn the NPC
        fetch(`https://${GetParentResourceName()}/spawnPed`, {
            method: 'POST',
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: JSON.stringify(pedData)
        }).then(resp => resp.json())
          .then(response => {
              // No console print here, simply close the menu
              closeMenu(); 
          })
          .catch(err => {
              // If there's an error, close the menu
              console.error('Error spawning ped:', err);
              closeMenu();
          });
    })
    .catch(err => {
        // If there's an error fetching player coordinates, close the menu
        console.error('Error fetching player coordinates:', err);
    });
}



