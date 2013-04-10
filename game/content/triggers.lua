
module ('content.triggers', package.seeall)

local all_triggers = love.filesystem.enumerate 'content/triggers'
for _, trigger_file in ipairs(all_triggers) do
  require('content.triggers.'..string.gsub(trigger_file, '.lua', ''))
end
