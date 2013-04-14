
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
        height = 32,
        color = {200, 50, 0, 100},
      }
    }
  }

element 'Image'
  :add_property 'visible' {
    pos = point{600, 600},
    size = vector{128/500, 128/500},
    parts = { image {} },
    share { incontext='homing', value='pos', as=[[pos]] }
  }
  :add_property 'moveable' {
    apply { fromcontext='player', to='speed', with=[[ 100*(@up+@down+@left+@right) ]] }
  }
  :add_property 'useskeyboard' {
    sharein = 'player',
    keys = {
      up    = { up=vector{}, down=vector{0,-1}, },
      down  = { up=vector{}, down=vector{0,1}, },
      left  = { up=vector{}, down=vector{-1,0}, },
      right = { up=vector{}, down=vector{1,0} }
    }
  }

make.creator 'FireShooter' {
 recipe = 'bullet',
 trigger = 'mouse_pressedleft',
 args = {
  name = 'Fireball',
  parts = { circle{ color={255,0,0,255} } },
  power = 10, --not used yet
  apply { fromcontext='homing', to='from', with='@pos' }
 }
}

--[[ WISH LIST ]]--
