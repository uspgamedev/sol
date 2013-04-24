
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.functional'

temporary = base.property:new {
  trigger = 'never'
}

function temporary:setup ( element )
  content.triggers(self.trigger):register(self,
    lux.functional.bindleft(element.destroy,element))
end