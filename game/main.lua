
require 'base.element'
require 'base.trigger'

local elements = {}

function love.load ()
  local elem = base.element:new{}
  table.insert(elements, elem)
end

function love.update (dt)
  base.trigger.activate 'update'
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
