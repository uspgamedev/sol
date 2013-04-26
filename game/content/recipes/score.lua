
module ('content.recipes.score', package.seeall)

require 'base.element'
require 'base.link'
require 'content.draw'

function make (name, data)
  return base.element(name)
    :add_property('visible', {
      position  = data.position,
      scale     = data.scale,
      parts = {
        content.draw.text:new {
          text = "$visible.score$",
          fontsize = data.fontsize,
          linesize = data.width,
          width = data.width,
          height = data.height
        }
      },
      score = data.initial_value or 0,
      base.link.create_apply {
        name  = name.."'s score link",
        to    = 'score',
        when  = data.change_when or 'never',
        value = data.change
      }
    })
end
