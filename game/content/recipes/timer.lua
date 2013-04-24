module('content.recipes.timer',package.seeall)

require 'base.element'

local ID = 0

function make( name, data )
  return base.element(name)
    :add_property('times', data)
end

function trigger_in( time )
  time = time + 0
  ID = ID + 1
  make( 'timer#' .. ID, {timetotrigger = time, repeats = false,
    totrigger = 'timertrigger#' .. ID} )
  return 'timertrigger#' .. ID
end