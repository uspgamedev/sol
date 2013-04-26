
module ('content.properties', package.seeall)

require 'base.property'
require 'content.triggers'
require 'lux.functional'

isdestroyed = base.property:new {
  when = 'never',
  also_trigger = 'never'
}



function isdestroyed:setup ( element )
  content.triggers.register(self.when,
    element,
    lux.functional.bindleft(kill,element)
  )
end


function kill (element)
  if element.isdestroyed then
    content.triggers(element.isdestroyed.also_trigger):activate()
  end 
  element:destroy()
end
