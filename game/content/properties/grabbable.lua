
module ('content.properties', package.seeall)

require 'base.property'
require 'content.triggers.mouse_pressedleft'
require 'content.triggers.mouse_releasedleft'
require 'content.triggers.update'

grabbable = base.property:new {
  requires = { 'visible' }
}

function grabbable.triggers:mouse_pressedleft ()
  content.triggers.update:register(
    self,
    function (self)
      self.visible.pos = lux.geom.point:new {love.mouse.getPosition()} - self.visible.size*.5
    end
  )
end

function grabbable.triggers:mouse_releasedleft ()
  content.triggers.update:unregister(self)
end
