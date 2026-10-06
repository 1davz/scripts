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

while task.wait(0.25) do
	muscleEvent:FireServer("rep")
	-- One Hit Invicibility
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	if Humanoid.Health <= Humanoid.MaxHealth and Humanoid.Health >= 1 then
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10000, 0)
	end
end