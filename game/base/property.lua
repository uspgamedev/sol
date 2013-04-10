
module ('base', package.seeall)

require 'lux.object'

property = lux.object.new {}

property.__init = {
  operations  = {},
  requires    = {}
}

function property:visit (elem)
  -- Implement upon heritage
end
