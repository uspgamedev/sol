
module ('content.triggers', package.seeall)

require 'base.trigger'

draw = base.trigger:new {}

function draw:setup (action, graphics)
  graphics.push()
  graphics.translate(self.visible.position:unpack())
  graphics.scale(self.visible.scale:unpack())
  graphics.rotate(self.visible.rotation)
  graphics.shear(self.visible.shear:unpack())
  graphics.setColor(255, 255, 255, 255)
  action()
  graphics.pop()
end
