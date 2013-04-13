
module ('base.primitive', package.seeall)

require 'lux.object'
require 'lux.geom.vector'

--- Drawable
drawable = lux.object.new {
  color   = nil
}

drawable.__init = {
  color = {255, 255, 255, 255}
}

--- Rectangle
rectangle = drawable:new {
  mode = 'fill'
}

function rectangle:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.rectangle(
    self.mode,
    -element.visible.size.x/2,
    -element.visible.size.y/2,
    element.visible.size:unpack()
  )
end

--- Circle
circle = drawable:new {
  mode = 'fill'
}

function circle:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.circle(
    self.mode,
    0, 0,
    math.min(element.visible.size.x, element.visible.size.y)
  )
end

--- Text
text = drawable:new {
  text = '$name$',
  linesize = 64,
  format = 'center'
}

local accessor_code = [[
  return element.$
]]

local function value_accessor (element)
  return function (access_request)
    local processed = string.gsub(accessor_code, '%$', access_request)
    local chunk = assert(loadstring(processed))
    setfenv(chunk, { element = element })
    return tostring(chunk())
  end
end

function text:draw (element, graphics)
  graphics.setColor(self.color)
  local text = string.gsub(self.text, "%$(.-)%$", value_accessor(element))
  local font = graphics.getFont()
  local width, lines = font:getWrap(text, self.linesize)
  graphics.printf(
    text,
    -self.linesize/2,
    -(lines*font:getHeight())/2,
    self.linesize,
    self.format
  )
end

--- Image
image = drawable:new {
  path = 'jigsaw-box.png'
}

local cash = {}

function image:__init ()
  cash[self.path] = cash[self.path] or love.graphics.newImage('resource/images/'..self.path)
  self.data = cash[self.path]
end

function image:draw (element, graphics)
  graphics.setColor(self.color)
  graphics.draw(
    self.data,
    0,
    0,
    0,
    element.visible.size.x/self.data:getWidth(),
    element.visible.size.y/self.data:getHeight(),
    self.data:getWidth()/2,
    self.data:getHeight()/2
  )
end

--- Some mystic code
for name,primitive in pairs(_M) do
  if type(primitive) == 'table' and primitive.new then
    primitive.__type = name
  end
end

--- Copy LUX's geometric primitives.
vector  = lux.geom.vector
point   = lux.geom.point
