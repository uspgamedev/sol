module("content.recipes.button",package.seeall)

require 'base.element'
require 'base.message'
require 'lux.functional'
require 'lux.geom.vector'
require 'content.draw'

local function getshiftcolor( color, shift )
  return {
          math.max(math.min(color[1]+shift,255),0),
          math.max(math.min(color[2]+shift,255),0),
          math.max(math.min(color[3]+shift,255),0),
          color[4]}
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

function make ( elements, name, data)
    if elements[name] then return elements[name] end
    if not data then
      return lux.functional.bindleft(content.recipes.button.make, elements, name)
    end
    
    local element = base.element:new()
    element.name = name

    local colorUp = data.colorUp or {150,10,10,255}
    local colorUpLine = data.colorUpLine or getlinecolor(colorUp)
    local colorUpHover = data.colorUpHover or gethovercolor(colorUp)
    local colorUpHoverLine = data.colorUpHoverLine
    if not colorUpHoverLine then
      if data.colorUpLine then colorUpHoverLine = gethovercolor(colorUpLine) --preference to colorUpline
      else colorUpHoverLine = getlinecolor(colorUpHover) end
    end
    local colorDown = data.colorDown or getdowncolor(colorUp)
    local colorDownLine = data.colorDownLine or getlinecolor(colorDown)

    element:add_property('visible', {
        pos = data.pos,
        parts = { content.draw.rectangle:new { 
           width = data.width or 100,
           height = data.height or 100,
           color = colorUp
           }, --[1]
           content.draw.rectangle:new{
           mode = 'line',
           width = data.width or 100,
           height = data.height or 100,
           color = colorUpLine
         }, --[2]
         content.draw.text:new{
         text = "$name$",
         color = data.textcolor
       } --[3]
        },
        sharein = data.sharein,
        state = data.state,
        totrigger = {},

        buttoncolors = {
        colorUp = colorUp,
        colorUpLine = colorUpLine,
        colorUpHover = colorUpHover,
        colorUpHoverLine = colorUpHoverLine,
        colorDown = colorDown,
        colorDownLine = colorDownLine
      }
      }
    )

    if data.sharein then base.message.send(data.sharein,'state', data.state.down) end

    function element.visible.triggers:mouse_entered()
      self.visible.parts[1].color = self.visible.buttoncolors.colorUpHover
      self.visible.parts[2].color = self.visible.buttoncolors.colorUpHoverLine
    end

    function element.visible.triggers:mouse_pressedleft()
      if self.visible.sharein then 
        base.message.send(self.visible.sharein,'state', self.visible.state.up) 
      end
      self.visible.beingpressed = true

      self.visible.parts[1].color = self.visible.buttoncolors.colorDown
      self.visible.parts[2].color = self.visible.buttoncolors.colorDownLine

      for _,trig in ipairs(self.visible.totrigger) do trig() end
    end

    function element.visible.triggers:mouse_exited()
      if self.visible.beingpressed then
        self.visible.beingpressed = false
        if self.visible.sharein then base.message.send(self.visible.sharein,'state',self.visible.state.down) end
      end

      self.visible.parts[1].color = self.visible.buttoncolors.colorUp
      self.visible.parts[2].color = self.visible.buttoncolors.colorUpLine
    end

    function element.visible.triggers:mouse_releasedleft()
      if self.visible.beingpressed then
        self.visible.beingpressed = false

        self.visible.parts[1].color = self.visible.buttoncolors.colorUp
        self.visible.parts[2].color = self.visible.buttoncolors.colorUpLine

        if self.visible.sharein then base.message.send(self.visible.sharein,'state',self.visible.state.down) end
      end
    end
    element.visible:add_triggers(element)

    elements[element.name] = element
    return element
end

function trigger( elements, name )
  return elements[name].visible.totrigger
end
