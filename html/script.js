let pedData = {
    name: undefined,
    ped: undefined,
    model: undefined,
    animation: undefined,
    gender: undefined,
    enableBlip: undefined,
    blipIcon: undefined
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

function buttonclicked(option, btn, modal) {
    $("#" + btn).text("Selected: " + option);
    $("#" + modal).hide();

    switch (btn) {
        case "animation-type-btn":
            if (option === "slow_clap") { // ANIMATION = SLOW CLAP
                pedData.animation = {
                    animation: "slow_clap", 
                    animationDict: "anim@mp_player_intcelebrationfemale@slow_clap"
                };
            } else if (option === "Clapping") { // ANIMATION = NORMAL **ISH** CLAP
                pedData.animation = {
                    animation: "base", 
                    animationDict: "amb@world_human_cheering@male_a"
                };
            } else if (option === "salute") { // ANIMATION =  salute
                pedData.animation = {
                    animation: "salute", 
                    animationDict: "anim@mp_player_intcelebrationmale@salute"
                };
            } else if (option === "face_palm") { // ANIMATION = face_palm
                pedData.animation = {
                    animation: "face_palm", 
                    animationDict: "anim@mp_player_intcelebrationfemale@face_palm"
                };
            } else if (option === "gangmember_stickup_loop") { // ANIMATION = gangmember_stickup_loop
                pedData.animation = {
                    animation: "gangmember_stickup_loop", 
                    animationDict: "random@countryside_gang_fight"
                };
            } else if (option === "Texting") { // ANIMATION = Texting
                pedData.animation = {
                    animation: "base", 
                    animationDict: "amb@world_human_stand_mobile@male@text@base"
                };
            } else if (option === "Crying") { // ANIMATION = Crying
                pedData.animation = {
                    animation: "console_end_loop_floyd", 
                    animationDict: "switch@trevor@floyd_crying"
                };
            } else if (option === "ICrossing") { // ANIMATION = Idle Crossing
                pedData.animation = {
                    animation: "base", 
                    animationDict: "amb@code_human_cross_road@male@base"
                };
            } else if (option === "PhoneCall") { // ANIMATION = Phone Call
                pedData.animation = {
                    animation: "cellphone_call_listen_base", 
                    animationDict: "switch@michael@bench"
                };
            } else if (option === "Shaking") { // ANIMATION = Shaking
                pedData.animation = {
                    animation: "idle", 
                    animationDict: "mp_move@prostitute@f@cokehead"
                };
            } else if (option === "Checkout") { // ANIMATION = 
                pedData.animation = {
                    animation: "try_shirt_neutral_a", 
                    animationDict: "mp_clothing@female@shirt"
                };
            } else if (option === "Smoking") { // ANIMATION = 
                pedData.animation = {
                    animation: "smoke_idle", 
                    animationDict: "timetable@gardener@smoking_joint"
                };
            } else if (option === "Pissing") { // ANIMATION = 
                pedData.animation = {
                    animation: "urinal_asifyouneededproof", 
                    animationDict: "missheist_agency3aig_23"
                };
            } else if (option === "Kneeling") { // ANIMATION = 
                pedData.animation = {
                    animation: "idle_a", 
                    animationDict: "amb@medic@standing@kneel@idle_a"
                };
            } else if (option === "TTD") { // ANIMATION = 
                pedData.animation = {
                    animation: "idle_a", 
                    animationDict: "amb@medic@standing@tendtodead@idle_a"
                };
            } else if (option === "Guard") { // ANIMATION = 
                pedData.animation = {
                    animation: "idle_e", 
                    animationDict: "amb@world_human_guard_patrol@male@idle_b"
                };
            } else if (option === "Bird") { // ANIMATION = 
                pedData.animation = {
                    animation: "wakeup", 
                    animationDict: "random@peyote@bird"
                };
            } else if (option === "ThumbsUp") { // ANIMATION = 
                pedData.animation = {
                    animation: "thumbs_up", 
                    animationDict: "anim@mp_player_intcelebrationfemale@thumbs_up"
                };
            } else if (option === "photography") { // ANIMATION = 
                pedData.animation = {
                    animation: "photography", 
                    animationDict: "anim@mp_player_intcelebrationfemale@photography"
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
            pedData.ped = option;
            break;
    }
}

$(".modal-btn").on("click", function () {
    const thisElement = $(this);

    console.log('modal-btn clicked');
    const selectedOption = thisElement.text();
    console.log(selectedOption);
    const buttonId = thisElement.data("button-id");

    $("#" + buttonId).text("Selected: " + selectedOption);

    thisElement.text("Selected: " + selectedOption);

    thisElement.closest('.feature-modal').hide();

    const option = thisElement.data("option");
    const btn = thisElement.data("btn");
    const modal = thisElement.data("modal");
    buttonclicked(option, btn, modal);
});

// Function to get player position and heading
function getPlayerPosition() {
    return new Promise((resolve, reject) => {
        // Request the player's position and heading from the client
        fetch(`https://${GetParentResourceName()}/getPlayerPosition`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resolve(data.position); 
                } else {
                    reject('Error retrieving player position');
                }
            })
            .catch(reject);
    });
}

// Updated submitPed Function
function submitPed() {
    pedData.name = $("#name").val();
    pedData.enableBlip = $("#enable-blip").is(":checked"); // Read the blip enabled checkbox
    pedData.blipIcon = parseInt($("#blip-icon").val()) || 1; // Read the blip icon input

    console.log("Submitting Ped Data:", pedData); // Debug the data being sent to the server

    fetch(`https://${GetParentResourceName()}/getPlayerCoords`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' }
    })
    .then(resp => resp.json())
    .then(data => {
        pedData.coords = {
            x: data.x,
            y: data.y,
            z: data.z,
            h: data.h
        };

        fetch(`https://${GetParentResourceName()}/spawnPed`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(pedData)
        }).then(resp => resp.json())
          .then(response => {
              console.log("Server Response:", response); // Debug the server's response
              closeMenu();
              resetButtons();
          })
          .catch(err => {
              console.error("Error spawning ped:", err);
              closeMenu();
              resetButtons();
          });
    })
    .catch(err => {
        console.error("Error fetching player coordinates:", err);
        resetButtons();
    });
}


// THIS RESETS THE BUTTONS TO DEFAULT
function resetButtons() {
    document.getElementById('ped-type-btn').innerText = 'Ped Type';
    document.getElementById('ped-model-btn').innerText = 'Ped Model';
    document.getElementById('gender-btn').innerText = 'Gender';
    document.getElementById('animation-type-btn').innerText = 'Animation Type';

    document.getElementById('name').value = '';  
    document.getElementById('enable-blip').checked = false; // Reset Enable Blip
    document.getElementById('blip-icon').value = '1'; // Reset Blip Icon
    closeModals();
}

// THIS CLOSES THE UI WHEN PRESSED
function closeModals() {
    const modals = document.querySelectorAll('.feature-modal');
    modals.forEach(modal => {
        modal.style.display = 'none';
    });
}
