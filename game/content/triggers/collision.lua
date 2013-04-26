
module ('content.triggers', package.seeall)

require 'base.trigger'

collision = base.trigger:new {}

function collision:check (collided)
  return self == collided
end
