
module ('content.draw', package.seeall)

require 'base.drawable'
require 'lux.geom.vector'

sprite = base.drawable:new {
  path = 'hornbeast',
}

local img_cash, sprite_cash = {}, {}

function sprite:__init ()
  local new_sprite = 
    sprite_cash[self.path]
    or
    love.filesystem.load("resource/sprites/"..self.path..".lua") ()
  sprite_cash[self.path] = new_sprite
  for k,v in pairs(new_sprite) do
    self[k] = v
  end
  img_cash[self.img] =
    img_cash[self.img]
    or
    love.graphics.newImage('resource/images/'..self.img)
  self.img = img_cash[self.img]
  --
  self.quads = {}
  for i=1, self.maxframe.i do
    self.quads[i] = {}
    for j=1, self.maxframe.j do
      self.quads[i][j] = love.graphics.newQuad(
        self.framesize.x*(j-1),
        self.framesize.y*(i-1),
        self.framesize.x, self.framesize.y, self.img:getWidth(), self.img:getHeight()
      )
    end
  end
  self.frame = self.frame or {i=1,j=1}
  self.mirror = self.mirror or {false, false}
end

function sprite:getWidth ()
  return self.framesize.x
end

function sprite:getHeight ()
  return self.framesize.y
end

function sprite:draw (element, graphics)
  graphics.setColor(self.color)
  self.quads[self.frame.i][self.frame.j]:flip(unpack(self.mirror))
  graphics.drawq(
    self.img,
    self.quads[self.frame.i][self.frame.j],
    0, 0,
    0, 1, 1,
    self.hotspot:unpack()
  )
  self.quads[self.frame.i][self.frame.j]:flip(unpack(self.mirror))
end

function sprite:inside (p)
  local width, height = self.data:getWidth(), self.data:getHeight()
  if p.x < -width/2 then return false end
  if p.y < -height/2 then return false end
  if p.x > width/2 then return false end
  if p.y > height/2 then return false end
  return true
end
