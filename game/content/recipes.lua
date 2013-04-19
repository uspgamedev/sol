module ('content.recipes', package.seeall)

local all_recipes = love.filesystem.enumerate 'content/recipes'
for _, recipe_file in pairs(all_recipes) do
  require('content.recipes.'..string.gsub(recipe_file, '.lua', ''))
end