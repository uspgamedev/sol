--make.creator 'shooter-placer' {
--  recipe  = 'creator',
--  trigger = 'mouse_pressedleft',
--  args = {
--    recipe = 'solidbody',
--
--  }
--}

local function gambiarra (element)
  element
    :property'collides'{
      life = 3,
      apply {
        fromcontext = '',
        to = 'life',
        when = 'collision',
        value = [[print'wat' or property.life-1]]
      },
      apply {
        fromcontext = '',
        to = 'life',
        ifcondition = 'property.life <= 0',
        also_trigger = 'death',
        value = '0'
      }
    }
  return 'collision'
end

make.creator 'turret-placer' {
  recipe  = 'solidbody',
  when    = 'mouse_pressedleft',
  args    = {
    visual = sprite{ mirror = {true, false} },
    apply { fromcontext='mouse', to='position', value='@position'},
    collision_trigger     = gambiarra,
    collision_class       = 'turret',
    collision_targetclass = 'enemy',
    destroyed_when        = 'death'
  }
}

local function start_position ()
  return point{screen.width+100, random()*screen.height}
end

make.creator 'enemy-shooter' {
  recipe  = 'solidbody',
  when    = 'ping',
  args    = {
    position = start_position,
    visual = rectangle { width = 10, height = 10, color = {100,100,100} },
    initial_speed = vector{-100,0},
    collision_class       = 'enemy',
    collision_targetclass = 'turret',
    collision_trigger     = 'collision',
    destroyed_when        = 'collision'
  }
}

make.timer 'pinger' {
  limit     = 3.0,
  repeats   = true,
  totrigger = 'ping'
}
element 'pinger': property 'counts_time' {
  apply {
    fromcontext = '',
    to          = 'limit',
    value       = [[(property.limit+0.1)*0.9]],
    when        = 'ping'
  }
}
