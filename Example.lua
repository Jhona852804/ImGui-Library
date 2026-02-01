local ImGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jhona852804/ImGui-Library/refs/heads/main/ImGui%20Library.lua"))()

--[[
    RobloxImGui - Exemplos de Uso
    
    Este arquivo demonstra como usar a biblioteca ImGui
    em diferentes cenários e configurações.
--]]


-- ============================================================
-- EXEMPLO 1: Janela Básica com Elementos Diversos
-- ============================================================

local function Example1_BasicWindow()
    print("Exemplo 1: Criando janela básica com elementos diversos")
    
    -- Criar instância do ImGui
    local gui = ImGui.new()
    
    -- Criar janela redimensionável
    local window = gui:CreateWindow("Exemplo Básico", {
        size = Vector2.new(400, 500),
        position = Vector2.new(100, 100),
        resizable = true,
        closeable = true
    })
    
    -- Adicionar título
    window:AddLabel("Bem-vindo ao RobloxImGui!")
    window:AddSeparator()
    
    -- Variável compartilhada para demonstrar atualização em tempo real
    local playerSpeed = 16
    local gravityEnabled = true
    local playerName = ""
    
    -- Adicionar slider de velocidade
    local speedSlider = window:AddSlider("Velocidade do Jogador", 0, 100, playerSpeed, function(value)
        playerSpeed = value
        print("Nova velocidade:", playerSpeed)
        
        -- Aplicar ao personagem (exemplo)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = playerSpeed
        end
    end)
    
    -- Adicionar checkbox de gravidade
    local gravityCheck = window:AddCheckbox("Gravidade Habilitada", gravityEnabled, function(checked)
        gravityEnabled = checked
        print("Gravidade:", gravityEnabled)
        
        -- Aplicar gravidade (exemplo)
        workspace.Gravity = gravityEnabled and 196.2 or 0
    end)
    
    -- Adicionar campo de texto
    local nameBox = window:AddTextBox("Nome do Jogador", "Digite seu nome...", function(text)
        playerName = text
        print("Nome alterado para:", playerName)
    end)
    
    -- Adicionar dropdown de dificuldade
    local difficultyDropdown = window:AddDropdown("Dificuldade", {"Fácil", "Médio", "Difícil", "Extremo"}, 2, function(index, value)
        print("Dificuldade selecionada:", value)
    end)
    
    window:AddSeparator()
    
    -- Adicionar botões de ação
    local teleportButton = window:AddButton("Teleportar para Spawn", function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
            print("Teleportado!")
        end
    end)
    
    local resetButton = window:AddButton("Resetar Configurações", function()
        speedSlider:SetValue(16)
        gravityCheck:SetChecked(true)
        nameBox:SetText("")
        difficultyDropdown:Select(1)
        print("Configurações resetadas!")
    end)
    
    return gui, window
end

-- ============================================================
-- EXEMPLO 2: Janela com Múltiplas Abas
-- ============================================================

local function Example2_WindowWithTabs()
    print("Exemplo 2: Criando janela com múltiplas abas")
    
    local gui = ImGui.new()
    
    local window = gui:CreateWindow("Painel de Controle", {
        size = Vector2.new(450, 550),
        position = Vector2.new(200, 150)
    })
    
    -- === ABA 1: Configurações do Jogador ===
    local playerTab = window:AddTab("Jogador")
    
    playerTab:AddLabel("Configure seu personagem")
    playerTab:AddSeparator()
    
    playerTab:AddSlider("Velocidade", 0, 100, 16, function(value)
        print("Velocidade:", value)
    end)
    
    playerTab:AddSlider("Altura do Pulo", 0, 100, 50, function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end)
    
    playerTab:AddCheckbox("Modo Deus", false, function(checked)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.MaxHealth = checked and math.huge or 100
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
        end
    end)
    
    playerTab:AddCheckbox("Voar", false, function(checked)
        print("Modo Voar:", checked)
        -- Implementar lógica de voo aqui
    end)
    
    -- === ABA 2: Aparência ===
    local appearanceTab = window:AddTab("Aparência")
    
    appearanceTab:AddLabel("Personalize a aparência")
    appearanceTab:AddSeparator()
    
    appearanceTab:AddDropdown("Tamanho da Cabeça", {"Pequena", "Normal", "Grande", "Gigante"}, 2, function(index, value)
        print("Tamanho da cabeça:", value)
    end)
    
    appearanceTab:AddDropdown("Cor do Corpo", {"Vermelho", "Verde", "Azul", "Amarelo", "Roxo"}, 1, function(index, value)
        print("Cor do corpo:", value)
    end)
    
    appearanceTab:AddButton("Aplicar Mudanças", function()
        print("Mudanças de aparência aplicadas!")
    end)
    
    -- === ABA 3: Ferramentas ===
    local toolsTab = window:AddTab("Ferramentas")
    
    toolsTab:AddLabel("Ferramentas úteis")
    toolsTab:AddSeparator()
    
    toolsTab:AddButton("Remover Névoa", function()
        game.Lighting.FogEnd = 100000
        print("Névoa removida!")
    end)
    
    toolsTab:AddButton("Dia Permanente", function()
        game.Lighting.TimeOfDay = "12:00:00"
        game.Lighting.ClockTime = 12
        print("Dia permanente ativado!")
    end)
    
    toolsTab:AddButton("Noite Permanente", function()
        game.Lighting.TimeOfDay = "00:00:00"
        game.Lighting.ClockTime = 0
        print("Noite permanente ativada!")
    end)
    
    toolsTab:AddSeparator()
    
    toolsTab:AddSlider("Brilho", 0, 5, 1, function(value)
        game.Lighting.Brightness = value
    end)
    
    toolsTab:AddSlider("Exposição", -2, 2, 0, function(value)
        game.Lighting.ExposureCompensation = value
    end)
    
    -- === ABA 4: Informações ===
    local infoTab = window:AddTab("Info")
    
    infoTab:AddLabel("Informações do Sistema")
    infoTab:AddSeparator()
    infoTab:AddLabel("Versão: " .. ImGui.Version)
    infoTab:AddLabel("Criado por: RobloxImGui Team")
    infoTab:AddSeparator()
    infoTab:AddLabel("Teclas de Atalho:")
    infoTab:AddLabel("• F1 - Abrir/Fechar Menu")
    infoTab:AddLabel("• F2 - Tema Escuro")
    infoTab:AddLabel("• F3 - Tema Claro")
    
    return gui, window
end

-- ============================================================
-- EXEMPLO 3: Múltiplas Janelas e Temas Personalizados
-- ============================================================

local function Example3_MultipleWindowsAndThemes()
    print("Exemplo 3: Múltiplas janelas com temas personalizados")
    
    local gui = ImGui.new()
    
    -- Janela 1: Status do Jogador
    local statusWindow = gui:CreateWindow("Status", {
        size = Vector2.new(250, 200),
        position = Vector2.new(50, 50)
    })
    
    statusWindow:AddLabel("📊 Estatísticas do Jogador")
    statusWindow:AddSeparator()
    
    local healthLabel = statusWindow:AddLabel("❤️ Vida: 100/100")
    local staminaLabel = statusWindow:AddLabel("⚡ Stamina: 100/100")
    local coinsLabel = statusWindow:AddLabel("💰 Moedas: 0")
    
    -- Atualizar stats em tempo real
    game:GetService("RunService").Heartbeat:Connect(function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            healthLabel:SetText(string.format("❤️ Vida: %.0f/%.0f", humanoid.Health, humanoid.MaxHealth))
        end
    end)
    
    -- Janela 2: Controles Rápidos
    local controlsWindow = gui:CreateWindow("Controles", {
        size = Vector2.new(300, 300),
        position = Vector2.new(320, 50)
    })
    
    controlsWindow:AddLabel("⚙️ Controles Rápidos")
    controlsWindow:AddSeparator()
    
    controlsWindow:AddButton("🔄 Reset Personagem", function()
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character:BreakJoints()
        end
    end)
    
    controlsWindow:AddButton("📸 Screenshot", function()
        print("Screenshot tirada! (funcionalidade de exemplo)")
    end)
    
    controlsWindow:AddButton("🔊 Mutar Sons", function()
        game:GetService("SoundService").Volume = 0
        print("Sons mutados!")
    end)
    
    controlsWindow:AddSeparator()
    
    controlsWindow:AddCheckbox("Anti-AFK", false, function(checked)
        print("Anti-AFK:", checked)
    end)
    
    controlsWindow:AddCheckbox("Auto-Farm", false, function(checked)
        print("Auto-Farm:", checked)
    end)
    
    -- Janela 3: Seletor de Temas
    local themeWindow = gui:CreateWindow("Temas", {
        size = Vector2.new(280, 180),
        position = Vector2.new(640, 50)
    })
    
    themeWindow:AddLabel("🎨 Selecionar Tema")
    themeWindow:AddSeparator()
    
    themeWindow:AddButton("Tema Escuro", function()
        gui:SetTheme("Dark")
        print("Tema escuro aplicado!")
    end)
    
    themeWindow:AddButton("Tema Claro", function()
        gui:SetTheme("Light")
        print("Tema claro aplicado!")
    end)
    
    themeWindow:AddButton("Tema Personalizado", function()
        -- Criar tema customizado
        local customTheme = {
            WindowBg = Color3.fromRGB(30, 0, 50),
            WindowBorder = Color3.fromRGB(100, 50, 150),
            TitleBg = Color3.fromRGB(50, 0, 80),
            TitleBgActive = Color3.fromRGB(70, 0, 100),
            TitleText = Color3.fromRGB(255, 200, 255),
            ButtonBg = Color3.fromRGB(60, 20, 90),
            ButtonHover = Color3.fromRGB(80, 40, 110),
            ButtonActive = Color3.fromRGB(100, 60, 130),
            Text = Color3.fromRGB(255, 255, 255),
            TextDisabled = Color3.fromRGB(150, 150, 150),
            Border = Color3.fromRGB(120, 60, 180),
            FrameBg = Color3.fromRGB(40, 10, 60),
            FrameBgHovered = Color3.fromRGB(50, 20, 70),
            FrameBgActive = Color3.fromRGB(60, 30, 80),
            TabBg = Color3.fromRGB(35, 5, 55),
            TabActive = Color3.fromRGB(60, 20, 90),
            TabHover = Color3.fromRGB(50, 15, 75),
            CheckMark = Color3.fromRGB(150, 100, 200),
            SliderGrab = Color3.fromRGB(120, 80, 180),
            SliderGrabActive = Color3.fromRGB(140, 100, 200)
        }
        
        gui:SetTheme(customTheme)
        print("Tema roxo personalizado aplicado!")
    end)
    
    return gui, {statusWindow, controlsWindow, themeWindow}
end

-- ============================================================
-- EXEMPLO 4: Drag and Drop (Demonstração)
-- ============================================================

local function Example4_DragAndDrop()
    print("Exemplo 4: Sistema de Drag and Drop")
    
    local gui = ImGui.new()
    
    local window = gui:CreateWindow("Inventário", {
        size = Vector2.new(500, 400),
        position = Vector2.new(250, 200)
    })
    
    window:AddLabel("📦 Sistema de Inventário com Drag & Drop")
    window:AddSeparator()
    
    -- Criar slots de inventário
    local inventoryTab = window:AddTab("Inventário")
    
    inventoryTab:AddLabel("Arraste itens entre os slots:")
    inventoryTab:AddSeparator()
    
    local items = {"⚔️ Espada", "🛡️ Escudo", "🏹 Arco", "💊 Poção", "🔑 Chave"}
    
    for i, item in ipairs(items) do
        inventoryTab:AddButton("Slot " .. i .. ": " .. item, function()
            print("Clicou no item:", item)
        end)
    end
    
    inventoryTab:AddSeparator()
    inventoryTab:AddLabel("💡 Dica: Clique e arraste para mover itens")
    
    -- Aba de equipamento
    local equipTab = window:AddTab("Equipamento")
    
    equipTab:AddLabel("Equipamento Atual:")
    equipTab:AddSeparator()
    equipTab:AddButton("Arma: Nenhuma", function() end)
    equipTab:AddButton("Armadura: Nenhuma", function() end)
    equipTab:AddButton("Acessório: Nenhum", function() end)
    
    return gui, window
end

-- ============================================================
-- EXEMPLO 5: Hotkeys e Atalhos
-- ============================================================

local function Example5_HotkeysDemo()
    print("Exemplo 5: Sistema de Hotkeys")
    
    local gui = ImGui.new()
    
    local window = gui:CreateWindow("Hotkeys Demo", {
        size = Vector2.new(350, 400),
        position = Vector2.new(300, 250)
    })
    
    window:AddLabel("⌨️ Demonstração de Hotkeys")
    window:AddSeparator()
    window:AddLabel("Teclas configuradas:")
    window:AddSeparator()
    
    -- Registrar hotkeys
    gui:RegisterHotkey(Enum.KeyCode.F1, function()
        window:Toggle()
        print("F1 pressionado - Toggle menu")
    end)
    
    gui:RegisterHotkey(Enum.KeyCode.F2, function()
        gui:SetTheme("Dark")
        print("F2 pressionado - Tema escuro")
    end)
    
    gui:RegisterHotkey(Enum.KeyCode.F3, function()
        gui:SetTheme("Light")
        print("F3 pressionado - Tema claro")
    end)
    
    gui:RegisterHotkey(Enum.KeyCode.F5, function()
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character:BreakJoints()
        end
        print("F5 pressionado - Reset")
    end)
    
    window:AddLabel("• F1 - Abrir/Fechar Menu")
    window:AddLabel("• F2 - Tema Escuro")
    window:AddLabel("• F3 - Tema Claro")
    window:AddLabel("• F5 - Reset Personagem")
    
    window:AddSeparator()
    
    window:AddButton("Adicionar Hotkey F9", function()
        gui:RegisterHotkey(Enum.KeyCode.F9, function()
            print("F9 pressionado - Nova hotkey!")
        end)
        print("Hotkey F9 adicionada!")
    end)
    
    window:AddButton("Remover Hotkey F9", function()
        gui:UnregisterHotkey(Enum.KeyCode.F9)
        print("Hotkey F9 removida!")
    end)
    
    window:AddSeparator()
    window:AddLabel("💡 Pressione as teclas para testar!")
    
    return gui, window
end

-- ============================================================
-- EXECUTAR EXEMPLOS
-- ============================================================

-- Descomentar o exemplo que deseja testar:

-- Example1_BasicWindow()
-- Example2_WindowWithTabs()
-- Example3_MultipleWindowsAndThemes()
-- Example4_DragAndDrop()
-- Example5_HotkeysDemo()

-- Ou executar todos de uma vez:
local function RunAllExamples()
    print("==========================================")
    print("Executando todos os exemplos do ImGui")
    print("==========================================")
    
    wait(1)
    Example1_BasicWindow()
    
    wait(0.5)
    Example2_WindowWithTabs()
    
    wait(0.5)
    Example3_MultipleWindowsAndThemes()
    
    wait(0.5)
    Example4_DragAndDrop()
    
    wait(0.5)
    Example5_HotkeysDemo()
    
    print("==========================================")
    print("Todos os exemplos foram criados!")
    print("Use as hotkeys F1-F5 para interagir")
    print("==========================================")
end

RunAllExamples()
