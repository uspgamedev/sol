
require 'base.sol'

function love.load (args)
  base.sol.load(args[2] and ('content/scenes/'..args[2]))
end

function love.update (dt)
  base.sol.update(dt)
end

function love.mousepressed (x, y, button)
  base.sol.mousepressed(x, y, button)
end

function love.mousereleased (x, y, button)
  base.sol.mousereleased(x, y, button)
end

function love.keypressed (button)
  base.sol.keypressed(button)
end

function love.keyreleased (button)
  base.sol.keyreleased(button)
end

function love.draw ()
  base.sol.draw()
end
