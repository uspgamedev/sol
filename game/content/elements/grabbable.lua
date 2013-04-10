
module ('content.elements', package.seeall)

require 'base.element'

grabbable = base.element:new {}

function grabbable:__init ()
  function self.triggers:mousepressed (x, y, button)
    self.triggers.update = function (self)
      self.pos = lux.geom.point:new {love.mouse.getPosition()} - self.size*.5
    end
  end
  function self.triggers:mousereleased (x, y, button)
    self.triggers.update = nil
  end
end

