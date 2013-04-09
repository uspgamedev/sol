
module ('base.trigger', package.seeall)

require 'lux.object'

local triggers = {
  update = {}
}

local meta_trigger = lux.object.new {}

local function register (trigger_type, triggered_element)
  triggers[trigger_type][triggered_element] = true
end

function meta_trigger:__newindex (key, value)
  rawset(self, key, value)
  register(key, self.owner)
end

function make_table (triggerable_element)
  return meta_trigger:new{ owner = triggerable_element }
end

function activate (trigger_type)
  for triggered,_ in pairs(triggers[trigger_type]) do
    triggered.triggers[trigger_type] (triggered)
  end
end
