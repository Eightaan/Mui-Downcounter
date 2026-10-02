if MUIMenu and MUIMenu:ClassEnabled("MUITeammate") then
	local function set_down_visibility(self)
		if not self._mui_down_text then
			return
		end

	    local current_revives = self._revives or 4
		local has_downs = current_revives ~= 1
		local player = self._main_player and self._muiRevL
		local team = self._muiRevS and not self._main_player

		local visible = team or player
		local show_downs = has_downs and not self._custardy and not self._ai

		self._mui_down_text:set_text(current_revives - 1)
		self._info_list:set_visible_panel(self._mui_down_text, visible and show_downs)
	end

	Hooks:PostHook(MUITeammate, "create_info_list", "MUI_Down_Panel_create_info_list", function(self, ...)
		self._mui_down_text = self._info_list:text({
			vertical = "center",
			align = "center",
			visible = false,
			font = self._font
		})
	end)

	Hooks:PostHook(MUITeammate, "set_revives", "MUI_Down_Panel_set_revives", function(self, revives)
		if self._mui_down_text then
			self._mui_down_text:set_text(revives - 1)
			set_down_visibility(self)
		end
	end)

	Hooks:PostHook(MUITeammate, "set_health", "MUI_Down_Panel_set_health", function(self, ...)
		if self._mui_down_text then
			set_down_visibility(self)
		end
	end)

	Hooks:PostHook(MUITeammate, "set_condition", "MUI_Down_Panel_set_condition", function(self, ...)
		if self._mui_down_text then
			set_down_visibility(self)
		end
	end)
	
	Hooks:PostHook(MUITeammate, "resize", "MUI_Down_Panel_resize", function(self)
		if self._mui_down_text then
			set_down_visibility(self)
		end
	end)
	
	Hooks:PostHook(MUITeammate, "set_ai", "MUI_Down_Panel_set_ai", function(self, ...)
		set_down_visibility(self)
	end)
end