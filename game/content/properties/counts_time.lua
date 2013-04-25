
module ('content.properties', package.seeall)

require 'base.property'

counts_time = base.property:new {
  limit     = 1.0,    -- in seconds
  counter   = 0.0,    -- counts time, shouldn't be changed
  repeats   = false,
  totrigger = 'never'
}

function counts_time:setup( element )
  content.triggers(self.totrigger)
end

function counts_time.triggers:update (dt)
  if self.counts_time.counter >= self.counts_time.limit then return end
  self.counts_time.counter = self.counts_time.counter + dt
  if self.counts_time.counter >= self.counts_time.limit then
    content.triggers(self.counts_time.totrigger):activate()
    self.counts_time.counter = self.counts_time.counter - self.counts_time.limit
    if not self.counts_time.repeats then
      self:destroy()
    else
      self.counts_time.counter =  0.0
    end
  end
end

--make.timer 'Timer' {
--  timetotrigger = 2,
--  repeats = true,
--  totrigger = 'timer'
--}