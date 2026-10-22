-- Script para testar a SimpleGuiLib

if not game:IsLoaded() then -- apenas espera quando o jogo ainda não tiver carregado
    game.Loaded:Wait()
end

-- ========================================================================
-- 1. CARREGAMENTO DA BIBLIOTECA SimpleGUI
-- ========================================================================

local LIBRARY_URL = "https://raw.githubusercontent.com/1davz/scripts/refs/heads/main/SimpleGUI-library.lua"

local SimpleGuiLib = (function()
    -- 1. Carregamento prioritário via HttpGet (GitHub)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(LIBRARY_URL))()
    end)
    if ok and result then
        return result
    end
	
	error("[SimpleGUI] Não foi possível carregar a biblioteca do link. " .. tostring(result or "Erro desconhecido"))
end)()

-- ========================================================================
-- 2. CONFIGURAÇÕES E ESTADOS
-- ========================================================================

local Settings = {
	Teste = false,
	SliderDelay = 0.5,
}

-- ========================================================================
-- 3. FUNÇÕES DAS AÇÕES DENTRO DO JOGO
-- ========================================================================

local function TesteToggle()
	print("Toggle funcionando")
	task.wait(1)
end

local function TesteButton()
	print("Botão funcionando")
end

-- ========================================================================
-- 5. CRIAÇÃO DA INTERFACE COM SimpleGUI
-- ========================================================================

-- Configuração do botão de Minimizar / Maximizar
local toggleMinimizeFunc
local function setupMinimize()
    local parentGui
    pcall(function()
        if typeof(gethui) == "function" then
            parentGui = gethui()
        elseif game:GetService("CoreGui") then
            parentGui = game:GetService("CoreGui")
        end
    end)
    if not parentGui then
        parentGui = player and player:FindFirstChild("PlayerGui")
    end

    local sg = (SimpleGuiLib and SimpleGuiLib.ScreenGui) or (parentGui and parentGui:FindFirstChild("SimpleGuiLib"))
    if not sg then return end

    local mainFrame = (SimpleGuiLib and SimpleGuiLib.Main) or sg:FindFirstChildOfClass("Frame")
    if not mainFrame then return end

    local header = (SimpleGuiLib and SimpleGuiLib.Header) or mainFrame:FindFirstChildOfClass("TextLabel")
    if not header then return end

    -- Conexão existente da biblioteca
    if SimpleGuiLib and SimpleGuiLib.ToggleMinimize then
        toggleMinimizeFunc = function() SimpleGuiLib:ToggleMinimize() end
    end

SimpleGuiLib:SetTitle("Teste do Título - Ok")


local testPage = SimpleGuiLib:Page("Pag 1 - Ok")

SimpleGuiLib:Toggle(testPage, "Toggle - Ok", Settings.Teste, function(state)
    TesteToggle(state)
end)


SimpleGuiLib:Button(testPage, "Botão - Ok", function()
    TesteButton()
end)

SimpleGuiLib:Slider(configPage, "Slider - Ok", 0.1, 1.0, Settings.SliderDelay, function(val)
    Settings.SliderDelay = math.max(0.01, tonumber(val) or 0.1)
end)
