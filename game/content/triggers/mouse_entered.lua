module ('content.triggers', package.seeall)

require 'base.trigger'

mouse_entered = base.trigger:new {}

function mouse_entered:check( x, y )
  local inside = self.visible:inside(lux.geom.point:new{x,y})
  if not self.visible.mouse_entered_mousein and inside then 
    self.visible.mouse_entered_mousein = true
    return true
  elseif self.visible.mouse_entered_mousein and not inside then
    self.visible.mouse_entered_mousein = false
  end
  return false
end