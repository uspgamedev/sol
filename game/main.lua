
require 'scene'
require 'base.element'
require 'content.elements.grabbable'
require 'lux.geom.vector'

local elements

function love.load ()
  elements = scene.load 'samplescene.lua'
end

function love.update (dt)
  base.trigger.activate 'update'
end

function love.mousepressed (x, y, button)
  base.trigger.activate('mousepressed', x, y, button)
end

function love.mousereleased (x, y, button)
  base.trigger.activate('mousereleased', x, y, button)
end

function love.keypressed (button)
  if button == ' ' then
    table.insert(
      elements,
      content.elements.grabbable:new {
        pos = lux.geom.point:new{love.mouse.getPosition()}
      }
    )
  end
end

function love.draw ()
  local graphics = love.graphics
  for _,element in ipairs(elements) do
    graphics.push()
    graphics.translate(element.pos:unpack())
    graphics.setColor(255, 255, 255, 255)
    element:draw(graphics)
    graphics.pop()
  end
end
