
require 'sol.engine'

function love.load (args)
  sol.engine.load(args[2])
end

function love.update (dt)
  sol.engine.update(dt)
end

function love.mousepressed (x, y, button)
  sol.engine.mousepressed(x, y, button)
end

function love.mousereleased (x, y, button)
  sol.engine.mousereleased(x, y, button)
end

function love.keypressed (button)
  sol.engine.keypressed(button)
end

function love.keyreleased (button)
  sol.engine.keyreleased(button)
end

function love.draw ()
  sol.engine.draw()
end
