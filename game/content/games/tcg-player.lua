
local cards = {}

local function add_card (name)
  cards[#cards+1] = { name = name }
end

local function load_cards (cards_file)
  local file = fs.newFile("resource/tcg/"..cards_file)
  file:open 'r'
  for line in file:lines() do
    string.gsub(
      line,
      '(%w+) +(%w[^\n]*)',
      function(_,name) add_card(name) end
    )
  end
  file:close()
end

load_cards 'cards.txt'

element 'A Card'
  :property 'visible' {
    position = point{(.5*screen.size):unpack()},
    parts = {
      text { text = cards[1].name }
    }
  }

