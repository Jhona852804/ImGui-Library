# RobloxImGui Library

📌 **Aviso:** Esta biblioteca é para **conteúdo educacional** e demonstração de interfaces no Roblox.

Uma biblioteca Lua para criar GUIs avançadas no Roblox com múltiplas janelas, abas, sliders, checkboxes, dropdowns, botões e suporte a hotkeys.

---

## 🔗 Como Usar

**Carregue a biblioteca no seu script:**

```lua
local ImGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jhona852804/ImGui-Library/refs/heads/main/ImGui%20Library.lua"))()
```

**Crie uma instância do GUI:**
```lua
local gui = ImGui.new()

🖥 Criando Janelas
Janela Básica
local window = gui:CreateWindow("Minha Janela", {
    size = Vector2.new(400, 500),
    position = Vector2.new(100, 100),
    resizable = true,
    closeable = true
})
```

## Elementos Disponíveis

**Elemento	Sintaxe	Descrição**

`Label	window:AddLabel("Texto")`	Adiciona texto estático.

`Separator	window:AddSeparator()`	Linha separadora.

`Slider	window:AddSlider("Nome", min, max, valor_inicial, callback)`	Slider que retorna valor em tempo real.

`Checkbox	window:AddCheckbox("Nome", valor_inicial, callback)`	Caixa de seleção.

`TextBox	window:AddTextBox("Nome", "Placeholder", callback)`	Campo de texto editável.

`Dropdown	window:AddDropdown("Nome", {"Opção1","Opção2"}, opção_inicial, callback)`	Menu suspenso com opções.

`Button	window:AddButton("Nome", callback)`	Botão de ação.

`Tab	window:AddTab("Nome")`	Cria abas dentro da janela.


---
🗂 Abas (Tabs)
```lua
local playerTab = window:AddTab("Jogador")
playerTab:AddSlider("Velocidade", 0, 100, 16, function(value)
    print("Velocidade:", value)
end)
playerTab:AddCheckbox("Modo Deus", false, function(checked)
    print("Modo Deus:", checked)
end)
```
🎨 Temas

Defina temas pré-existentes:
```lua
gui:SetTheme("Dark")  -- Tema Escuro
gui:SetTheme("Light") -- Tema Claro
```

Crie um tema customizado:
```lua
local customTheme = {
    WindowBg = Color3.fromRGB(30,0,50),
    TitleBg = Color3.fromRGB(50,0,80),
    ButtonBg = Color3.fromRGB(60,20,90),
    Text = Color3.fromRGB(255,255,255)
}
gui:SetTheme(customTheme)
```
⌨ Hotkeys

Registre teclas de atalho:
```lua
gui:RegisterHotkey(Enum.KeyCode.F1, function()
    window:Toggle() -- Abrir/Fechar janela
end)

gui:UnregisterHotkey(Enum.KeyCode.F1) -- Remover hotkey
```
**📌 Exemplos Prontos**

-- Janela básica

`Example1_BasicWindow()`

-- Janela com abas

`Example2_WindowWithTabs()`


-- Múltiplas janelas e temas

`Example3_MultipleWindowsAndThemes()`


-- Drag & Drop

`Example4_DragAndDrop()`


-- Hotkeys

`Example5_HotkeysDemo()`


-- Executar todos de uma vez

`RunAllExamples()`

---

##⚡ Dicas de Uso

Combine janelas, abas e elementos para criar painéis complexos.

Use sliders e checkboxes para modificar propriedades do jogador em tempo real.

Registre hotkeys para ações rápidas.

Temas personalizados permitem criar uma interface com identidade visual própria.

Separe janelas por funcionalidade: jogador, aparência, ferramentas e informações.

---

## **Criado por JhonaDev139**
