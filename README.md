```
        TriggerEvent("FC_Progbar:client:progress", {
    	name = "NAME",    
    	duration = TIME,    
    	label = "LABEL",    
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
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
```

![This is an image](https://cdn.discordapp.com/attachments/1045372470816940052/1046150370738585682/image.png)
