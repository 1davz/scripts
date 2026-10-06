local LocalPlayer = game.Players.LocalPlayer
local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
local weight = LocalPlayer.Backpack.Weight
LocalPlayer.CharacterAdded:Connect(function(Character)
	Humanoid = Character:WaitForChild("Humanoid")
end)
local muscleEvent = LocalPlayer.muscleEvent

-- Auto Rebirth
local function autoRebirth()
	while true do
		task.wait(0.5)
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("RebirthMenu") then
			local rebirthButton = LocalPlayer.Character.RebirthMenu:WaitForChild("RebirthButton")
			
			-- Verifica a força necessária
			local requiredMuscle = rebirthButton:GetAttribute("RequiredMuscle")
			if requiredMuscle and Humanoid.Muscle >= requiredMuscle then
				rebirthButton:Click()
				task.wait(2)
			end
		end
		task.wait(0.5)
	end
end

-- Auto Reconnect
local function autoReconnect()
	while true do
		task.wait(5)
		if LocalPlayer.Character == nil or LocalPlayer.Character:FindFirstChild("Humanoid") == nil then
			pcall(function()
				game:GetService("Players").LocalPlayer:Kick()
				wait(2)
				game.ReplicatedStorage.DefaultClientStateService:LoadDefaultClientState()
				wait(3)
				game:GetService("Players").LocalPlayer:Kick()
				game:GetService("Players").LocalPlayer:Kick()
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

-- Auto Rebirth
task.spawn(function()
	autoRebirth()
end)

-- Auto Reconnect
task.spawn(function()
	autoReconnect()
end)

-- Auto Equip Slot 1
task.spawn(function()
	autoEquipSlot1()
end)

while task.wait() do
	muscleEvent:FireServer("rep")
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	if Humanoid.Health <= Humanoid.MaxHealth and Humanoid.Health >= 1 then
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10000, 0)
	end
end
