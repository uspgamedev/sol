
module ('base.link', package.seeall)

require 'lux.geom.vector'
require 'lux.functional'
require 'base.message'
require 'base.loader'
require 'content.triggers'

local apply_link_code = [[
  if $ifcondition then
    property.$to = ($value)
    also_trigger:activate()
  end
]]

local environment

local function load_code (codestring, name, additionals)
  loaded_chunk = assert(loadstring(codestring, name))
  setmetatable(additionals, { __index = environment })
  setfenv(loaded_chunk, additionals)
  return loaded_chunk
end

local function substitute_messages (code)
  return string.gsub(code, '@([_%w]+)', 'get"%1"')
end

function set_environment (env)
  environment = env
end

function create_apply (specs)
  specs.name          = specs.name or 'unknown-apply-link'
  specs.ifcondition   = substitute_messages(specs.ifcondition or "true")
  specs.value         = substitute_messages(specs.value or "")
  specs.when          = specs.when or 'update'
  specs.also_trigger  = specs.also_trigger or 'never'
  local final_code    = string.gsub(apply_link_code, '%$(%w+)', specs)
  local getter        =
    lux.functional.bindleft(base.message.receive, specs.fromcontext)
  local env = {
    get = getter,
    also_trigger = content.triggers(specs.also_trigger)
  }
  local chunk = load_code(final_code, specs.name, env)
  return { action = chunk, specs = specs }
end

local share_link_code = [[
  if $ifcondition then
    share('$incontext', '$valueof', ($as))
  end
]]

function create_share (specs)
  specs.name        = specs.name or 'unknown-share-link'
  specs.ifcondition = substitute_messages(specs.ifcondition or "true")
  specs.as          = substitute_messages(specs.as)
  specs.when        = specs.when or 'update'
  local final_code  = string.gsub(share_link_code, '%$(%w+)', specs)
  local getter      = lux.functional.bindleft(base.message.receive, specs.fromcontext)
  local setter      = base.message.send
  local env = {
    get = getter,
    share = setter
  }
  local chunk       = load_code(final_code, specs.nam, env)
  return { action = chunk, specs = specs }
end
