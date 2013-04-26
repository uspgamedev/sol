make.score "Right Player" {
  position = point{512 + 256, 50},
  scale = vector{4,4},
  width = 128,
  change_when = 'rightpoint',
  change = [[element.visible.score + 1]]
}

make.score "Left Player" {
  position = point{512 - 256, 50},
  scale = vector{4,4},
  width = 128,
  change_when = 'leftpoint',
  change = [[element.visible.score + 1]]
}

make.solidbody
  'Ball' {
    position              = point{screen.width/2, 400},
    visual                = rectangle{ width = 10, height = 10 },
    initial_speed         = vector{350,-350},
    collision_trigger     = 'hits-the-pad',
    collision_targetclass = 'pad'
  }
  :property 'visible' {
    apply{
      fromcontext="",
      to = "position",
      ifcondition = "element.visible.position.x >= screen.width",
      value = [[point{}+screen.size*0.5]],
      also_trigger = 'leftpoint'
    },
    apply{
      fromcontext="",
      to = "position",
      ifcondition = "element.visible.position.x <= 0",
      value = [[point{}+screen.size*0.5]],
      also_trigger = "rightpoint"
    }
  }
  :property 'moveable' {
    apply{
      fromcontext="",
      to = "speed.y",
      ifcondition = [[
        element.visible.position.y <= 5 or element.visible.position.y >= 763
      ]],
      value = [[-element.moveable.speed.y]]
    },
    apply{
      fromcontext = "",
      to = "speed.x",
      when = "hits-the-pad",
      value = [[-element.moveable.speed.x]]
    }
  }

element 'Player'
  :property 'useskeyboard' {
    sharein = 'player-controls',
    keys = {
      up    = { up=0, down=-1 },
      down  = { up=0, down=1},
      w     = { up=0, down=-1 },
      s     = { up=0, down=1}
    }
  }

local padspeed = 500

make.solidbody
  'left_pad' {
    position        = point{20, 300},
    visual          = rectangle{ width = 10, height = 50 },
    collision_class = 'pad',
  }
  :property "visible" { restrain_within('position.y', 25, 743) }
  :property "moveable" {
    apply {
      fromcontext = 'player-controls',
      to          = 'speed.y',
      value       = [[ (@w + @s) * ]]..padspeed
    }
  } 

make.solidbody
  'right_pad' {
    position        = point{1004, 300},
    visual          = rectangle{ width = 10, height = 50 },
    collision_class = 'pad',
  }
  :property "visible" { restrain_within('position.y', 25, 743) }
  :property "moveable" {
    apply {
      fromcontext = 'player-controls',
      to          = 'speed.y',
      value       = [[ (@up + @down) * ]]..padspeed
    }
  }