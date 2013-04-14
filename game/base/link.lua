
module ('base.link', package.seeall)

require 'lux.functional'
require 'base.message'

local apply_link_code = [[property.$to = $with]]

function create (specs)
  specs.with = string.gsub(specs.with, '@(%w+)', 'get"%1"')
  local final_code  = string.gsub(apply_link_code, '%$(%w+)', specs)
  local contoller   = specs.controller
  local getter      = lux.functional.bindleft(base.message.receive, controller)
  local chunk = assert(loadstring(final_code))
  setfenv(chunk, { get = getter })
  return chunk
end
