
module ('base', package.seeall)

require 'lux.object'
require 'lux.geom.vector'

hitbox = lux.object.new {
  position    = nil,  -- point
  size        = nil,  -- vector
  class       = 'nothing',
  targetclass = ''
}

hitbox.__init = {
  position   = lux.geom.point:new {0,0},
  size  = lux.geom.vector:new {1,1}
}

local classes = {}

function hitbox:top ()
  return self.position.y
end

function hitbox:bottom ()
  return self.position.y + self.size.y
end

function hitbox:left ()
  return self.position.x
end

function hitbox:right ()
  return self.position.x + self.size.x
end

function hitbox:update(owner, dt)
  self.owner = owner
  if owner then
    self.position = owner.visible.position - self.size/2
    self:register()
  end
end

function hitbox:colliding (another)
  if self:top() > another:bottom() then
    return false
  elseif self:bottom() < another:top() then
    return false
  elseif self:left() > another:right() then
    return false
  elseif self:right() < another:left() then
    return false
  end
  return true
end

function hitbox:register (class)
  class = class or self.class
  classes[class] = classes[class] or {}
  classes[class][self] = true
end

function hitbox:unregister (class)
  if self then
    if class then
      classes[class][self] = nil
    else
      for _,possibleclass in pairs(classes) do
        possibleclass[self] = nil
      end
    end
  else
    for _,class in pairs(classes) do
      for hitbox,check in pairs(class) do
        hitbox:unregister()
      end
    end
  end
end

function hitbox:get_collisions (target)
  targetclass = classes[target or self.targetclass]
  if not targetclass then return end
  local collisions = {}
  for another,check in pairs(targetclass) do
    if check and self:colliding(another) then
      table.insert(collisions, another)
    end
  end
  return collisions
end

function hitbox.check_collisions ()
  for _,class in pairs(classes) do
    for box,check in pairs(class) do
      if check then
        local collisions = box:get_collisions()
        if collisions and box.on_collision then
          box:on_collision(collisions)
        end
      end
    end
  end
end
