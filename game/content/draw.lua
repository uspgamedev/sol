
module ('content.draw', package.seeall)

local all_draws = love.filesystem.enumerate 'content/draw'
for _, draw_file in ipairs(all_draws) do
  require('content.draw.'..string.gsub(draw_file, '.lua', ''))
end

--- Some mystic code
for name,drawable in pairs(_M) do
  if type(drawable) == 'table' and drawable.new then
    drawable.__type = name
  end
end
