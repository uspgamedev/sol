
module ('base', package.seeall)

require 'lux.object'
require 'content.triggers'

property = lux.object.new {}

property.__init = {
  triggers  = {},
  requires  = {}
}

local function add_triggers (self, element)
  for trigger_name,action in pairs(self.triggers) do
    content.triggers(trigger_name):register(element, action)
  end
end

function property:start (element)
  for k,link in ipairs(self) do
    getfenv(link.action).property  = self
    getfenv(link.action).element   = element
    setmetatable(getfenv(link.action), { __index = self })
  end
  self:setup(element)
  add_triggers(self:__super(), element)
end

function property:setup (element)
  -- Abstract
end

local function remove_triggers (self, element)
  for trigger_name,action in pairs(self.triggers) do
    content.triggers(trigger_name):unregister(element, action)
  end
end

function property:finish (element)
  self:cleanup(element)
  remove_triggers(self:__super(), element)
end

function property:cleanup (element)
  -- Abstract
end

function property:update ()
  for k,link in ipairs(self) do
    link.action()
  end
end
