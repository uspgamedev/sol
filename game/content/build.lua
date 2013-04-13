module ('content.build', package.seeall)

local all_build = love.filesystem.enumerate 'content/build'
for _, build_file in pairs(all_build) do
  require('content.build.'..string.gsub(build_file, '.lua', ''))
end