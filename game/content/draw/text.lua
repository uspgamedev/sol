
module ('content.draw', package.seeall)

require 'base.drawable'

--- Text
text = base.drawable:new {
  text = '$name$',
  linesize = 64,
  format = 'center',
  fontsize = 12,
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

local fonts = {}
local function getFont( size )
  if not fonts[size] then 
    fonts[size] = love.graphics.newFont(size)
  end
  return fonts[size]
end

function text:formatted (element)
  local text = string.gsub(self.text, "%$(.-)%$", value_accessor(element))
  local font = getFont( self.fontsize )
  local width, lines = font:getWrap(text, self.linesize)
  return font, self.linesize, lines*font:getHeight(), text
end

function text:draw (element, graphics)
  graphics.setColor(self.color)
  font, width, height, text = self:formatted(element)
  love.graphics.setFont(font)
  graphics.printf(
    text,
    -width/2,
    -height/2,
    width,
    self.format
  )
  love.graphics.setFont(getFont(12))
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
