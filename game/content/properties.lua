
module ('content.properties', package.seeall)

local all_properties = love.filesystem.enumerate 'content/properties'
for _, property_file in ipairs(all_properties) do
  require('content.properties.'..string.gsub(property_file, '.lua', ''))
end
