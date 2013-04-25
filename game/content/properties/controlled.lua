
module ('content.properties', package.seeall)

require 'base.property'
require 'base.message'

controlled = base.property:new {
  receivefrom = 'all'
}

controlled.__init = {
  map = {}
}

local link_code = [[
  return function (self, $args)
    return $formula
  end
]]

function controlled.triggers:update ()
  for _,mapping in ipairs(self.controlled.map) do
    --print(mapping.property, mapping.attribute, mapping.from)
    local new_value = base.message.receive(self.controlled.receivefrom, mapping.from)
    if new_value then
      self[mapping.property][mapping.attribute] =
        assert(loadstring('return function(self,'..mapping.from..') return '..mapping.formula..' end')) () (self, new_value)
    end
  end
end
