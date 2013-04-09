
require 'base.element'

local elements = {}

function love.load ()
  table.insert(elements, base.element:new{})
end

function love.update (dt)

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
