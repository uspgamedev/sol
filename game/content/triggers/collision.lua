
module ('content.triggers', package.seeall)

require 'base.trigger'

collision = base.trigger:new {}

function collision:check (collided, another)
  return self == collided
end
