
module ('content.helper', package.seeall)

require 'base.link'

function restrain_within (attrib, lower, upper)
  return
    base.link.create_apply {
      name        = "Check lower bound for "..attrib,
      fromcontext = '',
      to          = attrib,
      ifcondition = "property."..attrib.." <= "..lower,
      value       = lower
    },
    base.link.create_apply {
      name        = "Check upper bound for "..attrib,
      fromcontext = '',
      to          = attrib,
      ifcondition = "property."..attrib.." >= "..upper,
      value       = upper
    }
end

local uniques = {}

function unique (some_string)
  if uniques[some_string] then return uniques[some_string] end
  local nextID = 0
  uniques[some_string] = function ()
    nextID = nextID + 1
    return some_string.." (#"..nextID..")"
  end
  return uniques[some_string]
end

function get (field)
  return function (element)
    return
      assert(setfenv(loadstring("return element."..field), {element=element})) ()
  end
end
