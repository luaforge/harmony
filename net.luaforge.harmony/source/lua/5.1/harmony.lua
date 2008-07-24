pcall(require, 'luarocks.require')
_G=_G
module"harmony"

local _spheres = {}

local sphere = {}

function send(sphere, message)
	if type(message)=='string' then
		message = loadstring(message) -- compila a mensagem caso ela seja string
	end
	if type(message)~='function' then
		error'message is not executable'
	end
	setfenv(message, sphere.environment)
	message()	
end

function subscribe(sphere, func)
		
end


function Sphere(name)
	_spheres[name] = {
		environment={};
		send=sphere.send, 
		subscribe=sphere.subscribe
	}
	return _spheres[name]
end

