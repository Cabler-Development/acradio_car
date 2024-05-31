local radioOpen = false
local isPlaying = false
local musicList = {
    {title = "Example Video 1", url = "https://www.youtube.com/watch?v=example1"},
    {title = "Example Video 2", url = "https://www.youtube.com/watch?v=example2"},
    -- Add more music URLs here
}
local currentMusicIndex = 1

-- Function to toggle the radio UI
function ToggleRadio()
    radioOpen = not radioOpen
    SetNuiFocus(radioOpen, radioOpen)
    SendNUIMessage({action = "toggleRadio", state = radioOpen})
end

-- Function to play a specific URL
function PlayMusic(url)
    isPlaying = true
    SendNUIMessage({action = "playMusic", url = url})
end

-- Function to pause or resume music
function PauseMusic()
    isPlaying = not isPlaying
    SendNUIMessage({action = "pauseMusic", state = isPlaying})
end

-- Register the command to open the radio with the TAB key
RegisterCommand("openradio", function()
    ToggleRadio()
end, false)

-- Bind the TAB key to the open radio command
RegisterKeyMapping("openradio", "Open Car Radio", "keyboard", "TAB")

-- Register NUI callbacks
RegisterNUICallback("playSelectedMusic", function(data, cb)
    currentMusicIndex = data.index
    PlayMusic(musicList[currentMusicIndex].url)
    cb("ok")
end)

RegisterNUICallback("pauseMusic", function(data, cb)
    PauseMusic()
    cb("ok")
end)

RegisterNUICallback("closeRadio", function(data, cb)
    ToggleRadio()
    cb("ok")
end)
