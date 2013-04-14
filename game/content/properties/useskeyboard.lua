
module ('content.properties', package.seeall)

require 'base.property'
require 'base.message'
require 'content.triggers'

useskeyboard = base.property:new {
  sendto = 'anonymous'
}

useskeyboard.__init = {
  keys = {}
}

function useskeyboard:start (element)
  useskeyboard:__super():start(element)
  for button,cases in pairs(self.keys) do
    base.message.send(self.sendto, button, cases.up)
  end
end

function useskeyboard.triggers:keyboard (button, state)
  if not self.useskeyboard.keys[button] then return end
  base.message.send(
    self.useskeyboard.sendto,
    button,
    self.useskeyboard.keys[button][state]
  )
end
