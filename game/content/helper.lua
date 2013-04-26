
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

function unique (some_string)
  local nextID = 0
  return function ()
    nextID = nextID + 1
    return some_string.." (#"..nextID..")"
  end
end

function get (field)
  return function (element)
    return
      assert(setfenv(loadstring("return element."..field), {element=element})) ()
  end
end
