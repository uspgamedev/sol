
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.functional'

isdestroyed = base.property:new {
  when = 'never'
}

function isdestroyed:setup ( element )
  content.triggers.register(self.when,
   self,
    lux.functional.bindleft(element.destroy,element)
  )
end
