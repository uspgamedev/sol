
use 'point'
use 'vector'
use 'rectangle'
use 'circle'

element 'This is grabbable'
  :add_property 'visible' {
    pos = point{400,300}
  }
  :add_property 'grabbable' {
    useless = { x = 1 }
  }

element 'Rectangle'
  :add_property 'visible' {
    pos = point{200,200},
    size = vector{256,32},
    draw = rectangle {
      color = {200, 50, 0, 100},
    }
  }

element 'Hipster'
  :add_property 'visible' {
    pos = point{600,300},
    draw = circle {
      color = { 50, 50, 200, 200}
    }
    --draw = function (self, graphics)
    --  graphics.setColor(150, 150, 255, 100)
    --  graphics.circle('fill', self.visible.size.x/2, self.visible.size.y/2, 10)
    --  graphics.setColor(150, 150, 150, 255)
    --  graphics.circle('line', self.visible.size.x/2, self.visible.size.y/2, 10)
    --  graphics.setColor(200, 200, 100, 255)
    --end
  }
