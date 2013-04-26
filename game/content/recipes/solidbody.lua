
module ('content.recipes.solidbody', package.seeall)

require 'base.element'
require 'base.link'
require 'base.hitbox'

function make (name, data)
  return base.element(name)
    :add_property('visible', {
      position  = data.position,
      scale     = data.scale,
      parts     = { data.visual }
    })
    :add_property('moveable', {
      speed     = data.initial_speed
    })
    :add_property('collides', {
      totrigger = data.collision_trigger,
      bounds    = base.hitbox:new {
        class       = data.collision_class,
        targetclass = data.collision_targetclass
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
