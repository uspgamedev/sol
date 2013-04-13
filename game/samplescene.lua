
--use 'point'
--use 'vector'
use 'rectangle'
use 'circle'
--use 'image'
--use 'text'

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
      --text { text='$controlled.receivefrom$' }
    }
  }
--  :add_property 'moveable' {}
--  :add_property 'controlled' {
--    receivefrom = 'homing',
--    --link { messages='pos', to='self.moveable.speed', with='pos-self.visible.pos'}
--    map = {
--      { property='moveable', attribute='speed', from='pos', formula='pos-self.visible.pos' }
--    }
--  }

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

--element 'Image'
--  :add_property 'visible' {
--    pos = point{800, 600},
--    size = vector{128, 128},
--    draw = { image {} }
--  }
--  :add_property 'moveable' {}
--  :add_property 'controller' {
--    sendto = 'homing',
--    update = function(self)
--      self.controller:send('pos', self.visible.pos)
--    end
--  }
--  :add_property 'controlled' {
--    receivefrom = 'player',
--    map = {
--      { property='moveable', attribute='speed', from='dir', formula='dir*100' }
--    }
--  }
--
--build.keymover 'Mover' {
--  target = 'player', -- TODO change to 'sendto'
--  message = 'dir',
--  keymap = {
--    up = vector{0,-1},
--    down = vector{0,1},
--    left = vector{-1,0},
--    right = vector{1,0}
--  }
--} 

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
