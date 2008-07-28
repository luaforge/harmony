package.path=[[;;./?.lua;./net.luaforge.harmony/source/lua/5.1/?.lua;./net.luaforge.harmony/source/lua/5.1/?/init.lua]]

local h = require'harmony'

local sphere = h.Sphere'Core'

table.foreach(sphere, print)
table.foreach(sphere.environment, print)

print(os.clock())

for i=1, 100 do
sphere:send[[
	teste = 'sim'
	alterteste = 'nao'
]]
end

print(os.clock())

table.foreach(sphere.environment, print)

print'OK'