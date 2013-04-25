
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.functional'

temporary = base.property:new {
  requires = { 'counts_time', 'isdestroyed' },
  lifetime = 1.0 -- in seconds
}

local nextID = 0

function temporary:setup (element)
  element.counts_time.limit     = self.lifetime
  element.counts_time.repeats   = false
  element.counts_time.totrigger = 'temporary-'..nextID
  element.isdestroyed.when      = 'temporary-'..nextID
  nextID = nextID + 1
end