
module ('content.recipes.solidbody', package.seeall)

require 'base.element'
require 'base.link'
require 'base.hitbox'

local function extract (element, value)
  return type(value) == 'function' and value(element) or value
end

function make (name, data)
  return base.element(name)
    :add_property('visible', {
      position  = extract(element, data.position),
      scale     = extract(element, data.scale),
      parts     = { extract(element, data.visual) }
    })
    :add_property('moveable', {
      speed     = extract(element, data.initial_speed)
    })
    :add_property('collides', {
      totrigger = extract(element, data.collision_trigger),
      bounds    = base.hitbox:new {
        class       = extract(element, data.collision_class),
        targetclass = extract(element, data.collision_targetclass)
      },
      base.link.create_apply {
        name = name.."'s bound size link",
        fromcontext = '',
        to = 'bounds.size',
        value = [[
          vector {
            element.visible.parts[1]:getWidth(),
            element.visible.parts[1]:getHeight()
          }
        ]]
      }
    })
    :add_property('isdestroyed', {
      when = extract(data.destroyed_when or 'never')
    })
end
