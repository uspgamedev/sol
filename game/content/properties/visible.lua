
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.geom.vector'
require 'lux.functional'
require 'content.triggers.draw'
require 'content.draw'

visible = base.property:new {
  hidden    = false,
  rotation  = 0
}

function visible.triggers:draw (graphics)
  if self.visible.hidden then return end
  for _,drawable in ipairs(self.visible.parts) do
    drawable:draw(self, graphics)
  end
end

visible.__init = {
  position  = lux.geom.point:new {0,0},
  scale     = lux.geom.vector:new {1,1},
  shear     = lux.geom.vector:new {0,0},
  parts     = {
    content.draw.rectangle:new{
      color   = {150, 150, 255, 100},
      mode    = 'fill',
      width   = 64,
      height  = 64
    },
    content.draw.rectangle:new{
      color   = {150, 150, 150, 255},
      mode    = 'line',
      width   = 64,
      height  = 64
    },
    content.draw.text:new {}
  }
}

function visible:inside (position) 
  local relative_position = position-self.position
  relative_position.x = relative_position.x/self.scale.x
  relative_position.y = relative_position.y/self.scale.y
  for _,part in ipairs(self.parts) do
    if part:inside(relative_position) then
      return true
    end
  end
end

