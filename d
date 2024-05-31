const musicList = ${JSON.stringify(musicList)};
const musicListElement = document.getElementById('musicList');

function populateMusicList() {
    musicList.forEach((music, index) => {
        const button = document.createElement('button');
        button.innerText = music.title;
        button.classList.add('button');
        button.onclick = () => playSelectedMusic(index);
        musicListElement.appendChild(button);
    });
}

function playSelectedMusic(index) {
    fetch(`https://${GetParentResourceName()}/playSelectedMusic`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ index }),
    });
}

function pauseMusic() {
    fetch(`https://${GetParentResourceName()}/pauseMusic`, {
        method: 'POST',
    });
}

function closeRadio() {
    fetch(`https://${GetParentResourceName()}/closeRadio`, {
        method: 'POST',
    });
}

window.addEventListener('message', (event) => {
    if (event.data.action === 'toggleRadio') {
        document.body.style.display = event.data.state ? 'block' : 'none';
    }
});

// Initialize the music list
populateMusicList();