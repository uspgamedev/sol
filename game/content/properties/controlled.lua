
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
    self[mapping.property][mapping.attribute] =
      base.message.receive(self.controlled.source, mapping.from)
      or
      self[mapping.property][mapping.attribute]
  end
end
