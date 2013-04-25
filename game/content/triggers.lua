
module ('content.triggers', package.seeall)

local module_mttab = getmetatable(_M)

function module_mttab:__call (name)
  if self[name] then
    return self[name]
  end
  local new_trigger = base.trigger:new {}
  self[name] = new_trigger
  return new_trigger
end

local all_triggers = love.filesystem.enumerate 'content/triggers'
for _, trigger_file in ipairs(all_triggers) do
  local trigger_name = string.gsub(trigger_file, '.lua', '')
  require('content.triggers.'..trigger_name)
  content.triggers[trigger_name].name = trigger_name
end
