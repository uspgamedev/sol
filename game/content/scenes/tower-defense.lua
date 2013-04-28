
local function gambiarra (element)
  element
    :property'collides'{
      life = 3,
      apply {
        fromcontext = '',
        to = 'life',
        when = 'collision',
        value = [[property.life-1]]
      },
      apply {
        fromcontext = '',
        to = 'life',
        when = 'collision',
        value = [[property.life]],
        also_trigger = 'point'
      },
      apply {
        fromcontext = '',
        to = 'life',
        ifcondition = 'property.life <= 0',
        also_trigger = unique 'death' (element),
        value = '0'
      },
    }
  return 'collision'
end

local function get_deathtrigger (element)
  return element.collides[3].specs.also_trigger
end

element 'Player'
  :property 'counts_time'{
    repeats = true,
    apply {
      fromcontext='money',
      to='counter',
      when='mouse_pressedleft',
      value='property.counter',
      ifcondition='@value >= 1',
      also_trigger='create'
    },
  }

make.score 'money' {
  initial_value = 10,
  position      = point{100,100},
  fontsize      = 18,
  change_when   = 'create',
  change        = [[element.visible.score-1]]
}
element 'money'
  :property 'visible' {
    share {
      incontext='money',
      valueof='value',
      as=[[property.score]]
    },
    apply {
      fromcontext='',
      to='score',
      value=[[property.score+0.3]],
      when='point'
    }
  }

make.creator 'turret-placer' {
  recipe  = 'solidbody',
  when    = 'create',
  args    = {
    visual = sprite{ mirror = {true, false} },
    apply { fromcontext='mouse', to='position', value='@position'},
    collision_trigger     = gambiarra,
    collision_class       = 'turret',
    collision_targetclass = 'enemy',
    destroyed_when        = get_deathtrigger
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
    initial_speed         = vector{-100,0},
    collision_class       = 'enemy',
    collision_targetclass = 'turret',
    collision_trigger     = 'collision',
    destroyed_when        = 'collision'
  }
}

make.solidbody 'wall' {
  position              = point{10,screen.height/2},
  visual                = rectangle{ width=10, height=screen.height},
  collision_class       = 'turret',
  --collision_targetclass = 'enemy',
  --collision_trigger     = 'damage'
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
