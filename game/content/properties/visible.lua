
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.geom.vector'
require 'lux.functional'
require 'content.triggers.draw'
require 'content.draw'

visible = base.property:new {
  pos = lux.geom.point:new {0,0},
  size = lux.geom.vector:new {1,1},
  hidden = false
}

function visible.triggers:draw (graphics)
  if self.visible.hidden then return end
  for _,drawable in ipairs(self.visible.parts) do
    drawable:draw(self, graphics)
  end
end

visible.__init = {
  parts = {
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

function visible:inside (pos) 
  local relative_pos = pos-self.pos
  relative_pos.x = relative_pos.x/self.size.x
  relative_pos.y = relative_pos.y/self.size.y
  for _,part in ipairs(self.parts) do
    if part:inside(relative_pos) then
      return true
    end
  end
end

