
require 'game.element'

local elements = {}

function love.load ()
  table.insert(elements, game.element:new{})
end

function love.update (dt)

end

function love.draw ()
  local graphics = love.graphics
  for _,element in ipairs(elements) do
    graphics.push()
    graphics.translate(element.pos:unpack())
    element:draw(graphics)
    graphics.pop()
  end
end
