
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

build.keymover 'Mover' {
  sendto = 'player',
  message = 'dir',
  keymap = {
    up = vector{0,-1},
    down = vector{0,1},
    left = vector{-1,0},
    right = vector{1,0}
  }
} 

--[[ WISH LIST ]]--

--build.bullet 'Fireball' {
--  image = 'aksjdhak',
--  dir = vector{},
--  power = 10
--}

--build.creator 'Shooter' {
--  builder = 'bullet',
--  trigger = 'mouse_pressedleft',
--  map = {
--    { arg='dir', formula='vector{x,y}' }
--  }
--}

--movement_map = {
--  up = vector{0,-1},
--  down = vector{0,1},
--  left = vector{-1,0},
--  right = vector{1,0}
--}

--element 'Player'
--  :add_property 'controller' {
--    sendto = 'player',
--    update = function(self)
--      local dir = vector{}
--      for key,v in pairs(movement_map) do
--        dir = dir + (keyboard.isDown(key) and v or vector{})
--      end
--      self.controller:send('dir', 100*dir)
--    end
--  }
