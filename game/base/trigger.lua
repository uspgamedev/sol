
module ('base', package.seeall)

require 'lux.object'
require 'lux.geom.vector'

trigger = lux.object.new {
  check = function (self) return true end
}

trigger.__init = {
  triggered_elements = {}
}

function trigger:register (triggered_element, action)
  self.triggered_elements[triggered_element] = action
end

function trigger:unregister (triggered_element)
  self.triggered_elements[triggered_element] = nil
end

function trigger:activate (...)
  for triggered,action in pairs(self.triggered_elements) do
    local check = self.check
    if not check or check(triggered, ...) then
      action(triggered, ...)
    end
  end
end
