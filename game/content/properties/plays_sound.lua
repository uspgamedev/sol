
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.functional'
require 'content.triggers'

local cash = {}

plays_sound = base.property:new {
  path = 'FunBell.ogg',
  when = 'never'
}

function plays_sound:__init ()
  cash[self.path] =
    cash[self.path] or love.audio.newSource('resource/sounds/'..self.path)
  self.data = cash[self.path]
end

local function play_sound (sound)
  sound:stop()
  sound:play()
end

function plays_sound:setup (element)
  self.safekeep = lux.functional.bindleft(play_sound, self.data)
  content.triggers(self.when):register(element, self.safekeep)
end

function plays_sound:cleanup (element)
  content.triggers(self.when):unregister(element, self.safekeep)
end
