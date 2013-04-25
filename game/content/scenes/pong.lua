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
      with = [[element.visible.score + 1]]
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
      with = [[element.visible.score + 1]]
    }
  }

element "bola"
  :add_property "visible"{
    pos = point{512, 400},
    parts = {
      rectangle{
        width = 10,
        height = 10  
      }
    },
    apply{
      fromcontext="",
      to = "pos",
      condition = "element.visible.pos.x >= 1024",
      with = [[point{512,384}]],
      also_trigger = 'leftpoint'
    },
    apply{
      fromcontext="",
      to = "pos",
      condition = "element.visible.pos.x <= 0",
      with = [[point{512,384}]],
      also_trigger = "rightpoint"
    }
  }

  :add_property "moveable"{
    speed = vector{350,-350},
    apply{
      fromcontext="",
      to = "speed.y",
      condition = "element.visible.pos.y <= 5",
      with = [[-element.moveable.speed.y]]
    },
    apply{
      fromcontext="",
      to = "speed.y",
      condition = "element.visible.pos.y >= 763",
      with = [[-element.moveable.speed.y]]
    },
    apply{
      fromcontext = "",
      to = "speed.x",
      when = "noem",
      with = [[-element.moveable.speed.x]]
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
      with = [[
        vector{
          element.visible.parts[1].width,
          element.visible.parts[1].height}
      ]]
    }
  }

local padspeed = 200

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
      with = [[25]]
    },
    apply{
      fromcontext="",
      to = "pos.y",
      condition = "element.visible.pos.y >= 743",
      with = [[743]]
    }
  }

  :add_property "moveable"{
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "keydown:w",
      with = [[element.moveable.speed.y-]]..padspeed
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "keydown:s",
      with = [[element.moveable.speed.y+]]..padspeed
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "keyup:w",
      with = [[element.moveable.speed.y+]]..padspeed
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "keyup:s",
      with = [[element.moveable.speed.y-]]..padspeed
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
      with = [[
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
      with = [[25]]
    },
    apply{
      fromcontext="",
      to = "pos.y",
      condition = "element.visible.pos.y >= 743",
      with = [[743]]
    }
  }

  :add_property "moveable"{
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "keydown:up",
      with = [[element.moveable.speed.y-]]..padspeed
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "keydown:down",
      with = [[element.moveable.speed.y+]]..padspeed
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "keyup:up",
      with = [[element.moveable.speed.y+]]..padspeed
    },
    apply{
      fromcontext = "keyboard",
      to = "speed.y",
      when = "keyup:down",
      with = [[element.moveable.speed.y-]]..padspeed
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
      with = [[
        vector{
          element.visible.parts[1].width,
          element.visible.parts[1].height}
      ]]
    }
  } 