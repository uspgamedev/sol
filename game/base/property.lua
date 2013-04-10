
module ('base', package.seeall)

require 'lux.object'
require 'content.triggers'

property = lux.object.new {}

property.__init = {
  triggers  = {},
  requires  = {}
}

function property:visit (element)
  for trigger_name,action in pairs(self.triggers) do
    content.triggers[trigger_name]:register(element, action)
  end
end
