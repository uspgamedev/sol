
module ('content.properties', package.seeall)

require 'base.property'
require 'base.message'

controlled = base.property:new {
  source = 'all'
}

controlled.__init = {
  map = {}
}

function controlled.triggers:update ()
  for _,mapping in ipairs(self.controlled.map) do
    --print(mapping.property, mapping.attribute, mapping.from)
    local new_value = base.message.receive(self.controlled.source, mapping.from)
    if new_value then
      self[mapping.property][mapping.attribute] =
        assert(loadstring('return function(self,'..mapping.from..') return '..mapping.formula..' end')) () (self, new_value)
    end
  end
end
