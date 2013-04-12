
use 'point'
use 'vector'
use 'rectangle'
use 'circle'
use 'image'

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
    size = vector{32, 32},
    draw = circle {
      color = { 50, 50, 200, 200}
    }
  }
  :add_property 'moveable' {}
  :add_property 'controlled' {
    source = 'homing',
    map = {
      { property='moveable', attribute='speed', from='pos', formula='pos-self.visible.pos' }
    }
  }

element 'Rectangle'
  :add_property 'visible' {
    pos = point{200,200},
    size = vector{256,32},
    draw = rectangle {
      color = {200, 50, 0, 100},
    }
  }

element 'Image'
  :add_property 'visible' {
    pos = point{800, 600},
    size = vector{128, 128},
    draw = image {}
  }
  :add_property 'moveable' {}
  :add_property 'controller' {
    target = 'homing',
    update = function(self)
      self.controller:send('pos', self.visible.pos)
    end
  }
  :add_property 'controlled' {
    source = 'player',
    map = {
      { property='moveable', attribute='speed', from='dir', formula='dir' }
    }
  }

--build.keymover 'Mover' {
--  target = 'player',
--  message = 'dir'
--  keymap = {
--    up = vector{0,-1},
--    down = vector{0,1},
--    left = vector{-1,0},
--    right = vector{1,0}
--  }
--} 

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

movement_map = {
  up = vector{0,-1},
  down = vector{0,1},
  left = vector{-1,0},
  right = vector{1,0}
}

element 'Player'
  :add_property 'controller' {
    target = 'player',
    update = function(self)
      local dir = vector{}
      for key,v in pairs(movement_map) do
        dir = dir + (keyboard.isDown(key) and v or vector{})
      end
      self.controller:send('dir', 100*dir)
    end
  }
