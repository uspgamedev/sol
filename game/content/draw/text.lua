
module ('content.draw', package.seeall)

require 'base.drawable'

--- Text
text = base.drawable:new {
  text = '$name$',
  linesize = 64,
  format = 'center',
  width = 0, height = 0 --avoid errors
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

function text:formatted (element)
  local text = string.gsub(self.text, "%$(.-)%$", value_accessor(element))
  local font = love.graphics.getFont()
  local width, lines = font:getWrap(text, self.linesize)
  return self.linesize, lines*font:getHeight(), text
end

function text:draw (element, graphics)
  graphics.setColor(self.color)
  width, height, text = self:formatted(element)
  graphics.printf(
    text,
    -width/2,
    -height/2,
    width,
    self.format
  )
  self.width, self.height, self.formattedtext = width, height, text
end

function text:inside (p)
  local width, height = self.width, self.height
  if p.x < -width/2 then return false end
  if p.y < -height/2 then return false end
  if p.x > width/2 then return false end
  if p.y > height/2 then return false end
  return true
end
