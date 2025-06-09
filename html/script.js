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
            if (option === "slow_clap") {
                pedData.animation = {
                    animation: "slow_clap",
                    animationDict: "anim@mp_player_intcelebrationfemale@slow_clap"
                };
            } else if (option === "Clapping") {
                pedData.animation = {
                    animation: "base",
                    animationDict: "amb@world_human_cheering@male_a"
                };
            } else if (option === "salute") {
                pedData.animation = {
                    animation: "salute",
                    animationDict: "anim@mp_player_intcelebrationmale@salute"
                };
            } else if (option === "face_palm") {
                pedData.animation = {
                    animation: "face_palm",
                    animationDict: "anim@mp_player_intcelebrationfemale@face_palm"
                };
            } else if (option === "gangmember_stickup_loop") {
                pedData.animation = {
                    animation: "gangmember_stickup_loop",
                    animationDict: "random@countryside_gang_fight"
                };
            } else if (option === "Texting") {
                pedData.animation = {
                    animation: "base",
                    animationDict: "amb@world_human_stand_mobile@male@text@base"
                };
            } else if (option === "Crying") {
                pedData.animation = {
                    animation: "console_end_loop_floyd",
                    animationDict: "switch@trevor@floyd_crying"
                };
            } else if (option === "ICrossing") {
                pedData.animation = {
                    animation: "base",
                    animationDict: "amb@code_human_cross_road@male@base"
                };
            } else if (option === "PhoneCall") {
                pedData.animation = {
                    animation: "cellphone_call_listen_base",
                    animationDict: "switch@michael@bench"
                };
            } else if (option === "Shaking") {
                pedData.animation = {
                    animation: "idle",
                    animationDict: "mp_move@prostitute@f@cokehead"
                };
            } else if (option === "Checkout") {
                pedData.animation = {
                    animation: "try_shirt_neutral_a",
                    animationDict: "mp_clothing@female@shirt"
                };
            } else if (option === "Smoking") {
                pedData.animation = {
                    animation: "smoke_idle",
                    animationDict: "timetable@gardener@smoking_joint"
                };
            } else if (option === "Pissing") {
                pedData.animation = {
                    animation: "urinal_asifyouneededproof",
                    animationDict: "missheist_agency3aig_23"
                };
            } else if (option === "Kneeling") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@medic@standing@kneel@idle_a"
                };
            } else if (option === "TTD") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@medic@standing@tendtodead@idle_a"
                };
            } else if (option === "Guard") {
                pedData.animation = {
                    animation: "idle_e",
                    animationDict: "amb@world_human_guard_patrol@male@idle_b"
                };
            } else if (option === "Bird") {
                pedData.animation = {
                    animation: "wakeup",
                    animationDict: "random@peyote@bird"
                };
            } else if (option === "ThumbsUp") {
                pedData.animation = {
                    animation: "thumbs_up",
                    animationDict: "anim@mp_player_intcelebrationfemale@thumbs_up"
                };
            } else if (option === "photography") {
                pedData.animation = {
                    animation: "photography",
                    animationDict: "anim@mp_player_intcelebrationfemale@photography"
                };
            } else if (option === "Surrender") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "random@arrests@busted"
                };
            } else if (option === "SitGround") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "anim@heists@fleeca_bank@ig_7_jetski_owner"
                };
            } else if (option === "LeanWall") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_leaning@male@wall@back@hands_together@idle_a"
                };
            } else if (option === "Pushups") {
                pedData.animation = {
                    animation: "pushups_loop",
                    animationDict: "amb@world_human_push_ups@male@base"
                };
            } else if (option === "SitChair") {
                pedData.animation = {
                    animation: "base",
                    animationDict: "timetable@ron@ig_3_couch"
                };
            } else if (option === "SitChairAttentive") {
                pedData.animation = {
                    animation: "sit_base_jimmy",
                    animationDict: "anim@scripted@freemode_npc@fix_astu_ig3_pooh_jimmy@jimmy@"
                };
            } else if (option === "SitChair4") {
                pedData.animation = {
                    animation: "ig_2_alt1_base",
                    animationDict: "timetable@ron@ron_ig_2_alt1"
                };
            } else if (option === "Dancing") {
                pedData.animation = {
                    animation: "raining_cash",
                    animationDict: "anim@mp_player_intcelebrationfemale@raining_cash"
                };
            } else if (option === "LeanBar") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@prop_human_bum_shopping_cart@male@idle_a"
                };
            } else if (option === "TieShoes") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@medic@standing@tendtodead@idle_a"
                };
            } else if (option === "Think") {
                pedData.animation = {
                    animation: "base",
                    animationDict: "amb@world_human_hang_out_street@male_b@idle_a"
                };
            } else if (option === "KnockedOut") {
                pedData.animation = {
                    animation: "dead_a",
                    animationDict: "dead"
                };
            } else if (option === "CrossArms") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_hang_out_street@female_arms_crossed@idle_a"
                };
            } else if (option === "HandsHips") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_hang_out_street@female_arm_side@idle_a"
                };
            } else if (option === "LeanForward") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_leaning@male@wall@back@idle_a"
                };
            } else if (option === "SitBench") {
                pedData.animation = {
                    animation: "sit",
                    animationDict: "timetable@ron@ig_5_p3"
                };
            } else if (option === "SitCasual") {
                pedData.animation = {
                    animation: "base",
                    animationDict: "amb@world_human_picnic@male@idle_a"
                };
            } else if (option === "Yoga") {
                pedData.animation = {
                    animation: "pose_a",
                    animationDict: "amb@world_human_yoga@male@base"
                };
            } else if (option === "Meditate") {
                pedData.animation = {
                    animation: "idle_c",
                    animationDict: "rcmcollect_paperleadinout@"
                };
            } else if (option === "CrouchIdle") {
                pedData.animation = {
                    animation: "idle",
                    animationDict: "move_crouch_proto"
                };
            } else if (option === "Watch") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@code_human_wander_clipboard@male@base"
                };
            } else if (option === "LeanShoulder") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_leaning@male@wall@back@foot_up@idle_a"
                };
            } else if (option === "Notes") {
                pedData.animation = {
                    animation: "base",
                    animationDict: "amb@world_human_clipboard@male@idle_a"
                };
            } else if (option === "CleanGround") {
                pedData.animation = {
                    animation: "base",
                    animationDict: "amb@world_human_maid_clean@"
                };
            } else if (option === "Clipboard") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_clipboard@male@base"
                };
            } else if (option === "Hammer") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_hammering@male@base"
                };
            } else if (option === "HammerBench") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_hammering@male@base"
                };
            } else if (option === "Bartender") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_bum_standing@drunk@idle_a"
                };
            } else if (option === "DrinkLean") {
                pedData.animation = {
                    animation: "idle_a",
                    animationDict: "amb@world_human_drinking@coffee@male@idle_a"
                };
            } else if (option === "Dance1") {
                pedData.animation = {
                    animation: "raining_cash",
                    animationDict: "anim@mp_player_intcelebrationfemale@raining_cash"
                };
            } else if (option === "Dance2") {
                pedData.animation = {
                    animation: "find_the_fish",
                    animationDict: "anim@mp_player_intcelebrationfemale@find_the_fish"
                };
            } else if (option === "Dance3") {
                pedData.animation = {
                    animation: "mi_dance_facedj_15_v1_female^1",
                    animationDict: "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@"
                };
            } else if (option === "Dance4") {
                pedData.animation = {
                    animation: "dance_loop_teddy_bear",
                    animationDict: "special_ped@mountain_dancer@base"
                };
            } else if (option === "Dance5") {
                pedData.animation = {
                    animation: "mp_dance_loop",
                    animationDict: "anim@mp_player_intcelebrationfemale@find_the_fish"
                };
            } else if (option === "DanceSlow") {
                pedData.animation = {
                    animation: "peace",
                    animationDict: "anim@mp_player_intcelebrationfemale@peace"
                };
            } else if (option === "Shuffle") {
                pedData.animation = {
                    animation: "shuffle",
                    animationDict: "anim@move_m@grooving@"
                };
            } else if (option === "DanceEnergetic") {
                pedData.animation = {
                    animation: "raining_cash",
                    animationDict: "anim@mp_player_intcelebrationfemale@raining_cash"
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
    pedData.enableBlip = $("#enable-blip").is(":checked");
    pedData.blipIcon = parseInt($("#blip-icon").val()) || 1;

    const submitBtn = $("#submit-btn");
    submitBtn.prop("disabled", true).text("Loading...");


    fetch(`https://${GetParentResourceName()}/spawnPed`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify(pedData)
    })
    .finally(() => {
        resetButtons();
        submitBtn.prop("disabled", false).text("Submit");
        closeMenu();
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
