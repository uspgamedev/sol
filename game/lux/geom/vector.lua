--[[
--
-- Copyright (c) 2013 Wilson Kazuo Mizutani
--
-- This software is provided 'as-is', without any express or implied
-- warranty. In no event will the authors be held liable for any damages
-- arising from the use of this software.
--
-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it
-- freely, subject to the following restrictions:
--
--    1. The origin of this software must not be misrepresented; you must not
--       claim that you wrote the original software. If you use this software
--       in a product, an acknowledgment in the product documentation would be
--       appreciated but is not required.
--
--    2. Altered source versions must be plainly marked as such, and must not be
--       misrepresented as being the original software.
--
--    3. This notice may not be removed or altered from any source
--       distribution.
--
--]]

module ('lux.geom', package.seeall)

require 'lux.object'

vector = lux.object.new {
  -- Vector coordinates.
  0,
  0,
  0,
  0,
  -- Internal information.
  __type = "vector"
}

point = vector:new {
  [4] = 1,
  __type = "point"
}

function vector.axis (i)
  return vector:new {
    i == 1 and 1 or 0,
    i == 2 and 1 or 0,
    i == 3 and 1 or 0,
    i == 4 and 1 or 0
  }
end

function vector:__tostring ()
  return "("..self[1]..","..self[2]..","..self[3]..","..self[4]..")"
end

point.__tostring = vector.__tostring

function vector:__index (k)
  if k == "x" then return self[1] end
  if k == "y" then return self[2] end
  if k == "z" then return self[3] end
  if k == "w" then return self[4] end
  return getmetatable(self)[k]
end

point.__index = vector.__index

function vector:__newindex (k, v)
  if k == "x" then rawset(self, 1, v)
  elseif k == "y" then rawset(self, 2, v)
  elseif k == "z" then rawset(self, 3, v)
  elseif k == "w" then rawset(self, 4, v)
  else rawset(self, k, v) end
end

point.__newindex = vector.__newindex

function vector.__add (lhs, rhs)
  return vector:new {
    lhs[1] + rhs[1],
    lhs[2] + rhs[2],
    lhs[3] + rhs[3],
    lhs[4] + rhs[4]
  }
end

function vector.__sub (lhs, rhs)
  return vector:new {
    lhs[1] - rhs[1],
    lhs[2] - rhs[2],
    lhs[3] - rhs[3],
    lhs[4] - rhs[4]
  }
end

point.__sub = vector.__sub

local function mul_scalar (a, v)
  return vector:new {
    a*v[1],
    a*v[2],
    a*v[3],
    a*v[4]
  }
end

function vector.__mul (lhs, rhs)
  if type(lhs) == "number" then
    return mul_scalar(lhs,rhs)
  elseif type(rhs) == "number" then
    return mul_scalar(rhs, lhs)
  else -- assume both are vector
    return lhs[1]*rhs[1] + lhs[2]*rhs[2] + lhs[3]*rhs[3] + lhs[4]*rhs[4]
  end
end

function vector:set (x, y, z, w)
  self[1] = x or 0
  self[2] = y or 0
  self[3] = z or 0
  self[4] = w or 0
end

function vector:add (v)
  self[1] = self[1] + v[1]
  self[2] = self[2] + v[2]
  self[3] = self[3] + v[3]
  self[4] = self[4] + v[4]
end

function vector:sub (v)
  self[1] = self[1] - v[1]
  self[2] = self[2] - v[2]
  self[3] = self[3] - v[3]
  self[4] = self[4] - v[4]
end

function vector:unpack ()
  return self[1], self[2], self[3], self[4]
end

