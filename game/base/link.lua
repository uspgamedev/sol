
module ('base.link', package.seeall)

require 'lux.geom.vector'
require 'lux.functional'
require 'base.message'

local apply_link_code = [[property.$to = ($with)]]

function create_apply (specs)
  specs.with = string.gsub(specs.with, '@(%w+)', 'get"%1"')
  local final_code  = string.gsub(apply_link_code, '%$(%w+)', specs)
  local getter      = lux.functional.bindleft(base.message.receive, specs.fromcontext)
  local chunk = assert(loadstring(final_code))
  local env = {
    get = getter,
    vector = lux.functional.bindleft(lux.geom.vector.new, lux.geom.vector),
    point = lux.functional.bindleft(lux.geom.point.new, lux.geom.point),
  }
  setfenv(chunk, env)
  return chunk
end

local share_link_code = [[share('$incontext', '$value', ($as))]]

function create_share (specs)
  specs.as = string.gsub(specs.as, '@(%w+)', 'get"%1"')
  local final_code  = string.gsub(share_link_code, '%$(%w+)', specs)
  local getter      = lux.functional.bindleft(base.message.receive, specs.fromcontext)
  local setter      = base.message.send
  local chunk       = assert(loadstring(final_code))
  local env = {
    get = getter,
    share = setter,
    vector = lux.functional.bindleft(lux.geom.vector.new, lux.geom.vector),
    point = lux.functional.bindleft(lux.geom.point.new, lux.geom.point),
  }
  setfenv(chunk, env)
  return chunk
end
