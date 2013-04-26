
module ('content.recipes.solidbody', package.seeall)

require 'base.element'
require 'base.link'
require 'base.hitbox'

local function extract (value)
  return type(value) == 'function' and value() or value
end

function make (name, data)
  return base.element(name)
    :add_property('visible', {
      position  = extract(data.position),
      scale     = extract(data.scale),
      parts     = { extract(data.visual) }
    })
    :add_property('moveable', {
      speed     = extract(data.initial_speed)
    })
    :add_property('collides', {
      totrigger = extract(data.collision_trigger),
      bounds    = base.hitbox:new {
        class       = extract(data.collision_class),
        targetclass = extract(data.collision_targetclass)
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
end
