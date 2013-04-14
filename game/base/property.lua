
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
    getfenv(link).property  = self
    getfenv(link).element   = element
    setmetatable(getfenv(link), { __index = self })
  end
end

function property:visit (element)
  for trigger_name,action in pairs(self.triggers) do
    content.triggers[trigger_name]:register(element, action)
  end
end

function property:update ()
  for k,link in ipairs(self) do
    link()
  end
end
