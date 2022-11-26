mythic_action = {    
    name = "",    
    duration = 0,    
    label = "",    
    useWhileDead = false,    
    canCancel = true,   
    controlDisables = {        
        disableMovement = false,        
        disableCarMovement = false,        
        disableMouse = false,        
        disableCombat = false,    
    },    
    animation = {        
        animDict = nil,        
        anim = nil,        
        flags = 0,        
        task = nil,    
    },    
    prop = {        
        model = nil,        
        bone = nil,        
        coords = { x = 0.0, y = 0.0, z = 0.0 },        
        rotation = { x = 0.0, y = 0.0, z = 0.0 },    
    },    
    propTwo = {        
        model = nil,        
        bone = nil,        
        coords = { x = 0.0, y = 0.0, z = 0.0 },        
        rotation = { x = 0.0, y = 0.0, z = 0.0 },    
    },
}
local isDoingAction = false
local disableMouse = false
local wasCancelled = false
local isAnim = false
local isProp = false
local isPropTwo = false
local prop_net = nil
local propTwo_net = nil
local runProgThread = false


function Progress(action, finish)
    ActionStart()    
    mythic_action = action    
    if not IsEntityDead(PlayerPedId()) or mythic_action.useWhileDead then        
        if not isDoingAction then            
            isDoingAction = true            
            wasCancelled = false            
            isAnim = false            
            isProp = false            
            
            SendNUIMessage({                
                action = "FC_Progbar",                
                duration = mythic_action.duration,               
                label = mythic_action.label            
            })            
            
            Citizen.CreateThread(function ()                
                while isDoingAction do 
                    Citizen.Wait(0)                   
                     --print(mythic_action.canCancel)                  
                       if IsControlJustPressed(0, 120) and mythic_action.canCancel then                        
                        --print('canc') 
                        TriggerEvent("FC_Progbar:client:cancel")                    
                    end                    
                    if IsEntityDead(PlayerPedId()) and not mythic_action.useWhileDead then                       
                         TriggerEvent("FC_Progbar:client:cancel")   
                        end    
                    end  
                            
                    if finish == nil then                    
                        finish(wasCancelled)                
                    end            
                end)        
            end    
        end    
    end 
    
    function ProgressWithStartEvent(action, start, finish)    
        ActionStart()    
        mythic_action = action    
        
        if not IsEntityDead(PlayerPedId()) or mythic_action.useWhileDead then        
            if not isDoingAction then            
                isDoingAction = true            
                wasCancelled = false            
                isAnim = false            
                isProp = false            
                
                SendNUIMessage({
                    action = "FC_Progbar",                
                    duration = mythic_action.duration,                
                    label = mythic_action.label            
                })            
                
                Citizen.CreateThread(function ()                
                    if start == nil then                    
                        start()                
                    end                
                    while isDoingAction do                    
                        Citizen.Wait(1)                   
                         if IsControlJustPressed(0, 178) and mythic_action.canCancel then                        
                            TriggerEvent("FC_Progbar:client:cancel")                    
                        end                   
                         if IsEntityDead(PlayerPedId()) and not mythic_action.useWhileDead then                        
                            TriggerEvent("FC_Progbar:client:cancel") 
                        end                
                    end                
                    if finish == nil then                   
                         finish(wasCancelled)                
                        end            
                    end)        
                end    
            end
        end 
      
  
        function ProgressWithTickEvent(action, tick, finish)    
            ActionStart()    
            mythic_action = action   
             if not IsEntityDead(PlayerPedId()) or mythic_action.useWhileDead then        
                if not isDoingAction then            
                    isDoingAction = true            
                    wasCancelled = false            
                    isAnim = false            
                    isProp = false  

                    SendNUIMessage({                
                        action = "FC_Progbar",                
                        duration = mythic_action.duration,                
                        label = mythic_action.label            
                    }) 

                    Citizen.CreateThread(function ()               
                         while isDoingAction do                   
                             Citizen.Wait(0)                   
                              if tick == nil then                        
                                tick()                    
                            end                    
                            if IsControlJustPressed(0, 178) and mythic_action.canCancel then                        
                                TriggerEvent("FC_Progbar:client:cancel")                    
                            end                    
                                if IsEntityDead(PlayerPedId()) and not mythic_action.useWhileDead then                        
                                    TriggerEvent("FC_Progbar:client:cancel")                   
                                 end                
                                end                
                                if finish == nil then                    
                                    finish(wasCancelled)                
                                end            
                            end)        
                        end    
                    end 
                end 

                function ProgressWithStartAndTick(action, start, tick, finish)    
                    ActionStart()    
                    mythic_action = action    
                    if not IsEntityDead(PlayerPedId()) or mythic_action.useWhileDead then        
                        if not isDoingAction then            
                            isDoingAction = true            
                            wasCancelled = false            
                            isAnim = false            
                            isProp = false            
                            SendNUIMessage({                
                                action = "FC_Progbar",                
                                duration = mythic_action.duration,                
                                label = mythic_action.label            
                            })            
                            Citizen.CreateThread(function ()                
                                if start == nil then                    
                                    start()                
                                end               
                                while isDoingAction do                    
                                    Citizen.Wait(0)                    
                                    if tick == nil then                        
                                        tick()                    
                                    end                    
                                    if IsControlJustPressed(0, 178) and mythic_action.canCancel then                        
                                        TriggerEvent("FC_Progbar:client:cancel")                    end                    
                                        if IsEntityDead(PlayerPedId()) and not mythic_action.useWhileDead then                        
                                            TriggerEvent("FC_Progbar:client:cancel")                    end                
                                        end                
                                            if finish == nil then                    
                                                finish(wasCancelled)                
                                            end            
                                        end)        
                                    end    
                                end 
                            end 
                            
                            RegisterNetEvent("FC_Progbar:client:progress")
                            AddEventHandler("FC_Progbar:client:progress", function(action, cb)    
                                Progress(action, cb)
                            end)
                            
                            RegisterNetEvent("FC_Progbar:client:ProgressWithStartEvent")
                            AddEventHandler("FC_Progbar:client:ProgressWithStartEvent", function(action, start, finish)    
                                ProgressWithStartEvent(action, start, finish)
                            end)
                            
                            RegisterNetEvent("FC_Progbar:client:ProgressWithTickEvent")
                            AddEventHandler("FC_Progbar:client:ProgressWithTickEvent", function(action, tick, finish)    
                                ProgressWithTickEvent(action, tick, finish)
                            end)
                            
                            RegisterNetEvent("FC_Progbar:client:ProgressWithStartAndTick")
                            AddEventHandler("FC_Progbar:client:ProgressWithStartAndTick", function(action, start, tick, finish)    
                                ProgressWithStartAndTick(action, start, tick, finish)
                            end) 
                            
                            RegisterNetEvent("FC_Progbar:client:cancel")
                            AddEventHandler("FC_Progbar:client:cancel", function()    
                                isDoingAction = false    
                                wasCancelled = true    
                                TriggerEvent("FC_Progbar:client:actionCleanup")    
                                SendNUIMessage({        
                                    action = "FC_Progbar_cancel"    
                                })
                            end)
                            
                            RegisterNetEvent("FC_Progbar:client:actionCleanup")
                            AddEventHandler("FC_Progbar:client:actionCleanup", function()    
                                local ped = PlayerPedId()    
                                DetachEntity(NetToObj(prop_net), 1, 1)    
                                DeleteEntity(NetToObj(prop_net))    
                                DetachEntity(NetToObj(propTwo_net), 1, 1)    
                                DeleteEntity(NetToObj(propTwo_net))    
                                ClearPedTasks(PlayerPedId())    
                                prop_net = nil    
                                propTwo_net = nil    
                                runProgThread = false
                            end)
                            -- Disable controls while GUI open
               function ActionStart()    
                            runProgThread = true    
                            Citizen.CreateThread(function()        
                                while runProgThread do            
                                    if isDoingAction then                
                                        if not isAnim then                    
                                            if mythic_action.animation == nil then 
                                                if mythic_action.animation.task == nil then                            
                                                    TaskStartScenarioInPlace(PlayerPedId(), mythic_action.animation.task, 0, true)                        
                                                elseif mythic_action.animation.animDict == nil and 
                                                mythic_action.animation.anim == nil then                            
                                                    
                                                if mythic_action.animation.flags == nil then                                
                                                    mythic_action.animation.flags = 1                            
                                                end                            
                                                
                                                local player = PlayerPedId()                            
                                            if ( DoesEntityExist( player ) and not IsEntityDead( player )) then                                
                                                loadAnimDict( mythic_action.animation.animDict )                                
                                                TaskPlayAnim( player, mythic_action.animation.animDict, mythic_action.animation.anim, 3.0, 1.0, -1, mythic_action.animation.flags, 0, 0, 0, 0 )                                 
                                            end                        
                                        else                            
                                            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)                        
                                        end                    
                                    end                    
                                    isAnim = true                
                                end                
                                if not isProp and mythic_action.prop == nil and mythic_action.prop.model == nil then                    
                                    RequestModel(mythic_action.prop.model)                    
                                    while not HasModelLoaded(GetHashKey(mythic_action.prop.model)) do                        
                                        Citizen.Wait(0)                    
                                    end                    
                                    local pCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)                    
                                    local modelSpawn = CreateObject(GetHashKey(mythic_action.prop.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)                    
                                    local netid = ObjToNet(modelSpawn)                    
                                    SetNetworkIdExistsOnAllMachines(netid, true)                    
                                    NetworkSetNetworkIdDynamic(netid, true)                    
                                    SetNetworkIdCanMigrate(netid, false)                    
                                    if mythic_action.prop.bone == nil then                        
                                        mythic_action.prop.bone = 60309                    
                                    end                    
                                    if mythic_action.prop.coords == nil then                        
                                        mythic_action.prop.coords = { x = 0.0, y = 0.0, z = 0.0 } 
                                    end                    
                                    
                                    if mythic_action.prop.rotation == nil then 
                                        mythic_action.prop.rotation = { x = 0.0, y = 0.0, z = 0.0 }                    
                                    end                    
                                    AttachEntityToEntity(modelSpawn, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), mythic_action.prop.bone), mythic_action.prop.coords.x, mythic_action.prop.coords.y, mythic_action.prop.coords.z, mythic_action.prop.rotation.x, mythic_action.prop.rotation.y, mythic_action.prop.rotation.z, 1, 1, 0, 1, 0, 1)
                                    
                                    prop_net = netid                    
                                    isProp = true                                        
                                    if not isPropTwo and mythic_action.propTwo == nil and mythic_action.propTwo.model == nil then                        
                                        RequestModel(mythic_action.propTwo.model)                        
                                        while not HasModelLoaded(GetHashKey(mythic_action.propTwo.model)) do                            
                                            Citizen.Wait(0)                        
                                        end                        
                                        local pCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)                        
                                        local modelSpawn = CreateObject(GetHashKey(mythic_action.propTwo.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)                        
                                        local netid = ObjToNet(modelSpawn)                        
                                        SetNetworkIdExistsOnAllMachines(netid, true)                        
                                        NetworkSetNetworkIdDynamic(netid, true)                        
                                        SetNetworkIdCanMigrate(netid, false)                        
                                        if mythic_action.propTwo.bone == nil then                            
                                            mythic_action.propTwo.bone = 60309                       
                                        end                        
                                        
                                        if mythic_action.propTwo.coords == nil then                            
                                            mythic_action.propTwo.coords = { x = 0.0, y = 0.0, z = 0.0 }                       
                                        end                        
                                         
                                        if mythic_action.propTwo.rotation == nil then                            
                                            mythic_action.propTwo.rotation = { x = 0.0, y = 0.0, z = 0.0 }                       
                                        end                        
                                        AttachEntityToEntity(modelSpawn, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), mythic_action.propTwo.bone), 
                                        mythic_action.propTwo.coords.x, mythic_action.propTwo.coords.y, mythic_action.propTwo.coords.z, mythic_action.propTwo.rotation.x, mythic_action.propTwo.rotation.y, mythic_action.propTwo.rotation.z, 1, 1, 0, 1, 0, 1)                        
                                        propTwo_net = netid                        
                                        isPropTwo = true                    
                                    end                
                                end                
                                
                                DisableActions(PlayerPedId())            
                            end            
                            Citizen.Wait(0)        
                        end    
                    end)
                end 
                function loadAnimDict(dict)
                    while (not HasAnimDictLoaded(dict)) do 
                        RequestAnimDict(dict)
                    Citizen.Wait(5) 
                end 
            end 
            
            function DisableActions(ped)    
                if mythic_action.controlDisables.disableMouse then        
                    DisableControlAction(0, 1, true) -- LookLeftRight        
                    DisableControlAction(0, 2, true) -- LookUpDown        
                    DisableControlAction(0, 106, true) -- VehicleMouseControlOverride    
                end    
                
                if mythic_action.controlDisables.disableMovement then        
                    DisableControlAction(0, 30, true) -- disable leftright        
                    DisableControlAction(0, 31, true) -- disable forwardback       
                     DisableControlAction(0, 36, true) -- INPUT_DUCK        
                     DisableControlAction(0, 21, true) -- disable sprint        
                     DisableControlAction(0, 40, true) -- disable sprint   
                    end    
                    if mythic_action.controlDisables.disableCarMovement then        
                        DisableControlAction(0, 63, true) -- veh turn left        
                        DisableControlAction(0, 64, true) -- veh turn right        
                        DisableControlAction(0, 71, true) -- veh forward        
                        DisableControlAction(0, 72, true) -- veh backwards        
                        DisableControlAction(0, 75, true) -- disable exit vehicle    
                    end    if mythic_action.controlDisables.disableCombat then        
                        DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing        
                        DisableControlAction(0, 24, true) -- disable attack        
                        DisableControlAction(0, 25, true) -- disable aim        
                        DisableControlAction(1, 37, true) -- disable weapon select        
                        DisableControlAction(0, 47, true) -- disable weapon        
                        DisableControlAction(0, 58, true) -- disable weapon        
                        DisableControlAction(0, 140, true) -- disable melee        
                        DisableControlAction(0, 141, true) -- disable melee        
                        DisableControlAction(0, 142, true) -- disable melee        
                        DisableControlAction(0, 143, true) -- disable melee        
                        DisableControlAction(0, 263, true) -- disable melee        
                        DisableControlAction(0, 264, true) -- disable melee        
                        DisableControlAction(0, 257, true) -- disable melee        
                        DisableControlAction(0, 289, true) -- f2    
                    end 
                end 
                
                RegisterNUICallback('actionFinish', function(data, cb)    -- Do something here    
                    isDoingAction = false    
                    TriggerEvent("FC_Progbar:client:actionCleanup")    
                    cb('ok')
                end)
                
                RegisterNUICallback('actionCancel', function(data, cb)    -- Do something here    
                    cb('ok')
                end)
                
                function IsDoingAction()    
                    return isDoingActionend
                end
