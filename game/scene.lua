
module ('scene', package.seeall)

require 'lux.functional'
require 'lux.geom.vector'
require 'base.element'
require 'content.properties'

local lambda        = lux.functional
local scenefile_env = {}

local function new_element (elements, name)
  local element = base.element:new{}
  element.name = name
  table.insert(elements, element)
  return element
end

local function prepare_env (env, elements)
  env.element = lambda.bindleft(new_element, elements)
  env.point   = lambda.bindleft(lux.geom.point.new, lux.geom.point)
  env.vector  = lambda.bindleft(lux.geom.vector.new, lux.geom.vector)
  env.print   = print
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
