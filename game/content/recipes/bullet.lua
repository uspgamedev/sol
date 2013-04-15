module("content.recipes.bullet",package.seeall)

require 'base.element'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'

function new( elements, name, data )
  if not data then
    return lux.functional.bindleft(content.recipes.bullet.new, elements, name)
  end

  local shot = base.element:new{}
  shot.name = name
  shot:add_property('visible',{
    pos = data.from, 
    size = data.size or lux.geom.vector:new{128/500,128/500}, 
    parts = data.parts
    })
  shot:add_property('moveable',{ speed = data.to-data.from })
  elements[shot.name] = shot
  return shot
end

function create(elements, args, x,y)
  if not args.shotcount then args.shotcount = 0 end
  args.shotcount = args.shotcount + 1
  local data = {from = args.from, to = lux.geom.point:new{x,y}, parts = args.parts}

  return new(elements, args.name .. '#' .. args.shotcount,data)
end