
module ('base', package.seeall)

require 'lux.object'
require 'lux.functional'

trigger = lux.object.new {}

trigger.__init = {
  triggered_elements = {}
}

function trigger:check ()
  return true
end

function trigger:setup (action)
  return action()
end

function trigger:register (triggered_element, action)
  self.triggered_elements[triggered_element] = action
end

function trigger:unregister (triggered_element)
  self.triggered_elements[triggered_element] = nil
end

function trigger:activate (...)
  for triggered,action in pairs(self.triggered_elements) do
    local check = self.check
    if check(triggered, ...) then
      self.setup(triggered, lux.functional.bindleft(action, triggered, ...), ...)
    end
  end
end
