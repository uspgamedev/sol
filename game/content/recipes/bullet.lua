module("content.recipes.bullet",package.seeall)

require 'base.element'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'

function make (name, data)

  local target = data.target
  if not target then
    target = lux.geom.point:new{
      math.random(love.graphics.getWidth()),
      math.random(love.graphics.getHeight())
    }
  end 

  return base.element(name)
    :add_property('visible', {
      position  = data.origin, 
      scale     = data.scale or lux.geom.vector:new{128/500,128/500}, 
      parts     = data.parts
    })
    :add_property('moveable', {
      speed = (target-data.origin):normalized()*(data.speed or 50)*10
    })
    :add_property('isdestroyed', {
      when = data.destroyed_when or 'never'
    })
end
