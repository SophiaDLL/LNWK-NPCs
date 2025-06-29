let pedData = {
    name: undefined,
    ped: undefined,
    model: undefined,
    animation: undefined,
    gender: undefined,
    enableBlip: undefined,
    blipIcon: undefined
};

let pedModels = [];
let animations = [];
let currentPreviewAnimation = null;

function loadResources() {
    fetch('./configs/sp.json')
        .then(response => response.json())
        .then(data => {
            pedModels = data;
            populatePedModels();
        })
        .catch(error => console.error('Error loading ped models:', error));

    fetch('./configs/emotes.json')
        .then(response => response.json())
        .then(data => {
            animations = data;
            populateAnimations();
        })
        .catch(error => console.error('Error loading animations:', error));
}

function populatePedModels() {
    const container = document.getElementById('ped-model-list');
    container.innerHTML = '';
    
    pedModels.forEach(ped => {
        const pedItem = document.createElement('div');
        pedItem.className = 'ped-item';
        pedItem.dataset.model = ped.model;
        pedItem.textContent = ped.label || ped.model;
        
        container.appendChild(pedItem);
    });
    
    document.querySelectorAll('.ped-item').forEach(item => {
        item.addEventListener('click', function() {
            document.querySelectorAll('.ped-item').forEach(el => {
                el.classList.remove('selected');
            });
            
            this.classList.add('selected');
            
            // Get ped data
            const model = this.dataset.model;
            const ped = pedModels.find(p => p.model === model);
            
            if (ped) {
                // Update preview
                const previewImage = document.getElementById('ped-preview-image');
                const previewName = document.getElementById('ped-preview-name');
                const noPedSelected = document.getElementById('no-ped-selected');
                const selectBtn = document.getElementById('ped-model-select-btn');
                
                previewImage.src = ped.image || 'https://docs.fivem.net/peds/default.webp';
                previewImage.alt = ped.model;
                previewImage.style.display = 'block';
                
                previewName.textContent = ped.label || ped.model;
                previewName.style.display = 'block';
                
                noPedSelected.style.display = 'none';
                
                selectBtn.dataset.model = ped.model;
                selectBtn.style.display = 'block';
            }
        });
    });
    
    document.getElementById('ped-model-select-btn').addEventListener('click', function() {
        const model = this.dataset.model;
        const button = document.getElementById('ped-model-btn');
        button.querySelector('span').textContent = model;
        pedData.model = model;
        closeModals();
    });
}

// Populate animations 
function populateAnimations() {
    const container = document.getElementById('animation-list');
    container.innerHTML = '';
    
    animations.forEach(emote => {
        const animItem = document.createElement('div');
        animItem.className = 'animation-item';
        animItem.dataset.value = emote.value;
        animItem.dataset.dict = emote.animationDict;
        animItem.dataset.anim = emote.animation;
        animItem.textContent = emote.label;
        
        container.appendChild(animItem);
    });
    
    document.querySelectorAll('.animation-item').forEach(item => {
        item.addEventListener('click', function() {
            document.querySelectorAll('.animation-item').forEach(el => {
                el.classList.remove('selected');
            });
            
            this.classList.add('selected');
            
            // Get animation data
            const value = this.dataset.value;
            const dict = this.dataset.dict;
            const anim = this.dataset.anim;
            
            const animation = animations.find(a => a.value === value);
            if (animation) {
                // Update preview
                const noAnimSelected = document.getElementById('no-animation-selected');
                const previewInfo = document.getElementById('animation-preview-info');
                const selectBtn = document.getElementById('animation-select-btn');
                
                document.getElementById('preview-animation-name').textContent = animation.label;
                document.getElementById('preview-animation-dict').textContent = `${dict}@${anim}`;
                
                noAnimSelected.style.display = 'none';
                previewInfo.style.display = 'block';
                
                // Store animation 
                selectBtn.dataset.value = value;
                selectBtn.style.display = 'block';
                
                // Trigger preview in-game
                previewAnimation(animation);
            }
        });
    });
    
    document.getElementById('animation-select-btn').addEventListener('click', function() {
        const value = this.dataset.value;
        const button = document.getElementById('animation-type-btn');
        const animation = animations.find(a => a.value === value);
        
        if (animation) {
            button.querySelector('span').textContent = animation.label;
            pedData.animation = {
                animation: animation.animation,
                animationDict: animation.animationDict
            };
        }
        
        closeModals();
    });
}

// Request animation preview
function previewAnimation(animation) {
    const previewModel = pedData.model ? pedData.model : "a_f_m_bevhills_01";
    
    $.post(`https://${GetParentResourceName()}/previewAnimation`, JSON.stringify({
        animationDict: animation.animationDict,
        animation: animation.animation,
        pedModel: previewModel,
        label: animation.label
    }));
}

window.addEventListener('message', function (event) {
    const data = event.data;

    if (data.action === "update") {
        if (data.update === 'true') {
            document.getElementById('groups-container').style.display = 'block';
            $.post(`https://${GetParentResourceName()}/open`);
        } else {
            document.getElementById('groups-container').style.display = 'none';
            $.post(`https://${GetParentResourceName()}/close`);
        }
    }
});

$(document).on("click", "#close-btn", function() {
    closeMenu();
});

$(document).on("click", ".close-modal", function() {
    closeModals();
});

document.onkeyup = function (data) {
    if (data.key == 'Escape') {
        const openModal = document.querySelector('.modal.show');
        if (openModal) {
            openModal.classList.remove('show');
        } else {
            closeMenu();
        }
    }
};

function closeMenu() {
    document.getElementById('groups-container').style.display = 'none';
    $.post(`https://${GetParentResourceName()}/close`);
}

function closeModals() {
    $('.modal').removeClass('show');
}

$(document).on("click", "#ped-type-btn", function () {
    $('#ped-type-modal').addClass('show');
});

$(document).on("click", "#ped-model-btn", function () {
    // Reset preview when opening
    document.getElementById('no-ped-selected').style.display = 'block';
    document.getElementById('ped-preview-image').style.display = 'none';
    document.getElementById('ped-preview-name').style.display = 'none';
    document.getElementById('ped-model-select-btn').style.display = 'none';
    
    // Clear any selections
    document.querySelectorAll('.ped-item').forEach(el => {
        el.classList.remove('selected');
    });
    
    $('#ped-model-modal').addClass('show');
});

$(document).on("click", "#gender-btn", function () {
    $('#gender-modal').addClass('show');
});

$(document).on("click", "#animation-type-btn", function () {
    // Reset preview when opening
    document.getElementById('no-animation-selected').style.display = 'block';
    document.getElementById('animation-preview-info').style.display = 'none';
    document.getElementById('animation-select-btn').style.display = 'none';
    
    // Clear any selections
    document.querySelectorAll('.animation-item').forEach(el => {
        el.classList.remove('selected');
    });
    
    $('#animation-type-modal').addClass('show');
});

$(document).ready(function() {
    loadResources();
    
    $('#ped-type-modal .option-btn').on('click', function() {
        const option = $(this).data('option');
        const btnId = $(this).data('btn');
        $('#' + btnId + ' span').text($(this).text());
        pedData.ped = option;
        closeModals();
    });
    
    $('#gender-modal .option-btn').on('click', function() {
        const option = $(this).data('option');
        const btnId = $(this).data('btn');
        $('#' + btnId + ' span').text($(this).text());
        pedData.gender = option;
        closeModals();
    });
});

function submitPed() {
    pedData.name = $("#name").val();
    pedData.enableBlip = $("#enable-blip").is(":checked");
    pedData.blipIcon = parseInt($("#blip-icon").val()) || 1;

    const submitBtn = $("#submit-btn");
    submitBtn.prop("disabled", true).text("Loading...");

    fetch(`https://${GetParentResourceName()}/spawnPed`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/shared/json; charset=UTF-8' },
        body: JSON.stringify(pedData)
    })
    .finally(() => {
        resetButtons();
        submitBtn.prop("disabled", false).text("SPAWN NPC");
        closeMenu();
    });
}

function resetButtons() {
    $("#ped-type-btn span").text("Select");
    $("#ped-model-btn span").text("Select");
    $("#gender-btn span").text("Select");
    $("#animation-type-btn span").text("Select");

    $("#name").val("");
    $("#enable-blip").prop("checked", false);
    $("#blip-icon").val("1");
    
    pedData = {
        name: undefined,
        ped: undefined,
        model: undefined,
        animation: undefined,
        gender: undefined,
        enableBlip: undefined,
        blipIcon: undefined
    };
    
    closeModals();
}