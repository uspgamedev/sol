element "scoreright"
  :add_property "visible"{
    pos = point{512 + 256, 50}, 
    size = vector{4,4},
    parts = {
      text {
        text = "$visible.score$",
        linesize = 128,
        width = 128,
        height = 32
      }
    },
    score = 0,
    apply {
      fromcontext = "",
      to = "score",
      when = "rightpoint",
      value = [[element.visible.score + 1]]
    }
  }

element "scoreleft"
  :add_property "visible"{
    pos = point{512 - 256, 50}, 
    size = vector{4,4},
    parts = {
      text {
        text = "$visible.score$",
        linesize = 128,
        width = 128,
        height = 32
      }
    },
    score = 0,
    apply {
      fromcontext = "",
      to = "score",
      when = "leftpoint",
      value = [[element.visible.score + 1]]
    }
  }

element "bola"
  :add_property "visible"{
    pos = point{screen.width/2, 400},
    parts = {
      rectangle{
        width = 10,
        height = 10  
      }
    },
    apply{
      fromcontext="",
      to = "pos",
      condition = "element.visible.pos.x >= screen.width",
      value = [[point{}+screen.size*0.5]],
      also_trigger = 'leftpoint'
    },
    apply{
      fromcontext="",
      to = "pos",
      condition = "element.visible.pos.x <= 0",
      value = [[point{}+screen.size*0.5]],
      also_trigger = "rightpoint"
    }
  }

  :add_property "moveable"{
    speed = vector{350,-350},
    apply{
      fromcontext="",
      to = "speed.y",
      condition = "element.visible.pos.y <= 5",
      value = [[-element.moveable.speed.y]]
    },
    apply{
      fromcontext="",
      to = "speed.y",
      condition = "element.visible.pos.y >= 763",
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
    pos = point{20, 300},
    parts = {
      rectangle{
        width = 10,
        height = 50
      }
    },
    apply{
      fromcontext="",
      to = "pos.y",
      condition = "element.visible.pos.y <= 25",
      value = [[25]]
    },
    apply{
      fromcontext="",
      to = "pos.y",
      condition = "element.visible.pos.y >= 743",
      value = [[743]]
    }
  }

  :add_property "moveable"{

    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "key:w",
      value = [[
        element.moveable.speed.y+(@keyw=='down' and 1 or -1)*
        ]]..padspeed..[[
      ]]
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "key:s",
      value = [[
        element.moveable.speed.y-(@keys=='down' and 1 or -1)*
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
    pos = point{1004, 300},
    parts = {
      rectangle{
        width = 10,
        height = 50
      }
    },
    apply{
      fromcontext="",
      to = "pos.y",
      condition = "element.visible.pos.y <= 25",
      value = [[25]]
    },
    apply{
      fromcontext="",
      to = "pos.y",
      condition = "element.visible.pos.y >= 743",
      value = [[743]]
    }
  }

  :add_property "moveable"{
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "key:up",
      value = [[
        element.moveable.speed.y+(@keyup=='down' and 1 or -1)*
        ]]..padspeed..[[
      ]]
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "key:down",
      value = [[
        element.moveable.speed.y-(@keydown=='down' and 1 or -1)*
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