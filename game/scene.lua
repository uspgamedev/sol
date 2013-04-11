
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
  elements[name] = element
  return element
end

local function export_type (env, class)
  env[class.__type] = lambda.bindleft(class.new, class)
end

local function prepare_env (env, elements)
  env.element = lambda.bindleft(new_element, elements)
  export_type(env, lux.geom.point)
  export_type(env, lux.geom.vector)
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

local function dump (value)
  local t = type(value)
  if t == 'string' then
    return "[[\n"..value.."]]"
  elseif t == 'table' then
    local str = (value.__type or "").."{"
    for k,v in pairs(value) do
      if type(k) == 'string' then
        str = str..k.." = "..v..","
      else
        str = str.."["..k.."] = "..v..","
      end
    end
    return str.."}"
  elseif t == 'function' then
    return "[[\n"..string.dump(value).."\n    ]]"
  else
    return tostring(value)
  end
end

function save (filepath, elements)
  local file,err = io.open(filepath, 'w')
  if not file then
    return print(err)
  end
  for _,element in pairs(elements) do
    file:write("element ".."'"..element.name.."'\n")
    for property_name,property in pairs(element) do
      if property_name ~= 'name' then
        file:write("  :add_property '"..property_name.."' {\n")
        for key,value in pairs(property) do
          if key ~= 'requires' and key ~= 'triggers' then
            file:write("    "..key.." = "..dump(value)..",\n")
          end
        end
        file:write("  }\n")
      end
    end
  end
end
