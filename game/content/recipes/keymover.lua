-- Deprecated -- use useskeyboard
module ('content.recipes.keymover', package.seeall)

require 'base.element'
require 'lux.functional'
require 'lux.geom.vector'

function new( elements,name,data )
  if not data then
    return lux.functional.bindleft(content.recipes.keymover.new, elements, name)
  end

  function data:update()
      local dir = lux.geom.vector:new{}

      for key,v in pairs(self.controller.keymap) do
        dir = dir + (love.keyboard.isDown(key) and v or lux.geom.vector:new{})
      end
      self.controller:send(self.controller.message, dir)
  end

  local player = base.element:new()
  player.name = name
  player:add_property ('controller',data)
  elements[player.name] = player
  return player
end