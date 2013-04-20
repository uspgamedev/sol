
module ('base', package.seeall)

require 'lux.object'
require 'content.triggers'

property = lux.object.new {}

property.__init = {
  triggers  = {},
  requires  = {}
}

function property:start (element)
  for k,link in ipairs(self) do
    getfenv(link.action).property  = self
    getfenv(link.action).element   = element
    setmetatable(getfenv(link.action), { __index = self })
  end
  self:setup(element)
  self:__super():add_triggers(element)
end

function property:setup (element)
  -- Abstract
end

function property:finish (element)
  ----
end

function property:add_triggers (element)
  for trigger_name,action in pairs(self.triggers) do
    content.triggers[trigger_name]:register(element, action)
  end
end

function property:update ()
  for k,link in ipairs(self) do
    link.action()
  end
end
