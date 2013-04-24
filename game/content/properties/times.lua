module ('content.properties', package.seeall)

require 'base.property'

times = base.property:new {
  timetotrigger = 1.0, -- in seconds
  timer = 0.0,       -- counts time, shouldn't be changed
  repeats = false,
  totrigger = 'never'
}

function times:setup( element )

  content.triggers(self.totrigger)
end

function times.triggers:update (dt)
  self.times.timer = self.times.timer + dt
  if self.times.timer >= self.times.timetotrigger then
    content.triggers(self.times.totrigger):activate()
    self.times.timer = self.times.timer - self.times.timetotrigger
    if not self.times.repeats then self:destroy() --[[is this illegal?]] end
  end
end

--make.timer 'Timer' {
--  timetotrigger = 2,
--  repeats = true,
--  totrigger = 'timer'
--}