
module ('base.link', package.seeall)

require 'lux.geom.vector'
require 'lux.functional'
require 'base.message'

local apply_link_code = [[
  if $condition then
    property.$to = ($with)
  end
]]

function create_apply (specs)
  specs.condition = string.gsub(specs.condition or "true", '@(%w+)', 'get"%1"')
  specs.with      = string.gsub(specs.with or "", '@(%w+)', 'get"%1"')
  specs.when      = specs.when or 'update'
  local final_code  = string.gsub(apply_link_code, '%$(%w+)', specs)
  local getter      = lux.functional.bindleft(base.message.receive, specs.fromcontext)
  local chunk = assert(loadstring(final_code))
  local env = {
    get = getter,
    vector = lux.functional.bindleft(lux.geom.vector.new, lux.geom.vector),
    point = lux.functional.bindleft(lux.geom.point.new, lux.geom.point),
  }
  setfenv(chunk, env)
  return { action = chunk, specs = specs }
end

local share_link_code = [[
  if $condition then
    share('$incontext', '$value', ($as))
  end
]]

function create_share (specs)
  specs.condition = string.gsub(specs.condition or "true", '@(%w+)', 'get"%1"')
  specs.as        = string.gsub(specs.as, '@(%w+)', 'get"%1"')
  specs.when      = specs.when or 'update'
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
  return { action = chunk, specs = specs }
end
