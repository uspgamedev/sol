
require 'scene'
require 'base.element'
require 'base.message'
require 'base.hitbox'
require 'content.triggers.update'
require 'content.triggers.draw'
require 'content.triggers.mouse_pressedleft'
require 'content.triggers.mouse_releasedleft'
require 'content.triggers.keyboard'
require 'lux.geom.vector'

function love.load (args)
  love.graphics.setFont(love.graphics.newFont())
  scene.load(args[2] and ('content/scenes/'..args[2]) or 'samplescene.lua')
  handleInput()
end

function love.update (dt)
  content.triggers.update:activate(dt)
  handleInput()
end

function handleInput()
  handleMouse()
  handleJoystick()
  base.hitbox.check_collisions()
end
function handleMouse()
  local x,y = love.mouse.getX(),love.mouse.getY()
  content.triggers.mouse_entered:activate(x, y)
  content.triggers.mouse_exited :activate(x, y)
  base.message.send("mouse",'x',x)
  base.message.send("mouse",'y',y)
  base.message.send("mouse","visible",love.mouse.isVisible())
  base.message.send("mouse","position",lux.geom.point:new{x,y})
end
function handleJoystick()
  for j=0, love.joystick.getNumJoysticks() do
    if(love.joystick.open(j)) then
      for i=0, love.joystick.getNumAxes(j) do
        base.message.send("joystick","axis"..i,love.joystick.getAxis(j, i))
      end for i=0, love.joystick.getNumButtons(j) do 
        base.message.send("joystick","button"..i,love.joystick.isDown(j, i))
      end for i=0, love.joystick.getNumBalls(j) do
        local ballX, ballY = love.joystick.getBall(j, i)
        base.message.send("joystick","ballX",ballX)
        base.message.send("joystick","ballY",ballY)
      end for i=0, love.joystick.getNumHats(j) do
        base.message.send("joystick","hat",love.joystick.getHat(j, i))
      end
    love.joystick.clwose(j)
    end
  end
end

function love.mousepressed (x, y, button)
  if button == 'l' then
    content.triggers.mouse_pressedleft:activate(x, y)
  end
  base.message.send("mouse", "button_"..button, "down")
end

function love.mousereleased (x, y, button)
  if button == 'l' then
    content.triggers.mouse_releasedleft:activate(x, y)
  end
  base.message.send("mouse", "button_"..button, "up")
end

local id = 0
function love.keypressed (button)
  -- TODO bring back to life some day
  --if button == 's' then
  --  scene.save('out.lua', elements)
  --end
  content.triggers.keyboard:activate(button, 'down')
  base.message.send("keyboard", button~=' ' and 'key_'..button or 'key_space', "down")
end

function love.keyreleased (button)
  content.triggers.keyboard:activate(button, 'up')
  base.message.send("keyboard", button~=' ' and 'key_'..button or 'key_space', "up")
end

function love.draw ()
  content.triggers.draw:activate(love.graphics)
end
