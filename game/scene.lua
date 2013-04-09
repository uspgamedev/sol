
module ('scene', package.seeall)

require 'lux.functional'
require 'lux.geom.vector'

local lambda        = lux.functional
local scenefile_env = {}

local function get_element_type (typename)
  
end

local function new_element (elements, name, info)
  info.type = info.type or 'element'
  info.data.name = name
  table.insert(elements, get_element_type(info.type):new(info.data))
end

local function prepare_env (env, elements)
  env.element = lambda.chain((lambda.bindleft(new_element, env)), 1)
  env.point   = lambda.bindleft(lux.geom.vector.new, lux.geom.vector)
end

function load (file)
  local ok, chunk, result
  ok, chunk = pcall(love.filesystem.load, file) -- load the chunk safely
  if not ok then
    return print('The following error happend: ' .. tostring(chunk))
  else
    local elements = {}
    local env = {}
    prepare_env(env, elements)
    setfenv(chunk, env)
    ok, result = pcall(chunk) -- execute the chunk safely
    if not ok then -- will be false if there is an error
      print('The following error happened: ' .. tostring(result))
    end
    return elements
  end
end
