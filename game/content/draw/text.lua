
module ('content.draw', package.seeall)

require 'base.drawable'

--- Text
text = base.drawable:new {
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

function text:formatted ()
  local text = string.gsub(self.text, "%$(.-)%$", value_accessor(element))
  local font = love.graphics.getFont()
  local width, lines = font:getWrap(text, self.linesize)
  return self.linesize, lines*font:getHeight(), text
end

function text:draw (element, graphics)
  graphics.setColor(self.color)
  local width, height, text = self:formatted()
  graphics.printf(
    text,
    -width/2,
    -height/2,
    width,
    self.format
  )
end

function text:within (p)
  return false
end
