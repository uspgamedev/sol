
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
  :add_property 'controlled' {
    source = 'player',
    map = {
      { property='moveable', attribute='speed', from='dir' }
    }
  }
  :add_property 'moveable' {}

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
  :add_property 'controller' {
    target = 'player',
    update = function(self)
      self.controller:send('dir', self.visible.pos-elements.Hipster.visible.pos)
    end
  }
  
