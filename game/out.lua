element 'Hipster'
  :add_property 'visible' {
    parts = {[1] = circle{color = {[1] = 50,[2] = 50,[3] = 200,[4] = 200,},radius = 32,},[2] = text{width = 64,height = 28,text = [[
$moveable[1].specs.fromcontext$
$name$]],color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},formattedtext = [[
homing
Hipster]],},},
    pos = vector{[1] = 600,[2] = 599.99068968518,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    1 = {action = [[
LuaQ  M   property.speed = ( get"pos" and (get"pos"-element.visible.pos) or vector{} )                 E�  ��  \� Z    �E�  ��  \� �  �@A��@M�� Z@  � �E� �   \� 	@�� �    	   property    speed    get    pos    element    visible    vector                                                                            
    ]],specs = {with = [[
 get"pos" and (get"pos"-element.visible.pos) or vector{} ]],to = [[
speed]],fromcontext = [[
homing]],},},
    speed = vector{[1] = 0,[2] = 0.0093103148210503,[3] = 0,[4] = 0,},
  }
element 'This is grabbable'
  :add_property 'visible' {
    parts = {[1] = rectangle{color = {[1] = 150,[2] = 150,[3] = 255,[4] = 100,},mode = [[
fill]],height = 64,width = 64,},[2] = rectangle{color = {[1] = 150,[2] = 150,[3] = 150,[4] = 255,},mode = [[
line]],height = 64,width = 64,},[3] = text{color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},width = 64,height = 28,formattedtext = [[
This is grabbable]],},},
    pos = point{[1] = 400,[2] = 300,},
  }
  :add_property 'grabbable' {
    useless = {x = 1,},
  }
element 'Fireball#2'
  :add_property 'visible' {
    size = vector{[1] = 0.256,[2] = 0.256,},
    parts = {[1] = circle{color = {[1] = 255,[2] = 0,[3] = 0,[4] = 255,},},},
    pos = vector{[1] = 1340.611,[2] = -203.419,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    speed = vector{[1] = 283,[2] = -307,[3] = 0,[4] = 0,},
  }
element 'Pointer'
  :add_property 'visible' {
    pos = vector{[1] = 384.0685594152,[2] = 457.06151152002,[3] = 0,[4] = 1,},
    parts = {[1] = rectangle{color = {[1] = 150,[2] = 150,[3] = 255,[4] = 100,},mode = [[
fill]],height = 64,width = 64,},[2] = rectangle{color = {[1] = 150,[2] = 150,[3] = 150,[4] = 255,},mode = [[
line]],height = 64,width = 64,},[3] = text{color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},width = 64,height = 14,formattedtext = [[
Pointer]],},},
  }
  :add_property 'moveable' {
    1 = {action = [[
LuaQ  5   property.speed = (get"position"-element.visible.pos)           
      E�  ��  \� �  �@A��AM�� 	@�� �    	   property    speed    get 	   position    element    visible    pos     
                                         
    ]],specs = {with = [[
get"position"-element.visible.pos]],to = [[
speed]],fromcontext = [[
mouse]],},},
    speed = vector{[1] = 70.931440584805,[2] = 30.938488479977,[3] = 0,[4] = 0,},
  }
element 'Rectangle'
  :add_property 'visible' {
    parts = {[1] = rectangle{height = 32,color = {[1] = 200,[2] = 50,[3] = 0,[4] = 100,},width = 256,},},
    pos = point{[1] = 200,[2] = 200,},
  }
element 'Fireball#1'
  :add_property 'visible' {
    size = vector{[1] = 0.256,[2] = 0.256,},
    parts = {[1] = circle{color = {[1] = 255,[2] = 0,[3] = 0,[4] = 255,},},},
    pos = vector{[1] = -824.889,[2] = -479.772,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    speed = vector{[1] = -417,[2] = -316,[3] = 0,[4] = 0,},
  }
element 'Image'
  :add_property 'visible' {
    1 = {action = [[
LuaQ     share('homing', 'pos', (pos))                 A@  ��  ŀ  @  �       share    homing    pos                                  
    ]],specs = {value = [[
pos]],incontext = [[
homing]],as = [[
pos]],},},
    size = vector{[1] = 0.256,[2] = 0.256,},
    parts = {[1] = image{color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},data = Image,},},
    pos = vector{[1] = 600,[2] = 600,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    1 = {action = [[
LuaQ  N   property.speed = ( get"lshift"*100*(get"up"+get"down"+get"left"+get"right") )                 E�  ��  \� N � ��  �@ �� ŀ  � ܀ �� ŀ  � ܀ �� ŀ   ܀ �� N�� 	@�� � 	   	   property    speed    get    lshift       Y@   up    down    left    right                                                                                     
    ]],specs = {with = [[
 get"lshift"*100*(get"up"+get"down"+get"left"+get"right") ]],to = [[
speed]],fromcontext = [[
player]],},},
    speed = vector{[1] = 0,[2] = 0,[3] = 0,[4] = 0,},
  }
  :add_property 'useskeyboard' {
    keys = {up = {down = vector{[1] = 0,[2] = -1,},up = vector{},},lshift = {down = 3,up = 1,},right = {down = vector{[1] = 1,[2] = 0,},up = vector{},},down = {down = vector{[1] = 0,[2] = 1,},up = vector{},},left = {down = vector{[1] = -1,[2] = 0,},up = vector{},},},
    sharein = [[
player]],
  }
element 'Fireball#3'
  :add_property 'visible' {
    size = vector{[1] = 0.256,[2] = 0.256,},
    parts = {[1] = circle{color = {[1] = 255,[2] = 0,[3] = 0,[4] = 255,},},},
    pos = vector{[1] = 354.08,[2] = 537.248,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    speed = vector{[1] = -290,[2] = -74,[3] = 0,[4] = 0,},
  }
element 'YEAY'
  :add_property 'visible' {
    parts = {[1] = rectangle{color = {[1] = 150,[2] = 150,[3] = 255,[4] = 100,},mode = [[
fill]],height = 64,width = 64,},[2] = rectangle{color = {[1] = 150,[2] = 150,[3] = 150,[4] = 255,},mode = [[
line]],height = 64,width = 64,},[3] = text{color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},width = 64,height = 14,formattedtext = [[
YEAY]],},},
    size = vector{[1] = 2,[2] = 2,},
    pos = vector{[1] = 1141.3,[2] = 1141.3,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    speed = vector{[1] = 100,[2] = 100,[3] = 0,[4] = 0,},
  }
element 'Follower'
  :add_property 'visible' {
    1 = {action = [[
LuaQ  '   property.pos = (point {get"x",get"y"})                 E�  � � ��   ܀ �  AA  �@  \� 	@�� �    	   property    pos    point    get    x    y                                                       
    ]],specs = {with = [[
point {get"x",get"y"}]],to = [[
pos]],fromcontext = [[
mouse]],},},
    pos = point{[1] = 455,[2] = 488,},
    parts = {[1] = rectangle{color = {[1] = 150,[2] = 150,[3] = 255,[4] = 100,},mode = [[
fill]],height = 64,width = 64,},[2] = rectangle{color = {[1] = 150,[2] = 150,[3] = 150,[4] = 255,},mode = [[
line]],height = 64,width = 64,},[3] = text{color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},width = 64,height = 14,formattedtext = [[
Follower]],},},
  }
element 'FireShooter'
  :add_property 'checktriggers' {
  }
  :add_property 'alwaystrigger' {
