
module ('base', package.seeall)

require 'lux.object'

drawable = lux.object.new {}

drawable.__init = {
  color = {255, 255, 255, 255}
}
