
module ('base', package.seeall)

require 'lux.object'

property = lux.object.new {}

property.__init = {
  operations = {}
}

function property:visit (elem)
  -- Implement upon heritage
end
