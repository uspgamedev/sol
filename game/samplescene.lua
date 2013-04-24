
--use 'point'
--use 'vector'
use 'rectangle'
use 'circle'
use 'image'
use 'text'

element 'This is grabbable'
  :add_property 'visible' {
    pos = point{400,300}
  }
  :add_property 'grabbable' {
    useless = { x = 1 }
  }

element 'Hipster'
  :add_property 'visible' {
    pos = point{600,300},
    parts = {
      circle { radius=32, color={ 50, 50, 200, 200} },
      text { text='$moveable[1].specs.fromcontext$\n$name$' }
    }
  }
  :add_property 'moveable' {
    apply { fromcontext='homing', to='speed', with=[[ @pos and (@pos-element.visible.pos) or vector{} ]] }
  }

element 'Hipster'
  :add_property 'moveable' {}

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
    apply { fromcontext='but', to='hidden', with='@state'}
  }

element 'Image'
  :add_property 'visible' {
    pos = point{600, 600},
    size = vector{128/500, 128/500},
    parts = { image {} },
    share { incontext='homing', value='pos', as=[[pos]] }
  }
  :add_property 'moveable' {
    apply { fromcontext='player', to='speed', with=[[ @lshift*100*(@up+@down+@left+@right) ]] }
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
    apply { fromcontext='homing', to='origin', with='@pos' },
    apply { fromcontext='mouse', to='target', with='@position'},
  }
}

make.bullet 'YEAY' {
  origin = point{100,100},
  target = point{200,200},
  size = vector {2,2},
  speed = 11,
  deletetrigger = trigger_in '3'
}

element "Follower"
  : add_property "visible" {
    apply {fromcontext="mouse", to="pos", with="point {@x,@y}"}
  }
  :add_property 'collides' {
    bounds = hitbox {
      size = vector{64,64},
      class = 'target'
    }
  }
 : add_property "visible" {
 	  apply {fromcontext="mouse", to="pos", with="point {@x,@y}"}
	}
 
element "Stalker"
  :add_property "visible" {
    pos = point {200, 200},
    --apply {fromcontext="mouse", to="pos", with="@buttonl == 'up' and @position or pos"}
  }
  :add_property "moveable" {
    apply {fromcontext="mouse", to="speed", with="@buttonl == 'up' and @position-element.visible.pos or element.visible.pos-@position"}
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
  textcolor = {20,10,10,255}
}

make.creator 'Shruter' {
  recipe = 'bullet',
  trigger = 'shrute-pressed',
  args = {
    origin = point{500,300},
    speed = 70,
    parts = { circle{ color={0,200,0,255} } }
  }
}

make.creator 'Shruter2' {
  recipe = 'bullet',
  trigger = trigger_in '2',
  args = {
    origin = point{500,300},
    speed = 30,
    parts = { circle{ color={150,100,0,255} } }
  }
}

--[[ WISH LIST ]]--


make.timer 'Timer' {
  timetotrigger = .7,
  repeats = true,
  totrigger = 'timer'
}
