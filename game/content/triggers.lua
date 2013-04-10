
module ('content.triggers', package.seeall)

require 'content.triggers.update'
require 'content.triggers.draw'
require 'content.triggers.mouse_pressedleft'
require 'content.triggers.mouse_releasedleft'

function get (name)
  return content.triggers[name]
end

getmetatable(_M).__call = function (_, name) return get(name) end
