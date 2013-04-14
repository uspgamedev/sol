
module ('content.draw', package.seeall)

require 'base.drawable'

circle = base.drawable:new {
  mode = 'fill',
  radius = 32
}

function circle:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.circle(
    self.mode,
    0, 0,
    self.radius
  )
end

function circle:inside (p)
  return p.x*p.x + p.y*p.y < self.radius*self.radius
end
