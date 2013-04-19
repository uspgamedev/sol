module("content.recipes.button",package.seeall)

require 'base.element'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'

function make ( elements, name, data)
    if elements[name] then return elements[name] end
    if not data then
      return lux.functional.bindleft(content.recipes.button.make, elements, name)
    end
    
    local element = base.element:new()
    element.name = name

   -- function element.trigger( func )
   --   
   -- end

    element:add_property('visible', {
        pos = data.pos,
        parts = { content.draw.rectangle:new { 
           width = data.width or 100,
           height = data.height or 100,
           color = data.colorUp or {80,10,10,255}
           },
           content.draw.rectangle:new{
           mode = 'line',
           width = data.width or 100,
           height = data.height or 100,
           color = {180,10,10,255}
         },
         content.draw.text:new{
         text = "$name$"
       }
        }
      }
    )
    function element.visible.triggers:mouse_pressedleft( x, y )
      --dostuff
    end
    function element.visible.triggers:mouse_releasedleft ( x, y )
      --dostuff
    end
    element.visible:add_triggers(element)

    elements[element.name] = element
    return element
end

--make.button 'awesomebutton' {
--    pos = point {100,100},
--    width = 50,
--    height = 50,
--    sharein = 'button',
--    mouse = {up = 1,down = 2},
--    colorUp = {255,255,255,255},
--    colorUpHover = {200,200,200,255},
--    colorDown = {255,0,0,255},
--    colorDownHover = {200,0,0,255}
--}
