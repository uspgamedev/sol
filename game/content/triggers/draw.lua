
module ('content.triggers', package.seeall)

require 'base.trigger'

draw = base.trigger:new {}

function draw:setup (action, graphics)
  graphics.push()
  graphics.translate(self.visible.pos:unpack())
  graphics.scale(self.visible.size:unpack())
  graphics.setColor(255, 255, 255, 255)
  action()
  graphics.pop()
end
