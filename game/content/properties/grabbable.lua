
module ('content.properties', package.seeall)

require 'base.property'
require 'content.triggers.mouse'
require 'content.triggers.update'
require 'content.properties.visible'

grabbable = base.property:new {
  requires = { content.properties.visible }
}

function grabbable:visit (element)
  content.triggers.mouse.pressedleft:register(element, self.grab)
  content.triggers.mouse.releasedleft:register(element, self.letgo)
end

function grabbable:grab ()
  content.triggers.update:register(
    self,
    function (self)
      self.pos = lux.geom.point:new {love.mouse.getPosition()} - self.size*.5
    end
  )
end

function grabbable:letgo ()
  content.triggers.update:unregister(self)
end
