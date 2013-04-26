
local version = {
  major = 0,
  minor = 1,
  patch = 0
}

function love.conf(t)
    t.title = "Summer of LÖVE2D v"..version.major..'.'..version.minor..'.'..version.patch
    t.author = "USPGameDev"
    t.url = "github.com/uspgamedev/sol"
    t.identity = "sol-files"
    t.version = "0.8.0"
    t.console = false
    t.release = false
    t.screen.width = 800
    t.screen.height = 600
    t.screen.fullscreen = false
    t.screen.vsync = true
    t.screen.fsaa = 0
    t.modules.joystick = true
    t.modules.audio = true
    t.modules.keyboard = true
    t.modules.event = true
    t.modules.image = true
    t.modules.graphics = true
    t.modules.timer = true
    t.modules.mouse = true
    t.modules.sound = true
    t.modules.physics = true
end
