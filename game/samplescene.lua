
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
    size = vector{32, 32},
    draw = circle {
      color = { 50, 50, 200, 200}
    }
  }
