
element 'This is grabbable'
  :add_property 'visible' {
    pos = point{400,300}
  }
  :add_property 'grabbable' {}

element 'This is NOT grabbable'
  :add_property 'visible' {
    pos = point{200,200},
    size = vector{256,32}
  }
