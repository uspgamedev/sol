
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
