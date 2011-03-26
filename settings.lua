function courseplay:change_ai_state(self, change_by)
  self.ai_mode = self.ai_mode + change_by

  if self.ai_mode == 5 or self.ai_mode == 0 then  
    self.ai_mode = 1    
  end
end

function courseplay:switch_hud_page(self, change_by)
  self.showHudInfoBase = self.showHudInfoBase + change_by
  if self.showHudInfoBase == 0 then  --edit for more sites
    self.showHudInfoBase = 1
   end

   if self.showHudInfoBase == 6 then  --edit for more sites
     self.showHudInfoBase = 5
   end
end


function courseplay:change_combine_offset(self, change_by)
  self.combine_offset = self.combine_offset + change_by
  
  if self.combine_offset < 0 then
    self.combine_offset = 0
  end
  
  if self.chopper_offset > 0 then
    self.chopper_offset = self.combine_offset
  else
    self.chopper_offset = self.combine_offset * -1
  end
  
end

function courseplay:change_tipper_offset(self, change_by)
  self.tipper_offset = self.tipper_offset + change_by

end



function courseplay:change_required_fill_level(self, change_by)
   self.required_fill_level_for_follow = self.required_fill_level_for_follow + change_by
  
  if self.required_fill_level_for_follow < 0 then
    self.required_fill_level_for_follow = 0
  end
  
  if self.required_fill_level_for_follow > 100 then
    self.required_fill_level_for_follow = 100
  end
end


function courseplay:change_turn_radius(self, change_by)
   self.turn_radius = self.turn_radius + change_by
   
   if self.turn_radius < 0 then
    self.turn_radius = 0
  end
end


function courseplay:change_turn_speed(self, change_by)
  local speed = self.turn_speed * 3600
  
  speed = speed + change_by
  
  if speed < 1 then
    speed = 1
  end
  self.turn_speed = speed / 3600
end

function courseplay:change_field_speed(self, change_by)
  local speed = self.field_speed * 3600
  speed = speed + change_by
  if speed < 1 then
    speed = 1
  end
  self.field_speed = speed / 3600
end

function courseplay:change_max_speed(self, change_by)
  local speed = self.max_speed * 3600
  speed = speed + change_by
  if speed < 1 then
    speed = 1
  end
  self.max_speed = speed / 3600
end


function courseplay:switch_search_combine(self)
  self.search_combine = not self.search_combine
end

function courseplay:switch_combine(self, change_by)
  local combines = courseplay:find_combines(self)
  
  local selected_combine_number = self.selected_combine_number + change_by
  
  if selected_combine_number < 0 then
    selected_combine_number = 0
  end
  
  if selected_combine_number > table.getn(combines) then
    selected_combine_number = table.getn(combines)
  end
  
  self.selected_combine_number = selected_combine_number
  
  if self.selected_combine_number == 0 then
  	self.saved_combine = nil
  else
    self.saved_combine = combines[self.selected_combine_number]
  end
  
end