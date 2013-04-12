
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
  if not self.triggered_elements[triggered_element] then
    self.triggered_elements[triggered_element] = {}
  end
  self.triggered_elements[triggered_element][action] = true
end

function trigger:unregister (triggered_element)
  self.triggered_elements[triggered_element][action] = nil
end

function trigger:activate (...)
  for triggered,actions in pairs(self.triggered_elements) do
    local check = self.check
    if check(triggered, ...) then
      for action,_ in pairs(actions) do
        self.setup(triggered, lux.functional.bindleft(action, triggered, ...), ...)
      end
    end
  end
end
