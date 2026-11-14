-- Intentar cargar WindUI de forma segura con el enlace oficial de releases estables
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

if not success or not WindUI then
    local successBackup, backupUI = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/main.lua"))()
    end)
    
    if successBackup and backupUI then
        WindUI = backupUI
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error de WindUI",
            Text = "Tu ejecutor bloqueó la carga o no soporta HttpGet.",
            Duration = 10,
        })
        error("WindUI Loadstring Failed: " .. tostring(WindUI))
    end
end

-- ==========================================
-- VERIFICACIÓN DE JUEGO (SimpleSim)
-- ==========================================
local TARGET_PLACE_ID = 79039639963203

if game.PlaceId ~= TARGET_PLACE_ID then
    WindUI:Notify({
        Title = "Error de Juego",
        Content = "Este script solo funciona en +1 dinero por clic.",
        Duration = 6,
        Icon = "x",
    })
    return
end

-- Crear la ventana principal
local Window = WindUI:CreateWindow({
    Title = "Evolution Script Hub",
    Icon = "door-open",
    Author = "??",
    Folder = "EvolutionHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
})

-- Crear la pestaña principal
local MainTab = Window:Tab({
    Title = "Principal",
    Icon = "home",
})

-- Coordenadas de los mundos
local CFrameMundo1 = CFrame.new(3037.068603515625, 7.941712856292725, -17.50804901123047)
local CFrameMundo2 = CFrame.new(3031.219970703125, 10.54990291595459, -765.6220703125)

-- Funciones auxiliares para obtener el personaje, la raíz y el humanoide
local function getRootPart()
    local player = game:GetService("Players").LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        return player.Character.HumanoidRootPart
    end
    return nil
end

local function getHumanoid()
    local player = game:GetService("Players").LocalPlayer
    if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        return player.Character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

-- 1. Auto Farm + Auto Jump Lento - Mundo 1
local AutoFarm1Toggle = false
MainTab:Toggle({
    Title = "Auto Farm + Auto Jump (Mundo 1)",
    Value = false,
    Callback = function(Value)
        AutoFarm1Toggle = Value
        if AutoFarm1Toggle then
            task.spawn(function()
                while AutoFarm1Toggle do
                    pcall(function()
                        local rootPart = getRootPart()
                        local humanoid = getHumanoid()
                        if rootPart then
                            rootPart.CFrame = CFrameMundo1
                        end
                        if humanoid then
                            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end)
                    task.wait(1.5)
                end
            end)
        end
    end
})

MainTab:Button({
    Title = "Ir a Placa (Mundo 1)",
    Callback = function()
        pcall(function()
            local rootPart = getRootPart()
            if rootPart then rootPart.CFrame = CFrameMundo1 end
        end)
    end
})

-- 2. Auto Farm + Auto Jump Lento - Mundo 2
local AutoFarm2Toggle = false
MainTab:Toggle({
    Title = "Auto Farm + Auto Jump (Mundo 2)",
    Value = false,
    Callback = function(Value)
        AutoFarm2Toggle = Value
        if AutoFarm2Toggle then
            task.spawn(function()
                while AutoFarm2Toggle do
                    pcall(function()
                        local rootPart = getRootPart()
                        local humanoid = getHumanoid()
                        if rootPart then
                            rootPart.CFrame = CFrameMundo2
                        end
                        if humanoid then
                            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end)
                    task.wait(1.5)
                end
            end)
        end
    end
})

MainTab:Button({
    Title = "Ir a Placa (Mundo 2)",
    Callback = function()
        pcall(function()
            local rootPart = getRootPart()
            if rootPart then rootPart.CFrame = CFrameMundo2 end
        end)
    end
})

-- 3. Auto Rebirth
local RebirthToggle = false
MainTab:Toggle({
    Title = "Auto Rebirth",
    Value = false,
    Callback = function(Value)
        RebirthToggle = Value
        if RebirthToggle then
            task.spawn(function()
                while RebirthToggle do
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("RebirthService"):WaitForChild("RE"):WaitForChild("Rebirth"):FireServer()
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

-- 4. Auto Click (20 CPS)
local ClickToggle = false
MainTab:Toggle({
    Title = "Auto Click (20 CPS)",
    Value = false,
    Callback = function(Value)
        ClickToggle = Value
        if ClickToggle then
            task.spawn(function()
                while ClickToggle do
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("ClickService"):WaitForChild("RE"):WaitForChild("Click"):FireServer()
                    end)
                    task.wait(0.05)
                end
            end)
        end
    end
})

-- Notificación de carga
WindUI:Notify({
    Title = "Evolution Hub Cargado",
    Duration = 5,
    Icon = "check",
})
