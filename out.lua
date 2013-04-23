element 'Hipster'
  :add_property 'visible' {
    parts = {[1] = circle{color = {[1] = 50,[2] = 50,[3] = 200,[4] = 200,},radius = 32,},[2] = text{width = 64,height = 28,text = [[
$moveable[1].specs.fromcontext$
$name$]],color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},formattedtext = [[
homing
Hipster]],},},
    pos = vector{[1] = 600,[2] = 599.99718076324,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    1 = {action = [[
LuaQ  M       property.speed = ( get"pos" and (get"pos"-element.visible.pos) or vector{} )                 E�  ��  \� Z    �E�  ��  \� �  �@A��@M�� Z@  � �E� �   \� 	@�� �    	       property        speed        get        pos        element        visible        vector                                                                            
    ]],specs = {with = [[
 get"pos" and (get"pos"-element.visible.pos) or vector{} ]],to = [[
speed]],fromcontext = [[
homing]],},},
    speed = vector{[1] = 0,[2] = 0.0028192367608426,[3] = 0,[4] = 0,},
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
element 'Stalker'
  :add_property 'visible' {
    pos = vector{[1] = 0,[2] = 0,[3] = 0,[4] = 1,},
    parts = {[1] = rectangle{color = {[1] = 150,[2] = 150,[3] = 255,[4] = 100,},mode = [[
fill]],height = 64,width = 64,},[2] = rectangle{color = {[1] = 150,[2] = 150,[3] = 150,[4] = 255,},mode = [[
line]],height = 64,width = 64,},[3] = text{color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},width = 64,height = 14,formattedtext = [[
Stalker]],},},
  }
  :add_property 'moveable' {
    1 = {action = [[
LuaQ         property.target = (get"pos")                 E�  ��  \� 	@�� �    	       property        target        get        pos                                  
    ]],specs = {with = [[
get"pos"]],to = [[
target]],fromcontext = [[
homing]],},},
    target = vector{[1] = 600,[2] = 600,[3] = 0,[4] = 1,},
    speed = vector{},
  }
element 'Rectangle'
  :add_property 'visible' {
    parts = {[1] = rectangle{height = 32,color = {[1] = 200,[2] = 50,[3] = 0,[4] = 100,},width = 256,},},
    pos = point{[1] = 200,[2] = 200,},
  }
element 'Image'
  :add_property 'visible' {
    1 = {action = [[
LuaQ         share('homing', 'pos', (pos))                 A@  ��  ŀ  @  �           share        homing        pos                                  
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
LuaQ  N       property.speed = ( get"lshift"*100*(get"up"+get"down"+get"left"+get"right") )                 E�  ��  \� N � ��  �@ �� ŀ  � ܀ �� ŀ  � ܀ �� ŀ   ܀ �� N�� 	@�� � 	   	       property        speed        get        lshift       Y@       up        down        left        right                                                                                     
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
element 'Fireball(#0)'
  :add_property 'visible' {
    size = vector{[1] = 0.256,[2] = 0.256,},
    parts = {[1] = circle{color = {[1] = 255,[2] = 0,[3] = 0,[4] = 255,},},},
    pos = vector{[1] = -3220.5671360079,[2] = -1869.1431224732,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    speed = vector{[1] = -419.93483578895,[2] = -271.39405610828,[3] = 0,[4] = 0,},
  }
element 'awesomebutton'
  :add_property 'visible' {
    parts = {[1] = rectangle{height = 100,color = {[1] = 80,[2] = 10,[3] = 10,[4] = 255,},width = 100,},[2] = rectangle{height = 100,mode = [[
line]],color = {[1] = 180,[2] = 10,[3] = 10,[4] = 255,},width = 100,},[3] = text{width = 64,height = 14,text = [[
$name$]],color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},formattedtext = [[
awesomebutton]],},},
    pos = point{[1] = 100,[2] = 100,},
  }
element 'YEAY'
  :add_property 'visible' {
    parts = {[1] = rectangle{color = {[1] = 150,[2] = 150,[3] = 255,[4] = 100,},mode = [[
fill]],height = 64,width = 64,},[2] = rectangle{color = {[1] = 150,[2] = 150,[3] = 150,[4] = 255,},mode = [[
line]],height = 64,width = 64,},[3] = text{color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},width = 64,height = 14,formattedtext = [[
YEAY]],},},
    size = vector{[1] = 2,[2] = 2,},
    pos = vector{[1] = 996.20127661145,[2] = 996.20127661145,[3] = 0,[4] = 1,},
  }
  :add_property 'moveable' {
    speed = vector{[1] = 77.78174593052,[2] = 77.78174593052,[3] = 0,[4] = 0,},
  }
element 'Follower'
  :add_property 'visible' {
    1 = {action = [[
LuaQ  '       property.pos = (point {get"x",get"y"})                 E�  � � ��   ܀ �  AA  �@  \� 	@�� �    	       property        pos        point        get        x        y                                                       
    ]],specs = {with = [[
point {get"x",get"y"}]],to = [[
pos]],fromcontext = [[
mouse]],},},
    pos = point{[1] = 127,[2] = 97,},
    parts = {[1] = rectangle{color = {[1] = 150,[2] = 150,[3] = 255,[4] = 100,},mode = [[
fill]],height = 64,width = 64,},[2] = rectangle{color = {[1] = 150,[2] = 150,[3] = 150,[4] = 255,},mode = [[
line]],height = 64,width = 64,},[3] = text{color = {[1] = 255,[2] = 255,[3] = 255,[4] = 255,},width = 64,height = 14,formattedtext = [[
Follower]],},},
  }
element 'FireShooter'
  :add_property 'checktriggers' {
  }
  :add_property 'alwaystrigger' {
