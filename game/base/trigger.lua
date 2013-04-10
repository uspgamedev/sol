
module ('base.trigger', package.seeall)

require 'lux.object'
require 'lux.geom.vector'

local triggers = {
  update = {},
  mousepressed = {},
  mousereleased = {}
}

local trigger_checks = {}

local meta_trigger = lux.object.new {}

meta_trigger.__init = {
  __callbacks = {}
}

local function register (trigger_type, triggered_element)
  triggers[trigger_type][triggered_element] = true
end

local function unregister (trigger_type, triggered_element)
  triggers[trigger_type][triggered_element] = nil
end

function meta_trigger:__newindex (key, value)
  if key == '__callbacks' then
    return rawset(self, key, value)
  end
  rawset(self.__callbacks, key, value)
  if value then
    return register(key, self.owner)
  else
    return unregister(key, self.owner)
  end
end

function make_table (triggerable_element)
  return meta_trigger:new{ owner = triggerable_element }
end

function activate (trigger_type, ...)
  for triggered,_ in pairs(triggers[trigger_type]) do
    local check = trigger_checks[trigger_type]
    if not check or check(triggered, ...) then
      triggered.triggers.__callbacks[trigger_type] (triggered, ...)
    end
  end
end

function trigger_checks.mousepressed (in_check, x, y)
  return in_check:inside(lux.geom.point:new {x,y})
end
