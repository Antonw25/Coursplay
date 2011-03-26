
function courseplay:detachImplement(implementIndex)
  self.tools_dirty = true
end

function courseplay:reset_tools(self)
  self.tippers = {}
  -- are there any tippers?	
  self.tipper_attached = courseplay:update_tools(self, self)
  self.tools_dirty = false;
end


-- update implements to find attached tippers
function courseplay:update_tools(self, tractor_or_implement)    
  local tipper_attached = false
  -- go through all implements
  for k,implement in pairs(tractor_or_implement.attachedImplements) do
    
    local object = implement.object
    
    if object.allowTipDischarge then
      tipper_attached = true
      table.insert(self.tippers, object)
    end
    
	-- are there more tippers attached to the current implement?
    if table.getn(object.attachedImplements) ~= 0 then	  
      courseplay:update_tools(self, object)
    end
  end
  if tipper_attached then
    return true
  end
  return nil
end


-- loads all tippers
function courseplay:load_tippers(self)
  local allowedToDrive = false
  local cx ,cz = self.Waypoints[2].cx,self.Waypoints[2].cz
  
  if self.currentTrailerToFill == nil then
	self.currentTrailerToFill = 1
  end

  if self.lastTrailerToFillDistance == nil then
  
	  local current_tipper = self.tippers[self.currentTrailerToFill] 
	  
	  -- drive on if actual tipper is full
	  if current_tipper.fillLevel == current_tipper.capacity then    
		if table.getn(self.tippers) > self.currentTrailerToFill then			
			local tipper_x, tipper_y, tipper_z = getWorldTranslation(self.tippers[self.currentTrailerToFill].rootNode)			
			
			self.lastTrailerToFillDistance = courseplay:distance(cx, cz, tipper_x, tipper_z)
			
			self.currentTrailerToFill = self.currentTrailerToFill + 1
		else
			self.currentTrailerToFill = nil
			self.lastTrailerToFillDistance = nil
		end
		allowedToDrive = true
	  end  
  
  else
    local tipper_x, tipper_y, tipper_z = getWorldTranslation(self.tippers[self.currentTrailerToFill].rootNode)
    
	local distance = courseplay:distance(cx, cz, tipper_x, tipper_z)

	if distance > self.lastTrailerToFillDistance and self.lastTrailerToFillDistance ~= nil then	
		allowedToDrive = true
	else	  
	  allowedToDrive = false
	  local current_tipper = self.tippers[self.currentTrailerToFill] 
	  if current_tipper.fillLevel == current_tipper.capacity then    
		  if table.getn(self.tippers) > self.currentTrailerToFill then			
				local tipper_x, tipper_y, tipper_z = getWorldTranslation(self.tippers[self.currentTrailerToFill].rootNode)			
				self.lastTrailerToFillDistance = courseplay:distance(cx, cz, tipper_x, tipper_z)
				self.currentTrailerToFill = self.currentTrailerToFill + 1
			else
				self.currentTrailerToFill = nil
				self.lastTrailerToFillDistance = nil
			end	  
		end
	end
	
   end
  
  -- normal mode if all tippers are empty
  
  return allowedToDrive
end

-- unloads all tippers
function courseplay:unload_tippers(self)
  local allowedToDrive = false
  local active_tipper = nil
  local trigger = self.currentTipTrigger
  -- drive forward until actual tipper reaches trigger
  
    -- position of trigger
    local trigger_id = self.currentTipTrigger.triggerId
	    
    if self.currentTipTrigger.specialTriggerId ~= nil then
      trigger_id = self.currentTipTrigger.specialTriggerId
    end
    local trigger_x, trigger_y, trigger_z = getWorldTranslation(trigger_id)
    
    -- tipReferencePoint of each tipper    
    for k,tipper in pairs(self.tippers) do 
		if tipper.fillLevel > 0 then
			local tipper_x, tipper_y, tipper_z = getWorldTranslation(tipper.tipReferencePoint)
			local distance_to_trigger = Utils.vector2Length(trigger_x - tipper_x, trigger_z - tipper_z)

			--g_currentMission.tipTriggerRangeThreshold = 2;
		 
			--print(self.oldDistance - distance_to_trigger);
			if distance_to_trigger < self.oldDistance then
				self.oldDistance = distance_to_trigger;
				--print(distance_to_trigger);
			end;
			

			-- if tipper is on trigger
				-- if distance_to_trigger <= g_currentMission.tipTriggerRangeThreshold then
					-- active_tipper = tipper;
				-- end;  
				
			if distance_to_trigger > self.oldDistance and distance_to_trigger < 10 then
				active_tipper = tipper;
				g_currentMission.tipTriggerRangeThreshold = distance_to_trigger + 0.5;
			end;
		end;
	end; 
    
  if active_tipper then    
	local trigger = self.currentTipTrigger
	-- if trigger accepts fruit
	--print('In Trigger');
	if (trigger.acceptedFruitTypes ~= nil and trigger.acceptedFruitTypes[active_tipper:getCurrentFruitType()]) or trigger.className == "MapBGASilo" then
		allowedToDrive = false
	else
		allowedToDrive = true
	end
  else
    allowedToDrive = true
  end 
  
  return allowedToDrive, active_tipper
end