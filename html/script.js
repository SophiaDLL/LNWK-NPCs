window.addEventListener('message', function (event) { 
    const data = event.data;

    if (data.action === 'show') {
        document.getElementById('npc-ui').style.display = 'block';
        document.querySelector(#npc-ui p).innerText = data.data || 'Default';
    } else if (data.action === 'hide'){
        document.getElementById('npc-ui').style.display = 'none';
    }
 });

 document.addEventListener('DOMContentLoaded',() => {
    const closeButton = document.createElement('button');
    closeButton.innerText = 'close';
    closeButton.onclick = () => {
    document.getElementById('npc-ui').style.display = 'none';

    fetch(`https://${GetParentResourceName()}/close`,{
method: 'POST',
headers: {
    'content-type': 'application/json',
},
    body: JSON.stringify({}),
    }).then(() => console.log('CLOSED UI'));
    };
    document.getElementById('npc-ui').appendChild(closeButton);
 });
