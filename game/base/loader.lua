
module ('base.loader', package.seeall)

require 'lux.geom.vector'
require 'lux.functional'
require 'base.element'
require 'base.link'
require 'base.hitbox'
require 'content.draw'
require 'content.recipes'
require 'content.helper'

local lambda = lux.functional

local exported_globals = {
  'assert',
  'dofile',
  'error',
  'ipairs',
  'next',
  'pairs',
  'pcall',
  'print',
  'select',
  'tonumber',
  'tostring',
  'type',
  'unpack'
}

local env

local function export (name, exported)
  env[name] = lambda.bindleft(exported.new, exported)
end

local function export_globals ()
  for _,global in ipairs(exported_globals) do
    env[global] = _G[global]
  end
end

local function export_math ()
  for name,mathfunc in pairs(math) do
    env[name] = mathfunc
  end
end

local function export_draws ()
  for name,draw in pairs(content.draw) do
    if type(draw) == 'table' and draw.new then
      export(name, draw)
    end
  end
end

local function make_recipe (recipe_name, elem_name, data)
  if base.element.exists(elem_name) then return base.element(name) end
  local element = content.recipes[recipe_name].make(elem_name, data)
  return element
end

local function export_recipes ()
  env.make = {}
  for recipe_name,recipe in pairs(content.recipes) do
    env.make[recipe_name] = lambda.chain(
      lambda.bindleft(make_recipe, recipe_name),
      1
    )
  end
end

function setup ()
  env = {}
  env.element = base.element
  env.apply   = base.link.create_apply
  env.share   = base.link.create_share 
  env.screen  = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight(),
    size = lux.geom.vector:new{
      love.graphics.getWidth(),
      love.graphics.getHeight()
    }
  }
  export_globals()
  export_math()
  export_draws()
  export('vector', lux.geom.vector)
  export('point', lux.geom.point)
  export('hitbox', base.hitbox)
  export_recipes()
  base.link.set_environment(env)
  -- TODO organize these helper functions
  env.wait = content.recipes.timer.wait
  env.restrain_within = content.helper.restrain_within
end

function runscript (filename)
  loaded_chunk = assert(love.filesystem.load(filename))
  setfenv(loaded_chunk, setmetatable({}, { __index = env }))
  loaded_chunk()
end
