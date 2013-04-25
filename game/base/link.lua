
module ('base.link', package.seeall)

require 'lux.geom.vector'
require 'lux.functional'
require 'base.message'
require 'base.loader'

local apply_link_code = [[
  if $condition then
    property.$to = ($with)
  end
]]

local environment

local function load_code (codestring, name, additionals)
  loaded_chunk = assert(loadstring(codestring, name))
  setmetatable(additionals, { __index = environment })
  setfenv(loaded_chunk, additionals)
  return loaded_chunk
end

function set_environment (env)
  environment = env
end

function create_apply (specs)
  specs.condition = string.gsub(specs.condition or "true", '@(%w+)', 'get"%1"')
  specs.with      = string.gsub(specs.with or "", '@(%w+)', 'get"%1"')
  specs.when      = specs.when or 'update'
  local final_code  = string.gsub(apply_link_code, '%$(%w+)', specs)
  local getter      = lux.functional.bindleft(base.message.receive, specs.fromcontext)
  local env = {
    get = getter
  }
  local chunk = load_code(final_code, 'apply-link', env)
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
  local env = {
    get = getter,
    share = setter
  }
  local chunk       = load_code(final_code, 'share-link', env)
  return { action = chunk, specs = specs }
end
