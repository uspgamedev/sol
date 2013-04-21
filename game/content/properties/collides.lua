
module ('content.properties', package.seeall)

require 'base.property'
require 'base.hitbox'
require 'content.triggers'

collides = base.property:new {
  requires = {'visible'},
  totrigger = 'never'
}

collides.__init = {
  bounds = base.hitbox:new{}
}

function collides:setup ()
  function self.bounds:on_collision (collisions)
    local collision_trigger = content.triggers(self.owner.collides.totrigger)
    for _,another in ipairs(collisions) do
      collision_trigger:activate(another.owner)
    end
  end
end

function collides.triggers:update ()
  self.collides.bounds:update(self)
end
