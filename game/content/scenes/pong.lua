
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

element "bola"
  :add_property "visible"{
    position = point{screen.width/2, 400},
    parts = {
      rectangle{
        width = 10,
        height = 10  
      }
    },
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

  :add_property "moveable"{
    speed = vector{350,-350},
    apply{
      fromcontext="",
      to = "speed.y",
      ifcondition = "element.visible.position.y <= 5",
      value = [[-element.moveable.speed.y]]
    },
    apply{
      fromcontext="",
      to = "speed.y",
      ifcondition = "element.visible.position.y >= 763",
      value = [[-element.moveable.speed.y]]
    },
    apply{
      fromcontext = "",
      to = "speed.x",
      when = "noem",
      value = [[-element.moveable.speed.x]]
    }
  }

  :add_property "collides" {
    totrigger = "noem",
    bounds = hitbox{
      targetclass = "pad"
    },
    apply {
      fromcontext = '',
      to = 'bounds.size',
      value = [[
        vector{
          element.visible.parts[1].width,
          element.visible.parts[1].height}
      ]]
    }
  }

local padspeed = 500

element "left_pad"
  :add_property "visible"{
    position = point{20, 300},
    parts = {
      rectangle{
        width = 10,
        height = 50
      }
    },
    apply{
      fromcontext="",
      to = "position.y",
      ifcondition = "element.visible.position.y <= 25",
      value = [[25]]
    },
    apply{
      fromcontext="",
      to = "position.y",
      ifcondition = "element.visible.position.y >= 743",
      value = [[743]]
    }
  }

  :add_property "moveable"{

    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "key-event:w",
      value = [[
        element.moveable.speed.y+(@w_key=='down' and 1 or -1)*
        ]]..padspeed..[[
      ]]
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "key-event:s",
      value = [[
        element.moveable.speed.y-(@s_key=='down' and 1 or -1)*
        ]]..padspeed..[[
      ]]
    }
  } 

  :add_property "collides" {
    --totrigger = "noem",
    bounds = hitbox{
      class = "pad"
    },
    apply {
      fromcontext = '',
      to = 'bounds.size',
      value = [[
        vector{
          element.visible.parts[1].width,
          element.visible.parts[1].height}
      ]]
    }
  }

element "right_pad"
  :add_property "visible"{
    position = point{1004, 300},
    parts = {
      rectangle{
        width = 10,
        height = 50
      }
    },
    apply{
      fromcontext="",
      to = "position.y",
      ifcondition = "element.visible.position.y <= 25",
      value = [[25]]
    },
    apply{
      fromcontext="",
      to = "position.y",
      ifcondition = "element.visible.position.y >= 743",
      value = [[743]]
    }
  }

  :add_property "moveable"{
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "key-event:up",
      value = [[
        element.moveable.speed.y+(@up_key=='down' and 1 or -1)*
        ]]..padspeed..[[
      ]]
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "key-event:down",
      value = [[
        element.moveable.speed.y-(@down_key=='down' and 1 or -1)*
        ]]..padspeed..[[
      ]]
    }
  }

  :add_property "collides" {
   -- totrigger = "noem",
    bounds = hitbox{
      class = "pad"
    },
    apply {
      fromcontext = '',
      to = 'bounds.size',
      value = [[
        vector{
          element.visible.parts[1].width,
          element.visible.parts[1].height}
      ]]
    }
  } 