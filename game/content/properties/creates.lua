
module ('content.properties', package.seeall)

require 'base.property'
require 'lux.functional'
require 'content.triggers'

creates = base.property:new {
  when        = 'never',
  recipe      = 'none',
  makerecipe  = function (name, data) return nil end,
  nextID      = 0
}

creates.__init = {
  args = {}
}

local function createfunc (element)
  for _,link in ipairs(element.creates.args) do
    getfenv(link.action).property  = element.creates.args
    link.action()
  end 
  local created = element.creates.makerecipe(
    element.creates.args.name..'(#'..element.creates.nextID..')',
    element.creates.args
  )
  element.creates.nextID = element.creates.nextID+1
end

function creates:setup (element)
  if not self.args.name then
    self.args.name = element.name .. "'s " .. self.recipe
  end
  content.triggers.register(self.when, element, createfunc)
end
