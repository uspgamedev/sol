
module ('content.properties', package.seeall)

require 'base.property'
require 'base.message'
require 'base.trigger'
require 'content.triggers'

clickable = base.property:new {
  requires = { 'visible' },
  sharein = 'anonymous',
  totrigger = 'never',
  shortcuts = {},
  width = 100,
  height = 100,
  textcolor = nil
}

local function getshiftcolor( color, shift )
  return {
    math.max(math.min(color[1]+shift,255),0),
    math.max(math.min(color[2]+shift,255),0),
    math.max(math.min(color[3]+shift,255),0),
    color[4]
  }
end

local function getlinecolor( color )
  return getshiftcolor(color,50)
end

local function gethovercolor( color )
  return getshiftcolor(color,20)
end

local function getdowncolor( color )
  return getshiftcolor(color,-30)
end

clickable.__init = {
  state = {},
  colorUp = {150,10,10,255},
}

function clickable:setup (element)
  base.message.send(self.sharein, 'state', self.state.down)
  self.colorUpLine = self.colorUpLine or getlinecolor(self.colorUp)
  self.colorUpHover = self.colorUpHover or gethovercolor(self.colorUp)
  if not self.colorUpHoverLine then
    if self.colorUpLine then --preference to colorUpline
      self.colorUpHoverLine = gethovercolor(self.colorUpLine)
    else
      self.colorUpHoverLine = getlinecolor(self.colorUpHover)
    end
  end
  self.colorDown = self.colorDown or getdowncolor(self.colorUp)
  self.colorDownLine = self.colorDownLine or getlinecolor(self.colorDown)
  element.visible.pos = self.pos
  element.visible.parts = {
    content.draw.rectangle:new { 
      width = self.width,
      height = self.height,
      color = self.colorUp
    }, --[1]
    content.draw.rectangle:new{
      mode = 'line',
      width = self.width,
      height = self.height,
      color = self.colorUpLine
    }, --[2]
      content.draw.text:new{
      text = "$name$",
      color = self.textcolor
    } --[3]
  }
  content.triggers(self.totrigger)
end

function clickable.triggers:mouse_entered ()
  self.visible.parts[1].color = self.clickable.colorUpHover
  self.visible.parts[2].color = self.clickable.colorUpHoverLine
end

function clickable.triggers:mouse_pressedleft ()
  base.message.send(self.clickable.sharein, 'state', self.clickable.state.up) 
  self.clickable.beingpressed = true

  self.visible.parts[1].color = self.clickable.colorDown
  self.visible.parts[2].color = self.clickable.colorDownLine

  if self.clickable.totrigger~='never' then
    content.triggers(self.clickable.totrigger):activate()
  end
end

function clickable.triggers:mouse_exited ()
  if self.clickable.beingpressed then
    self.clickable.beingpressed = false
    if self.clickable.sharein then
      base.message.send(self.clickable.sharein, 'state', self.clickable.state.down)
    end
  end

  self.visible.parts[1].color = self.clickable.colorUp
  self.visible.parts[2].color = self.clickable.colorUpLine
end

function clickable.triggers:mouse_releasedleft ()
  if self.clickable.beingpressed then
    self.clickable.beingpressed = false

    self.visible.parts[1].color = self.clickable.colorUp
    self.visible.parts[2].color = self.clickable.colorUpLine

    if self.clickable.sharein then
      base.message.send(self.clickable.sharein,'state',self.clickable.state.down)
    end
  end
end

function clickable.triggers:keyboard(button, key_state, n)
  if key_state == 'up' then return end
  for _,v in ipairs(self.clickable.shortcuts) do 
    if button == v then
      base.message.send(self.clickable.sharein, 'state', self.clickable.state.up) 
      content.triggers(self.clickable.totrigger):activate()   
      if self.clickable.sharein then
        base.message.send(self.clickable.sharein,'state',self.clickable.state.down)
      end
      return
    end 
  end
end
