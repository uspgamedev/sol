module("content.recipes.bullet",package.seeall)

require 'base.element'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'

function create(elements, args, x,y)
  local to = lux.geom.point:new{x,y}
  if not args.shotcount then args.shotcount = 0 end
  args.shotcount = args.shotcount + 1
  local shot = base.element:new{ name = args.name .. '#' .. args.shotcount }
  local visibledata = {
    pos = args.from,
    size = lux.geom.vector:new{128/500, 128/500}
  }

  if args.image then visibledata.parts = { content.draw.image:new(--[[args.image]]) }
  else visibledata.parts = args.parts end

  shot:add_property('visible',visibledata)
  shot:add_property('moveable',{speed = to-args.from})
  elements[shot.name] = shot
  return shot
end