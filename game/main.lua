
require 'scene'
require 'base.element'
require 'content.triggers.update'
require 'content.triggers.draw'
require 'content.triggers.mouse_pressedleft'
require 'content.triggers.mouse_releasedleft'
require 'lux.geom.vector'

local elements

function love.load (args)
  love.graphics.setFont(love.graphics.newFont())
  elements = scene.load(args[2] and ('content/scenes/'..args[2]) or 'samplescene.lua')
end

function love.update (dt)
  content.triggers.update:activate(dt)
end

function love.mousepressed (x, y, button)
  if button == 'l' then
    content.triggers.mouse_pressedleft:activate(x, y)
  end
end

function love.mousereleased (x, y, button)
  if button == 'l' then
    content.triggers.mouse_releasedleft:activate(x, y)
  end
end

local id = 0
function love.keypressed (button)
  if button == ' ' then
    id = id + 1
    local name = 'New Element #'..id
    elements[name] = base.element:new{ name = name }
      :add_property 'visible' {
        pos = lux.geom.point:new{love.mouse.getPosition()}
      }
      :add_property 'grabbable' {}
  elseif button == 's' then
    scene.save('out.lua', elements)
  end
end

function love.draw ()
  content.triggers.draw:activate(love.graphics)
end
