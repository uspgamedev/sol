
require 'scene'
require 'base.element'
require 'content.triggers.update'
require 'content.triggers.draw'
require 'content.triggers.mouse'
require 'lux.geom.vector'

local elements

function love.load ()
  elements = scene.load 'samplescene.lua'
end

function love.update (dt)
  content.triggers.update:activate()
end

function love.mousepressed (x, y, button)
  if button == 'l' then
    content.triggers.mouse.pressedleft:activate(x, y)
  end
end

function love.mousereleased (x, y, button)
  if button == 'l' then
    content.triggers.mouse.releasedleft:activate(x, y)
  end
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
  content.triggers.draw:activate(love.graphics)
end
