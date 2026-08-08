--## SERVICES ##--
local Players = game:GetService("Players")

--## SCRIPT ##--
local module = {}

function module:ObserveChilds(Object: Instance, Callback: (Child: Instance) -> ())
	if not Object or not Object:IsA("Instance") then return end
	if not Callback or type(Callback) ~= "function" then return end

	local ObserveCache = {
		Connections = {}
	}

	function ObserveCache:Destroy()
		for _, Connection in self.Connections do
			Connection:Disconnect()
		end

		table.clear(self.Connections)
	end

	ObserveCache.Connections.Added = Object.ChildAdded:Connect(Callback)

	for _, Child in Object:GetChildren() do
		Callback(Child)
	end

	return ObserveCache
end

function module:GetInstanceFromPath(Parent, Path)
	local NewInstance = Parent

	for _, PathName in string.split(Path, ".") do
		if not NewInstance then break end

		NewInstance = NewInstance:FindFirstChild(PathName)
	end

	return NewInstance
end

return module
