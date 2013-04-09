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
require 'lux.geom.vec'

matrix = lux.object.new {
  __type = "matrix",
  -- Matrix columns.
  [1] = nil,
  [2] = nil,
  [3] = nil,
  [4] = nil
}

function matrix:__init ()
  for i = 1,4 do
    if self[i] then
      self[i] = vec:new(self[i])
    else
      self[i] = vec.axis(i)
    end
  end
end

function matrix:__tostring ()
  return  "("..tostring(self[1]).."\n"..
          " "..tostring(self[2]).."\n"..
          " "..tostring(self[3]).."\n"..
          " "..tostring(self[4])..")"
end

function matrix:transpose ()
  return matrix:new {
    { self[1][1], self[2][1], self[3][1], self[4][1] },
    { self[1][2], self[2][2], self[3][2], self[4][2] },
    { self[1][3], self[2][3], self[3][3], self[4][3] },
    { self[1][4], self[2][4], self[3][4], self[4][4] },
  }
end

local function mul_scalar (a, m)
  return matrix:new {
    a*m[1],
    a*m[2],
    a*m[3],
    a*m[4]
  }
end

function matrix.__mul (lhs, rhs)
  if type(lhs) == "number" then
    return mul_scalar(lhs,rhs)
  elseif type(rhs) == "number" then
    return mul_scalar(rhs, lhs)
  elseif rhs.__type == "vector" then
    return lhs[1]*rhs[1] + lhs[2]*rhs[2] + lhs[3]*rhs[3] + lhs[4]*rhs[4]
  elseif lhs.__type == "vector" then
    return vec:new {lhs*rhs[1], lhs*rhs[2], lhs*rhs[3], lhs*rhs[4]}
  else -- assume both are matrices
    return matrix:new {
      lhs*rhs[1],
      lhs*rhs[2],
      lhs*rhs[3],
      lhs*rhs[4]
    }
  end
end

