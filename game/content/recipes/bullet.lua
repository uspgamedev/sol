module("content.recipes.bullet",package.seeall)

require 'base.element'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'

function make( elements, name, data )
  if not data then
    return lux.functional.bindleft(content.recipes.bullet.make, elements, name)
  end

  local shot = base.element:new{}
  shot.name = name
  shot:add_property('visible',{
    pos = data.from, 
    size = data.size or lux.geom.vector:new{128/500,128/500}, 
    parts = data.parts
    })
  shot:add_property('moveable',{ speed = (data.to-data.from):normalized()*(data.speed or 50)*10 })
  elements[shot.name] = shot
  return shot
end

function create(elements, args)
  if not args.shotcount then args.shotcount = 0 end
  args.shotcount = args.shotcount + 1
  local data = {from = args.from, to = args.to, speed = args.speed, parts = args.parts}

  return make(elements, args.name .. '#' .. args.shotcount,data)
end
