
module ('content.properties', package.seeall)

require 'base.property'
require 'base.message'
require 'content.triggers'

useskeyboard = base.property:new {
  controller = 'anonymous'
}

useskeyboard.__init = {
  keydown = {},
  keyup = {}
}

function useskeyboard:start (element)
  for button,obj in pairs(self.keyup) do
    base.message.send(self.controller, button, obj)
  end
end

function useskeyboard.triggers:keyboard (button, state)
  base.message.send(
    self.useskeyboard.controller,
    button,
    self.useskeyboard['key'..state][button]
  )
end
