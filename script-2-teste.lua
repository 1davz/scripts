-- don't mind the messy code it works enough

local LocalPlayer = game.Players.LocalPlayer
local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
local weight = LocalPlayer.Backpack.Weight
LocalPlayer.CharacterAdded:Connect(function(Character)
	Humanoid = Character:WaitForChild("Humanoid")
end)
local muscleEvent = LocalPlayer.muscleEvent

task.spawn(function()
	while task.wait() do
		for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
			if not v.Name:match("Punch") then
				v.Parent = LocalPlayer.Character
				task.wait()
				v.Parent = LocalPlayer.Backpack
			end
		end
	end
end)

while task.wait() do
	task.wait(0.5)
	muscleEvent:FireServer("rep")
	-- One Hit Invicibility
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	if Humanoid.Health <= Humanoid.MaxHealth and Humanoid.Health >= 1 then
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10000, 0)
	end
end

-- Auto Reconnect
local function autoReconnect()
	while true do
		task.wait(5)
		if LocalPlayer.Character == nil or LocalPlayer.Character:FindFirstChild("Humanoid") == nil then
			pcall(function()
				game:GetService("Players").LocalPlayer:Kick()
				wait(5)
				game.ReplicatedStorage.DefaultClientStateService:LoadDefaultClientState()
				wait(5)
				game:GetService("Players").LocalPlayer:Kick()
				autoEquipSlot1()
			end)
		end
	end
end

-- Auto Equip Slot 1
local function autoEquipSlot1()
	while true do
		task.wait(0.5)
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Inventory") and LocalPlayer.Character.Inventory:FindFirstChild("InventoryFrame") then
			local slot1 = LocalPlayer.Character.Inventory.InventoryFrame:WaitForChild("Slot1")
			slot1:Click()
			task.wait(0.2)
		end
	end
end
