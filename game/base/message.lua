
module ('base.message', package.seeall)

require 'lux.object'

local targets = {}

function send (target, what, value)
  targets[target] = targets[target] or {}
  targets[target][what] = value
end

function receive (source, what)
  if not targets[source] then return end
  return targets[source][what]
end
