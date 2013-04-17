module("content.recipes.button",package.seeall)

require 'base.element'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'

function new ( elements, name, data)
    if not data then
      return lux.functional.bindleft(content.recipes.button.new, elements, name)
    end
    
    local element = base.element:new()
    element.name = name
    element:add_property('visible', {
        pos = data.pos,
        parts = { content.draw.rectangle:new { 
           width = data.width or 100,
           height = data.height or 100,
           color = {200,30,30,255}
           }
        },
        mouse_pressedleft = function(self,x,y)
            table.foreach(self,print)
        end
      }
    )
    elements[element.name] = element
    return element
end

--make.button 'awesomebutton' {
--    pos = point {100,100},
--    width = 50,
--    height = 50
--}
