pcall(require, 'luarocks.require')
module("harmony", package.seeall)

local _all_spheres = {}

local _sphere_class = {}

local _sphere_env_watch = {
	__index = function(obj, key)
		return rawget(rawget(obj, 1),key)
	end;
	__newindex = function(obj, key, value)
		
		print('setting', key, value)
		
		if type(value)=='table' then
			value = setmetatable({value}, _sphere_env_watch)
		end
		rawset(rawget(obj, 1), key, value)
	end;
}

function _sphere_class.send(sphere, message)
        if type(message)=='string' then
                message = loadstring(message) -- compila a mensagem
        end
        if type(message)~='function' then
                error'message is not executable'
        end
        setfenv(message, setmetatable({ sphere.environment }, _sphere_env_watch))
        message()
end

function _sphere_class.subscribe(sphere, watchexpr, func)
		if type(func)~='function' then
                error'argument must be a function'
        end
        sphere.subscribers = sphere.subscribers or {}
        sphere.subscribers[watchexpr] = sphere.subscribers[watchexpr] or {}
        table.insert(sphere.subscribers[watchexpr], func)
end


function Sphere(name)
        _all_spheres[name] = {
                environment	=	{};
                send		=	_sphere_class.send;
                subscribe	=	_sphere_class.subscribe;
        }
        
        return _all_spheres[name]
end

