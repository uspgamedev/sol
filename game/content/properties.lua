
module ('content.properties', package.seeall)

require 'content.properties.grabbable'
require 'content.properties.visible'

function get (name)
  return content.properties[name]
end

getmetatable(_M).__call = function (_, name) return get(name) end
