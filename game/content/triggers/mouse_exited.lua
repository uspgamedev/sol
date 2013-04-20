module ('content.triggers', package.seeall)

require 'base.trigger'

mouse_exited = base.trigger:new {}

function mouse_exited:check( x, y )
  local inside = self.visible:inside(lux.geom.point:new{x,y})
  if not self.visible.mouse_exited_mousein and inside then
    self.visible.mouse_exited_mousein = true
  elseif self.visible.mouse_exited_mousein and not inside then
    self.visible.mouse_exited_mousein = false
    return true
  end
  return false
end