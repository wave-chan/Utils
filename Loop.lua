local module = {
	Storage = {}
}

local MainLoopExists = false
function module:Connect(Time, Function, Condition, MainLoop)
	local CreateLoop = {}
	CreateLoop.ID = game:GetService('HttpService'):GenerateGUID(false)
	CreateLoop.Function = Function
	CreateLoop.Time = Time
	CreateLoop.InCooldown = false

	if type(Condition) ~= "function" then
	    Condition = nil
	end

	CreateLoop.Condition = Condition
	CreateLoop.MainLoop = MainLoop

	if MainLoop then MainLoopExists = true end

	function CreateLoop:Disconnect()
		if module.Storage[CreateLoop.ID] then
			CreateLoop.Function = nil
			module.Storage[CreateLoop.ID] = nil
		else
			warn('[Loop Connect] Can\'t Disconnect nil value')
		end
	end

	module.Storage[CreateLoop.ID] = CreateLoop

	return CreateLoop
end

local function DisconnectAll()
	for _, Loop in module.Storage do
		Loop:Disconnect()
	end
end

task.defer(function()
	local DisableLoopxd = false
	while task.wait() and not DisableLoopxd do
		for ID, Connection in module.Storage do
			task.defer(function()
				if Connection.InCooldown then return end
				if not Connection.Function then return end

				if Connection.Condition then
					local ConditionMet = Connection.Condition()
					if not ConditionMet then
						if Connection.MainLoop or not MainLoopExists then
							DisableLoopxd = true
							DisconnectAll()
						end
						return
					end
				end

				if Connection.Time > 0 then
					Connection.InCooldown = true
					task.delay(Connection.Time, function()
						if module.Storage[ID] then
							module.Storage[ID].InCooldown = false
						end
					end)
				end

				Connection.Function()
			end)
		end
	end
end)

return module
