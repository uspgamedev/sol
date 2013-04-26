

element 'This is grabbable'
  :add_property 'visible' {
    pos = point{400,300},
    apply {
      fromcontext = '',
      to = 'pos',
      value = [[
        vector{
          400+20*cos(element.counts_time.counter*pi),
          300+20*sin(element.counts_time.counter*pi)
        }
      ]]
    }
  }
  :add_property 'grabbable' {
    useless = { x = 1 }
  }
  :add_property 'counts_time' {
    repeats = true,
    limit   = 2.0
  }

element 'Hipster'
  :add_property 'visible' {
    pos = point{600,300},
    parts = {
      circle { radius=32, color={ 50, 50, 200, 200} },
      text { text='$moveable[1].specs.fromcontext$\n$name$',fontsize = 50 }
    }
  }
  :add_property 'moveable' {
    apply {
      fromcontext = 'homing',
      to = 'speed',
      value = [[ @pos-element.visible.pos ]],
      condition = [[ @pos ~= nil ]]
    }
  }

element 'Rectangle'
  :add_property 'visible' {
    pos = point{200,200},
    parts = {
      rectangle {
        width = 256,
        height = 100,
        color = {200, 50, 0, 100},
      }
    },
    apply { fromcontext='but', to='hidden', value='@state'}
  }

element 'Image'
  :add_property 'visible' {
    pos = point{600, 600},
    size = vector{128/500, 128/500},
    parts = { image {} },
    share {
      incontext = 'homing',
      valueof   = 'pos',
      as        = [[element.visible.pos]]
    }
  }
  :add_property 'moveable' {
    apply {
      fromcontext = 'player',
      to = 'speed',
      value = [[ @lshift*100*(@up+@down+@left+@right) ]]
    }
  }
  :add_property 'useskeyboard' {
    sharein = 'player',
    keys = {
      up    = { up=vector{}, down=vector{0,-1}, },
      down  = { up=vector{}, down=vector{0,1}, },
      left  = { up=vector{}, down=vector{-1,0}, },
      right = { up=vector{}, down=vector{1,0} },
      lshift = { up=1 , down= 3}
    }
  }

make.creator 'FireShooter' {
  recipe = 'bullet',
  trigger = 'mouse_pressedleft',
  args = {
    name = 'Fireball',
    parts = { circle{ color={255,0,0,255} } },
    power = 10, --not used yet
    apply { fromcontext='homing', to='origin', value='@pos' },
    apply { fromcontext='mouse', to='target', value='@position'},
  }
}

make.bullet 'YEAY' {
  origin = point{100,100},
  target = point{200,200},
  size = vector {2,2},
  speed = 11,
  destroyed_when = 'gotcha',
  also_trigger = 'YEAY_DEATH',
}

make.creator 'Explosion-Effect' {
  recipe = 'explosioneffect',
  trigger = 'YEAY_DEATH',
  number = 13,
  args = {
    origin = point{300,300},
    speed = 70,
    parts = { rectangle{ color={0,200,0,255} } }
  }
}

element "Follower"
  : add_property "visible" {
    apply {fromcontext="mouse", to="pos", value="point {@x,@y}"}
  }
  :add_property 'collides' {
    bounds = hitbox {
      size = vector{64,64},
      class = 'target'
    }
  }
 
element "Stalker"
  :add_property "visible" {
    pos = point {200, 200},
  }
  :add_property "moveable" {
    apply {
      fromcontext = "mouse",
      to = "speed",
      value = [[ @position-element.visible.pos ]],
      when = 'keyboard'
    }
  }
  :add_property 'collides' {
    totrigger = 'gotcha',
    bounds = hitbox {
      size = vector {64,64},
      targetclass = 'target'
    }
  }
 
make.button 'awesomebutton' {
  pos = point {100,100},
  sharein = 'but',
  state = { up = false, down = true},
  pos = point {100,100}
}

make.button 'Shrute' {
  pos = point{500,300},
  width = 80,
  height = 30,
  totrigger = 'shrute-pressed',
  colorUp = {0,120,0,255},
  colorUpLine = {0,20,180,255},
  colorDown = {0,140,140,255},
  textcolor = {20,10,10,255},
  shortcuts = {'r', 'e'}
}

make.creator 'Shruter' {
  recipe = 'bullet',
  trigger = {'shrute-pressed','timer'},
  args = {
    origin = point{500,300},
    speed = 70,
    parts = { circle{ color={0,200,0,255} } }
  }
}

make.creator 'Shruter2' {
  recipe = 'bullet',
  trigger = trigger_in '2',
  number = 12,
  args = {
    origin = point{500,300},
    speed = 30,
    parts = { circle{ color={150,100,0,255} } }
  }
}

make.timer 'Timer' {
  timetotrigger = .7,
  repeats = true,
  totrigger = 'timer'
}
--[[ WISH LIST ]]--