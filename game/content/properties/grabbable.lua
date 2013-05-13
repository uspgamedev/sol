
module ('content.properties', package.seeall)

require 'base.property'
require 'content.triggers.mouse_pressedleft'
require 'content.triggers.mouse_releasedleft'
require 'content.triggers.update'

grabbable = base.property:new {
  requires = { 'visible' }
}

local function follow_mouse (self)
  self.visible.position = lux.geom.point:new {love.mouse.getPosition()}
end

function grabbable.triggers:mouse_pressedleft ()
  content.triggers.update:register(
    self,
    follow_mouse
  )
end

function grabbable.triggers:mouse_releasedleft ()
  content.triggers.update:unregister(self, follow_mouse)
end
