
module ('content.properties', package.seeall)

require 'base.property'
require 'base.message'
require 'content.triggers'

useskeyboard = base.property:new {
  sharein = 'anonymous'
}

useskeyboard.__init = {
  keys = {}
}

function useskeyboard:setup (element)
  for button,cases in pairs(self.keys) do
    base.message.send(self.sharein, button, cases.up)
  end
end

function useskeyboard.triggers:keyboard (button, state)
  if not self.useskeyboard.keys[button] then return end
  base.message.send(
    self.useskeyboard.sharein,
    button,
    self.useskeyboard.keys[button][state]
  )
end
