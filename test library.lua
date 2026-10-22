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