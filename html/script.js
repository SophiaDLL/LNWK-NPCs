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
    closeMenu()
});
document.onkeyup = function (data) {
    if (data.key == 'Escape') {
        closeMenu()
    }
};

function closeMenu() {
    document.getElementById('groups-container').style.display = 'none';
    $.post(`https://${GetParentResourceName()}/close`);
}

const copyToClipboard = str => {
    console.log('Copying to clipboard: ' + str)
    const el = document.createElement('textarea');
    el.value = str;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
};
