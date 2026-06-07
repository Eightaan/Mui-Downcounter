if ArmStatic and MUIMenu and MUIMenu:ClassEnabled("MUITeammate") and MUIMenu:ClassEnabled("MUILegend") and MUIMenu:ClassEnabled("AnimatedList") then
	Hooks:PostHook(MUITeammate, "create_info_list", "MUI_Down_Panel_create_info_list", function(self, ...)
		self._mui_down_text = self._info_list:text({
			vertical = "center",
			align = "center",
			visible = false,
			font = self._font
		})
	end)

	Hooks:PostHook(MUITeammate, "set_revives", "MUI_Down_Panel_set_revives", function(self, revives)
		self._mui_down_text:set_text(revives - 1)
		self:set_down_visibility()
	end)

	Hooks:PostHook(MUITeammate, "set_health", "MUI_Down_Panel_set_health", function(self, ...)
		self:set_down_visibility()
	end)

	function HUDTeammate:set_down_visibility()
		local has_downs = self._revives ~= 1
		local player = self._main_player and self._muiRevL
		local team = self._muiRevS and not self._main_player
		local visible = team or player
		local show_downs = has_downs and not self._custardy
		self._info_list:set_visible_panel(visible and self._mui_down_text, show_downs)
	end
end